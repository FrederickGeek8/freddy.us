---
layout: post
title: "Life Hack: A Trivial Outer Product Expansion"
date: 2026-04-13 23:00:00 -0400
category: microposts
description: If you're in a pinch, this one simple trick can give you two trivial outer product expansions for any given matrix.
usemath: true
post_id: trivial-outer-product
---

_Note:_ This is a follow-up to my previous post ["Outer Products: The Dual View of Linear Algebra"](/blog/posts/outer-products/). It might be worth checking that post out if you'd like more of a background on what outer products are, and why I think they're neat.

---

Let's say you're under pressure to do some quick math -- maybe about to save the world from some doomsday plot or villain -- and in order to defeat this villain you need to decompose some matrix you are handed into a sum of outer products. Luckily for you, you read this blog post just last week, and you know that there are two trivial decomposition of _any_ matrix into a sum of outer products.

You already know that any matrix multiplication between two matrices can be rewritten as a sum over the outer product of the columns of the left matrix (denoted $\bm{a}\_i^{\text{col}}$) with the rows of the right matrix (denoted $\bm{b}\_i^{\text{row}}$):

$$
\mathbf{C} = \mathbf{AB} = 
\begin{bmatrix}
\bm{a}_1^{\text{col}} & \cdots & \bm{a}_p^{\text{col}}
\end{bmatrix}
\begin{bmatrix}
\bm{b}_1^{\text{row}} \\
\vdots \\
\bm{b}_p^{\text{row}}
\end{bmatrix}
=
\sum_{k = 1}^p \bm{a}_k^{\text{col}} \otimes [\bm{b}_k^{\text{row}}]^\top
$$

While this doesn't immediately tell you how to decompose a _single_ matrix into outer products, there is one simple trick we can use to apply that result. The trick is multiplying (on either side) the _identity matrix_. So, two answers to whatever weird riddle you've been given in this scenario are:

$$
\mathbf{W}\mathcal{I} = 
\begin{bmatrix}
\bm{w}_1^{\text{col}} & \cdots & \bm{w}_m^{\text{col}}
\end{bmatrix}
\begin{bmatrix}
\bm{e}_1^{\text{row}} \\
\vdots \\
\bm{e}_m^{\text{row}}
\end{bmatrix}
=
\sum_{k = 1}^m \bm{w}_k^{\text{col}} \otimes [\bm{e}_k^{\text{row}}]^\top
$$

and

$$
\mathcal{I}\mathbf{W} = 
\begin{bmatrix}
\bm{e}_1^{\text{col}} & \cdots & \bm{e}_n^{\text{col}}
\end{bmatrix}
\begin{bmatrix}
\bm{w}_1^{\text{row}} \\
\vdots \\
\bm{w}_n^{\text{row}}
\end{bmatrix}
=
\sum_{k = 1}^n \bm{e}_k^{\text{col}} \otimes [\bm{w}_k^{\text{row}}]^\top
$$

Where $\bm{e}_i$ is the $i$th row or column of the identity matrix $\mathcal{I}$.

One way of framing what this trivial decomposition does is it "paints in" the matrix $\mathbf{M}$ row-wise or column wise. Recalling the following visual from my previous post (pasted below), taking the outer product with the identity matrix row/column "paints in" whatever the other vector is into the resulting matrix.

<div class="invertable">
$$
x \otimes y =

\begin{bmatrix}
\color{green} x_1 \\
\color{red} x_2 \\
\vdots \\
\color{blue} x_n
\end{bmatrix}

\begin{bmatrix}
y_1 & y_2 & \cdots & y_n
\end{bmatrix}

= 

\begin{bmatrix}
{\color{green} x_1} y_1 & {\color{green} x_1} y_2 & \cdots & {\color{green} x_1} y_n \\
{\color{red} x_2} y_1 & {\color{red} x_2} y_2 & \cdots &  {\color{red} x_2} y_2 \\
\vdots & \vdots & \ddots & \vdots \\
{\color{blue} x_n} y_1 & {\color{blue} x_n} y_2 & \cdots & {\color{blue} x_n} y_n
\end{bmatrix}
$$
</div>

If $x$ (above) is replaced with the vector from the identity matrix, then each term of the summation is adding one _row_ to our matrix $\mathbf{M}$. If $y$ is replaced with the vector from the identity matrix instead, then each term of the summation is adding one _column_ to our matrix.

Neat!
