---
layout: post
title: "Outer Products: The Dual View of Linear Algebra"
category: Math
description: 
tags: [math, tutorial]
usemath: true
date: 2025-10-09
post_id: outer-products
---

I cannot speak for the Linear Algebra education of other's in university, merely my own. However, despite getting what I thought was a good upbringing in Linear Algebra, there was one topic that was missing: **outer products**.

Perhaps this is a casual mention, as it was in my classes, or perhaps they just don't get the same sort of appreciation that inner products to. But as I've grown to know them more, and integrate their "dual view" into more of my analysis, I believe that they have become a fundemental piece of my knowledge of Linear Algebra.

These days, I think it's almost always worth considering the meaning of the outer product dual for any LA problem. Perhaps, if I get the opportunity to teach some undergraduates Linear Algebra in the future, I will design my course to have outer products on similar footing as inner products. For now, I have to resign myself to motivating _you_ through _this blog post_ why outer products are worth thinking about.

### A Brief Refresher of _Inner_ Products

Before explaining the outer product, let me first remind you of the basic definition of an inner product -- which we refer to as the "dot product" is Euclidean space.

Given two vector $u, v \in \mathbb{R}^n$, the dot product between $u$ and $v$, denoted as $u \cdot v$ or $\langle u , v\rangle$ is defined as:

$$
u \cdot v = \langle u , v \rangle = u_1 v_1 + u_2 v_2 + \cdots + u_n v_n \in \mathbb{R}
$$

There are several useful properties of the inner/dot product, [for which Wikipedia is helpful](https://en.wikipedia.org/wiki/Inner_product_space#Basic_properties), but for now it is also useful to introduce the notation of the norm, which measures the _length_ of a vector: $ \Vert u \Vert = \langle u , u \rangle$.

One way of viewing this operation, although it's not entirely clearly immediately, is performing a comparison of the _angle_ between $u$ and $v$. In fact, we can rewrite the dot product as:

$$
\langle u , v \rangle =  \Vert u \Vert \Vert v \Vert  \cos(\theta) \iff \theta = \arccos \left( \frac{\langle u , v \rangle}{\Vert u \Vert \Vert v \Vert} \right)
$$

One simple consequence is that when $u$ and $v$ are perpencicular (also known as "**orthgonal**", with $\theta = 90 \degree$), then $\langle u , v \rangle = 0$.

**Matrix multiplication** is a generalization of the inner product. For matrix-vector products, you take the dot product of the vector with reach row of the matrix -- assuming we are representing the vector as a "column vector".

$$
\begin{bmatrix}
\color{red} a_1 & \color{red} a_2 & \color{red} \cdots & \color{red} a_n \\
b_1 & b_2 & \cdots & b_n \\
\vdots & & \ddots & \vdots \\
z_1 & z_2 & \cdots & z_n
\end{bmatrix}

\cdot 

\begin{bmatrix}
\color{red} x_1 \\
\color{red} x_2 \\
\color{red} \vdots \\
\color{red} x_n 
\end{bmatrix}

=

\begin{bmatrix}
\langle a , x \rangle \\
\langle b , x \rangle \\
\vdots \\
\langle z , x \rangle \\
\end{bmatrix}
$$

Extending this to matrix-matrix products by creating one or more columns in our "vector" is intuitive -- it creates one or more columns in the output:

$$
\begin{bmatrix}
\color{red} a_1 & \color{red} a_2 & \color{red} \cdots & \color{red} a_n \\
b_1 & b_2 & \cdots & b_n \\
\vdots & & \ddots & \vdots \\
z_1 & z_2 & \cdots & z_n
\end{bmatrix}

\cdot 

\begin{bmatrix}
x_1 & \color{red} y_1 \\
x_2 & \color{red} y_2 \\
\vdots & \color{red} \vdots  \\
x_n & \color{red} y_n
\end{bmatrix}

=

\begin{bmatrix}
\langle a , x \rangle & \color{red} \langle a , y \rangle\\
\langle b , x \rangle & \color{red} \langle b , y \rangle \\
\vdots & \color{red} \vdots \\
\langle z , x \rangle & \color{red} \langle z , y \rangle \\
\end{bmatrix}
$$

Looking this back to (vector) inner product, we see that we can represent the inner product as a special case of matrix multiplication! Namely

$$
\langle x , y \rangle = x^T y = 

\begin{bmatrix}
x_1 & x_2 & \cdots & x_n
\end{bmatrix}

\begin{bmatrix}
y_1 \\
y_2 \\
\vdots \\
y_n
\end{bmatrix}
$$

### So What Is An "Outer Product"?

An **outer product** is a small tweak to the equation of the inner (dot) product between two vectors. Instead of writing the inner product as

$$
x \cdot y = x^T y
$$

the **outer product** of two vectors is

$$
x \otimes y = x y^T
$$

While relocating the position of the matrix transpose to $y$ seems like a small modification, it has profound implication. One of the immediate ones is: **the outer product between two vectors gives _a matrix_ output.**

Follow the pattern from above

<div class="invertable">
$$
x \otimes y =

\begin{bmatrix}
\color{green} x_1 \\
\color{red} x_2 \\
\vdots \\
\color{orange} x_n
\end{bmatrix}

\begin{bmatrix}
y_1 & y_2 & \cdots & y_n
\end{bmatrix}

= 

\begin{bmatrix}
{\color{green} x_1} y_1 & {\color{green} x_1} y_2 & \cdots & {\color{green} x_1} y_n \\
{\color{red} x_2} y_1 & {\color{red} x_2} y_2 & \cdots &  {\color{red} x_2} y_2 \\
\vdots & \vdots & \ddots & \vdots \\
{\color{orange} x_n} y_1 & {\color{orange} x_n} y_2 & \cdots & {\color{orange} x_n} y_n
\end{bmatrix}
$$
</div>

There are some particularly interesting properties that are worth mentioning about the outer product:

#### Properties

##### The outer product of two vectors is a _rank one matrix_

If you forget the definition of [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)) in Linear Algebra, that's okay. Even if I "knew the defintion" of rank, I didn't really _understand_ it until I learned about the outer product.

The Wikipedia definition of rank is useful, but also not entirely helpful in it's intuition:
> The **rank** of a matrix $A$ is the dimension of the vector space generation (or spanned) by its columns.

Although I have ommited the proof of the fact "the outer product of two vectors is a rank one matrix", knowing this fact can give us some intuition as to what it means.

Let's choose some two vectors $(u, v) \in \mathbb{R}^n$ to be those which we construct our outer product matrix $M$.

$$
M = u \otimes v
$$
