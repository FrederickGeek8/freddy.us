---
layout: post
title: Enabling S3 Sleep on a Dell Vostro 3500
date: 2026-05-15
category: Tutorials
description: I enabled S3 (Deep) Sleep support on my Dell Vostro 3500 running Linux, despite the corresponding BIOS options being removed by Dell. Here is how you can do it too.
tags: [tutorial, linux]
post_id: dell-s3-sleep
---

<u markdown="1"><strong>Warning:</strong></u> These instructions should not be followed blindly since misconfiguration <u>could leave your system in a broken state</u>. The method used for enabling S3 Sleep on my Dell laptop was achieved through patching the stock [DSDT ACPI Table](https://wiki.archlinux.org/title/DSDT) provided by my system. DSDT tables are hardware-specific, so yours may very well be different from mine. You will also need to fix DSDT again after each BIOS update and repeat these steps! <u>Use these methods at your own risk. I bear no liability for anything that goes wrong.</u>

As a sneak peek, the "real" change is quite simple, at least on my model. Just change a `Zero` to a `One` in a "`SS3`" variable and Linux will recognize the system as supporting S3 (deep) sleep.

```diff
-    Name (SS3, Zero)
+    Name (SS3, One)
```

**Before embarking on this guide**, you should probably double-check: does your system already support/advertise S3 (deep) sleep? If the output of the `cat /sys/power/mem_sleep` command contains "deep", then _your system already supports S3 sleep_ and you should **not** follow this guide. There are many resources elsewhere for _enabling_ deep sleep on hardware supporting it, such as via setting the `mem_sleep_default` GRUB parameter.

This guide has been tested on Ubuntu 24.04, however all instructions (except for those for installing the patched DSDT file) should be distro-agnostic. **DSDT tables are _hardware_-specific, however, and should not be used on hardware that does not exactly match my own.** Given the risky nature of DSDT patching, I will emphasize the non-portability of my complete patch several times in this post. Apologies in advance for that repetitiveness. 

### Table of Contents
{:.no_toc}
* TOC
{:toc}


### Fetching your system's DSDT Table

**Assuming you have _not_ installed a custom DSDT table yet**, you can get your system's reported DSDT table by running the command

```bash
cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
```

To know whether my results will translate exactly, the command `sha256sum dsdt.dat` should match my output exactly

```
; sha256sum dsdt.dat 
bf9e3180184d40ee16d52d64cb29dc7820fac59163975c28483e49accba43789  dsdt.dat
```

If the hashes _do not_ match, don't dismay. You may still find this guide insightful, but you should not apply my patches as-is.

### Disassembly, Reassembly, Patching Errors

To begin, disassemble the `dsdt.dat` binary to a `.dsl` file with the command:

```bash
iasl -d dsdt.dat
```

which should produce a `dsdt.dsl` file.

It is possible that your DSDT table ships with bugs that prevent re-compilation. We first should check for and fix any compilation errors that occur. Compile the disassembled `.dsl` file with the command:

```bash
iasl -tc dsdt.dsl
```

If there are errors in the compilation, you will see an error at the bottom reading "No AML files were generated due to compiler error(s)". "Warnings" and "Remarks" are fine, but Errors are fatal.

To find any errors, you can redirect the large output to a file by running `iasl -tc dsdt.dsl &> output.txt` and open it in `less`, and search for lines beginning with "Error". **In my case, I had the following 3 Errors:**

```
dsdt.dsl     85:     External (_SB_.PC00.LPCB.ECDV.CMFC.DLPN, UnknownObj)
Error    6163 -                                           ^ Object is created temporarily in another method and cannot be accessed (_SB_.PC00.LPCB.ECDV.CMFC.DLPN)

dsdt.dsl     86:     External (_SB_.PC00.LPCB.ECDV.CMFC.IDMN, UnknownObj)
Error    6163 -                                           ^ Object is created temporarily in another method and cannot be accessed (_SB_.PC00.LPCB.ECDV.CMFC.IDMN)

dsdt.dsl     87:     External (_SB_.PC00.LPCB.ECDV.CMFC.IDPC, UnknownObj)
Error    6163 -                                           ^ Object is created temporarily in another method and cannot be accessed (_SB_.PC00.LPCB.ECDV.CMFC.IDPC)
```

You will need to fix all issues in the `dsdt.dsl` file to proceed. To fix **my** errors, I deleted the following 3 lines problematic lines:

```diff
@@ -82,9 +82,6 @@ DefinitionBlock ("", "DSDT", 2, "DELL  ", "Dell Inc", 0x00000002)
     External (_SB_.PC00.ITSP, UnknownObj)
     External (_SB_.PC00.LPCB.ECDV.ACOS, DeviceObj)
     External (_SB_.PC00.LPCB.ECDV.ACSE, DeviceObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.DLPN, UnknownObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.IDMN, UnknownObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.IDPC, UnknownObj)
     External (_SB_.PC00.LPCB.ECDV.DPNT, MethodObj)    // 0 Arguments
```

Running `iasl -tc dsdt.dsl` again runs with no errors.

### Enabling S3 Sleep Support

After fixing the compilation bugs of the stock Dell ACPI table, there is a single-line change that enables S3 sleep support on my system, namely changing this variable's value from `Zero` to `One`:
```diff
-    Name (SS3, Zero)
+    Name (SS3, One)
```

which now activates the block later in the `dsl` file:
```
    If (SS3)
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            0x05, 
            Zero, 
            Zero, 
            Zero
        })
    }
```

If your `.dat` hash did not match mine, but your `.dsl` file contains the `SS3` variable definition and a similar `if` block to the above, then you may be in luck! It might be worth making that single-line change in your `.dsl` too.

**One more patch is necessary** -- incrementing the version number in the "DefinitionBlock" near the top of the file, so that the patched version is preferred over the OEM. My OEM version is "2" and I have now incremented it to "3":

```diff
-DefinitionBlock ("", "DSDT", 2, "DELL  ", "Dell Inc", 0x00000002)
+DefinitionBlock ("", "DSDT", 2, "DELL  ", "Dell Inc", 0x00000003)
```

### My Final Patch File

<u><strong>Caution:</strong></u> **This patch will likely not work on your system without modification.** You can double-check your sha256 hash of your raw `.dat` file with:

```
; sha256sum dsdt.dat 
bf9e3180184d40ee16d52d64cb29dc7820fac59163975c28483e49accba43789  dsdt.dat
```

If the hash does not match, _do not apply my patch_. You can follow the rationale that informed the creation of my patch file (as outlined in the previous sections) to help you craft your own patch file, as long as your `.dsl` is not _too_ different from mine.

Below is the complete `.dsl` patch from my system, which can be applied with the command `patch < /path/to/patch/file` (assuming you are in the directory containing your `dsdt.dsl` file). I have also included the patch file below for download here: [dsdt.dsl.patch](/assets/per-post/dell-s3-sleep/dsdt.dsl.patch)
```diff
--- dsdt.dsl
+++ dsdt.dsl	2026-05-14 20:45:53.215975289 -0400
@@ -18,7 +18,7 @@
  *     Compiler ID      "    "
  *     Compiler Version 0x01000013 (16777235)
  */
-DefinitionBlock ("", "DSDT", 2, "DELL  ", "Dell Inc", 0x00000002)
+DefinitionBlock ("", "DSDT", 2, "DELL  ", "Dell Inc", 0x00000003)
 {
     External (_GPE.AL6F, MethodObj)    // 0 Arguments
     External (_GPE.HLVT, MethodObj)    // 0 Arguments
@@ -82,9 +82,6 @@
     External (_SB_.PC00.ITSP, UnknownObj)
     External (_SB_.PC00.LPCB.ECDV.ACOS, DeviceObj)
     External (_SB_.PC00.LPCB.ECDV.ACSE, DeviceObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.DLPN, UnknownObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.IDMN, UnknownObj)
-    External (_SB_.PC00.LPCB.ECDV.CMFC.IDPC, UnknownObj)
     External (_SB_.PC00.LPCB.ECDV.DPNT, MethodObj)    // 0 Arguments
     External (_SB_.PC00.LPCB.ECDV.ECS2, MethodObj)    // 2 Arguments
     External (_SB_.PC00.LPCB.ECDV.ECS3, MethodObj)    // 0 Arguments
@@ -601,7 +598,7 @@
 
     Name (SS1, Zero)
     Name (SS2, Zero)
-    Name (SS3, Zero)
+    Name (SS3, One)
     Name (SS4, One)
     OperationRegion (GNVS, SystemMemory, 0x63904000, 0x0A95)
     Field (GNVS, AnyAcc, Lock, Preserve)
```

### Compiling and Installing the Patched DSDT File

Compiling your new DSDT table is the same as before:
```bash
iasl -tc dsdt.dsl
```

**This should produce no Errors.** After running the command, you should have a `dsdt.aml` file which you can now install.

I will largely leave the installation of the DSL file up to you. The Arch Wiki has a good guide on how to do this: [https://wiki.archlinux.org/title/DSDT#Using_modified_code](https://wiki.archlinux.org/title/DSDT#Using_modified_code). I personally followed their ["Using a CPIO archive"](https://wiki.archlinux.org/title/DSDT#Using_a_CPIO_archive) instructions to get the modified table installed on my Ubuntu 24.04 system.

When you boot back into Linux after install the patched `.aml` file, `cat /sys/power/mem_sleep` should now show `[s2idle] deep`. Meaning that `deep` sleep is _supported_ but not _enabled_ (the `[]` brackets indicate the enabled option). There are a few ways to enable S3 sleep by default, but if you are a GRUB user, adding `mem_sleep_default=deep` to your `/etc/default/grub` and running `sudo update-grub` should enable S3 sleep!

You should now be done! If you added `mem_sleep_default=deep` to your GRUB config, then S3 sleep should be enabled on your next reboot. You can temporarily enable deep sleep without rebooting via the command `echo deep > /sys/power/mem_sleep` in a `su` prompt. When cycling between suspend and resume, you can test that you are entering S3 sleep by running `journalctl -k -b -0 | grep "S3\|deep"`. If all goes well, you should see something like this.

```bash
; journalctl -k -b -1 | grep "S3\|deep"

May 14 20:54:38 fredux kernel: ACPI: PM: (supports S0 S3 S4 S5)
May 14 20:55:37 fredux kernel: PM: suspend entry (deep)
May 14 20:55:54 fredux kernel: ACPI: PM: Preparing to enter system sleep state S3
May 14 20:55:54 fredux kernel: ACPI: PM: Waking up from system sleep state S3
May 14 20:56:24 fredux kernel: PM: suspend entry (deep)
May 14 20:56:38 fredux kernel: ACPI: PM: Preparing to enter system sleep state S3
May 14 20:56:38 fredux kernel: ACPI: PM: Waking up from system sleep state S3
May 14 20:57:17 fredux kernel: PM: suspend entry (deep)
May 14 21:03:32 fredux kernel: ACPI: PM: Preparing to enter system sleep state S3
May 14 21:03:32 fredux kernel: ACPI: PM: Waking up from system sleep state S3
May 14 21:04:02 fredux kernel: PM: suspend entry (deep)
May 14 21:09:38 fredux kernel: ACPI: PM: Preparing to enter system sleep state S3
May 14 21:09:38 fredux kernel: ACPI: PM: Waking up from system sleep state S3
May 14 21:48:29 fredux kernel: PM: suspend entry (deep)
May 14 21:52:40 fredux kernel: ACPI: PM: Preparing to enter system sleep state S3
May 14 21:52:40 fredux kernel: ACPI: PM: Waking up from system sleep state S3
```

### Epilogue

Did this work for your Dell Vostro 3500? Did you see a "one-line" fix similar to mine? Leave a comment below!

I also appreciate any feedback on this post, or any edits you suggest I make. I am very new to ACPI tinkering, with experience only through working with the [T2 Linux](https://wiki.t2linux.org/) folks, so please correct me if I got something wrong! Given the hardware-specificity of my patch, it is tough for me to provide general support for enabling S3 sleep on Dell machines, so apologies if I don't reply to all comments asking for support.

Thanks for reading! I hope this guide helped you.
