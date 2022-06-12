---
layout: post
title: Commanding Paperspace Gradient
date: 2022-06-01 12:32:04 -0500
category: Tutorials
description: I recently switched from Google Colab to Paperspace Gradient. I had
    some trouble getting into the workflow, but here are some useful things I found.
---
# Updated: {{ page.title }}

**UPDATE: Don't do this. My Paperspace account got terminated. Whoops.**

I recently switched from Google Colab to Paperspace Gradient. I had some trouble
getting used to the environment. With a homebrewed Jupyter implementation that
isn't great, JupyterLab - while being an improvement on Jupyter Notebook - lacks proper
support for code completion, and VS Code remote Jupyter session. While they have
support for launching a remote VS Code Jupyter kernel, this doesn't allow me to
interact with the remote filesystem the way JupyterLab does.

When I was using Google Colab, I played around with the package
[`colab_ssh`](https://github.com/WassimBenzarti/colab-ssh) which is a useful
library/applet for setting up a Remote SSH session through VS Code, which allows
you to run your Jupyter Notebooks on the remote host. I learned after
experimenting with it that [it has been successfully tested
with Gradient](https://github.com/WassimBenzarti/colab-ssh#notice) and it works!

Now I don't want to have to `pip install colab_ssh` every time and hell(!), I
don't want to `pip install jax` and upgrade all the packages. Now as I
discovered (and I believe is documented), you can spin up custom Docker images 
for your machine! So now I've [created a Docker image with all 
those things!](https://hub.docker.com/r/frederickgeek8/gradient). Of course you
can spin off your own (I used NVIDIA's PyTorch image as my base), and for your
convenience, I posted my source code 
[here](https://github.com/FrederickGeek8/gradient-space).

This is the first full Docker image I've created, so constructive criticism is
welcome -- I'm always looking to up my game.

## The Nitty Gritty

My Dockerfile is pretty simple:

`Dockerfile`
```docker
FROM nvcr.io/nvidia/pytorch:21.04-py3
LABEL Name=paperspace Version=0.0.1
RUN mkdir -p /setup /notebooks
COPY . /setup
RUN /setup/install_deps.sh
COPY ssh_colab.ipynb /notebooks
CMD ["bash", "-c", "/setup/startup.sh"]
```
First we build off of the PyTorch image from NVIDIA. Then it will install
our updated Python, etc. dependencies. When the image starts up, a JupyerLab
session opens with the parameters provided by Gradient.

`install_deps.sh`
```bash
#!/bin/sh
pip install -U pip
pip install -r /setup/requirements.txt
```

`startup.sh`
```bash
#!/bin/sh
jupyter lab --allow-root --ip=0.0.0.0 --no-browser --LabApp.trust_xheaders=True --LabApp.disable_check_xsrf=False --LabApp.allow_remote_access=True --LabApp.allow_origin='*'
```

## The Future
One thing that this could be expanded into is automatically mounting cloud
storage using [`rclone`](https://rclone.org/). That is, if they don't follow
Google Colab's new restrictions on using [`rclone`](https://rclone.org/) (or so
I've heard... I can't find the source).

*See you space cowfolk...*