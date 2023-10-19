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
exercise came from. I think there a couple fun spins you can put on this
problem once you understand it too.

## Problem Statement

Suppose you have a set of **unknown** size $n$ consisting of
**unknown** non-negative integers less that $2^k$ for a **known** integer $k$.
Your only acceptable query operation is to query a given $O(1)$ oracle
$\mathcal{O}$ which will, upon numeric input $\alpha$ return one of three
values:

$$
    \mathcal{O}(\alpha) =
    \begin{cases} >1 & \text{if there is more than one element in the set less than } \alpha \\
    1 & \text{if there is exactly one element less than } \alpha \textbf{ and the element} \\
    & \textbf{is removed from the set} \\
    0 & \text{if there does not exist any number in the set less than } \alpha
    \end{cases}
$$

Can you think of an efficient algorithm to determine $n$? What is its
**worse-case** time complexity? Hint: Design an algorithm that provably runs in
$O(nk)$. Can you improve this bound?
<br><br>

<details>
<summary>Answer Key (Try to solve the problem first!)</summary>
<div markdown=1>
We can frame this problem as trying to find $n$ elements in a sorted list of
size $2^k$. We can use the oracle $\mathcal{O}$ to find each of the $n$ elements
included in the set by applying binary search $n$ times with the following
criteria:

1. $\mathcal{O}(\alpha) = 1$: found an element -- exit and add $1$ to our size counter
2. $\mathcal{O}(\alpha) > 1$: go left -- decrease our guess $\alpha$
3. $\mathcal{O}(\alpha) = 0$: go right -- increase our guess $\alpha$

At each element counted, we can then check $\mathcal{O}(2^k) = 0$ to ensure
that the set has been exhausted and we have found the correct size $n$.

We can calculate the time complexity of this algorithm based on our knowledge
of binary search. Recall that the time complexity of finding a single element
in an sorted list of size $m$ is $\log(m)$ using binary search. Given the
problem statement and our new algorithm, we have that the time complexity of
finding the set size $n$ is:

$$
\begin{aligned}
    &O(\log (2^k) + \log (2^k - 1) + \log (2^k - 2) + \cdots + \log (2^k - n)) \\
    &< O(n \log (2^k)) \\
    &= O(nk)
\end{aligned}
$$

Note that we omit the $n$ $O(1)$ queries that are required to check whether the
set has been exhausted. This should be "negligible" in the eyes of Big O
notation.

I do not have an answer to "Can you improve this bound?" question at this
moment. I will not be working on this problem going forward, but if you have an
improved algorithm &amp; bound I'll gladly post it here!

</div>
</details>
