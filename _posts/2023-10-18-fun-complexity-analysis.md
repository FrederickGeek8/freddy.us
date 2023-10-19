---
layout: post
title: A Fun Complexity Analysis Problem
date: 2023-10-18 19:00:00 -0400
category: CS
description:
  Back in 2020 a question was posed to me about deriving a bound for the
  computational complexity of querying an O(1) oracle to determine the size of
  an unknown set of bounded non-negative integers. I thought perhaps the
  internet would get some enjoyment out of this exercise.
usemathjax: true
---

# {{ page.title }}

A while ago a friend (although I do not know who) posed to me a time complexity
analysis problem that I found very interesting. Back then I wrote up a LaTeX
document of the problem, as well as a solution, and sent it around to a bunch
of my friends who liked Computer Science and Math. I thought it was a rather
fun problem but no one I knew tried to solve it. Perhaps the internet would be
interested in this sort of problem. As of right now, I have no idea where this
problem came from.

## Problem Statement

Suppose you have an ordered set of **unknown** size $n$ consisting of
**unknown** non-negative integers less that $2^k$ for a **known** $k$. Your
only acceptable query operation is to query a given $O(1)$ oracle $\mathcal{O}$
which will, upon integer input $\alpha$ return one of three values:

$$
    \mathcal{O}(\alpha) =
    \begin{cases} >1 & \text{if there are more than one elements in the set less than } \alpha \\
    1 & \text{if there is exactly one element less than } \alpha \textbf{ and the element} \\
    & \textbf{is removed from the set} \\
    0 & \text{if there does not exist any number in the set less than } \alpha
    \end{cases}
$$

What is the **worse-case** time complexity to determine $n$? Hint: Design an
algorithm that provably runs in $O(kn)$. Can you improve this bound?
<br><br>

<details>
<summary>Answer Key (Try to solve the problem first!)</summary>
<div markdown=1>
We can frame this problem of trying to find $n$ elements in a list of size 
$2^k$. We can use the oracle to find each $n$ elements included in the set.

Use binary search with the following criteria

1. $\mathcal{O}(\alpha) = 1$: found an element
2. $\mathcal{O}(\alpha) > 1$: go left
3. $\mathcal{O}(\alpha) = 0$: go right

using this algorithm we can calculate the complexity. Remember that the
complexity of finding a single element in an ordered like of size $m$ is
$\log(m)$. Following the definition of the oracle, we have that the complexity
of finding $n$ is:

$$
\begin{aligned}
    &O(\log (2^k) + \log (2^k - 1) + \log (2^k - 2) + \cdots + \log (2^k - n)) \\
    &< O(n \log (2^k)) \\
    &= O(nk)
\end{aligned}
$$

I do not have an answer to "Can you improve this bound?" question at this
moment. I will not be working on this problem going forward, but if you have an
improved bound I'll gladly post it here!

</div>
</details>
