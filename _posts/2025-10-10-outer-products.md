---
layout: post
title: "Outer Products: The Dual View of Linear Algebra"
category: Math
description: 
tags: [math, tutorial, ML]
usemath: true
date: 2025-10-09
post_id: outer-products
---

I cannot speak for the Linear Algebra education of other's in university, merely my own. However, despite getting what I thought was a good upbringing in Linear Algebra, there was one topic that was missing: **outer products**.

Perhaps this is a casual mention, as it was in my classes, or perhaps they just don't get the same sort of appreciation that inner products to. But as I've grown to know them more, and integrate their "dual view" into more of my analysis, I believe that they have become a fundemental piece of my knowledge of Linear Algebra.

These days, I think it's almost always worth considering the meaning of the outer product dual for any LA problem. Perhaps, if I get the opportunity to teach some undergraduates Linear Algebra in the future, I will design my course to have outer products on similar footing as inner products. For now, I have to resign myself to motivating _you_ through _this blog post_ why outer products are worth thinking about.

### Table of Contents
{:.no_toc}
* TOC
{:toc}

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
\color{red} \langle a , x \rangle \\
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
\langle x , y \rangle = x^\top y = 

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
x \cdot y = x^\top y
$$

the **outer product** of two vectors is

$$
x \otimes y = x y^\top
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

### Some Interesting Properties

#### The outer product of two vectors is a _rank one matrix_

If you forget the definition of [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)) in Linear Algebra, that's okay. Even if I "knew the defintion" of rank, I didn't really _understand_ it until I learned about the outer product.

The Wikipedia definition of rank is useful, but also not entirely helpful in it's intuition:
> The **rank** of a matrix $A$ is the dimension of the vector space generation (or spanned) by its columns.

Although I have ommited the proof of the fact "the outer product of two vectors is a rank one matrix", knowing this fact can give us some intuition as to what it means.

Let's choose some two vectors $(u, v) \in \mathbb{R}^n$ to be those which we construct our outer product matrix $M$.

$$
M = u \otimes v = u v^\top \in \mathbb{R}^{n \times n}
$$

One thing that we notice is that for vectors $x$ does not contain some scalar multiple of $v$ (i.e., it is orthogonal to $v$), we have that

$$
M x = u (v^\top x) = 0 * u
$$

This has connection to the [Rank-nullity theorem](https://en.wikipedia.org/wiki/Rank%E2%80%93nullity_theorem), namely that the dimension of the _image_ of $M$ is $1$, and the dimension of the _null-space_ (vectors that map to 0) is $(n - 1)$.

We can also notice that **this implies that $Mx$ will output _a scalar multiple_ of $u$ based on the _inner product_ of $v$ and $x$.** I personally think that's pretty cool!

#### Matrix multiplication is a summation over outer products

One of the most interesting results (taken from [Wikipedia](https://en.wikipedia.org/wiki/Outer_product#Connection_with_the_matrix_product)) is that _any matrix multiplication can be written as a **sum over outer products**_. More specifically, a sum over column-by-row outer products of the two matricies:

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

Where we take $[\bm{b}\_k^{\text{row}}]^\top$ to translate the _row vector_ from $B$ to a _column vector_. 


You may say: **Hey, isn't this just SVD?**

It is! For a matrix $\mathbf{A}$, we can rewrite it as

$$
\mathbf{A} = \mathbf{U \Sigma V^\top} = \sum_{k = 1}^{\text{rank}(A)} (\bm{u}_k \otimes \bm{v}_k) \sigma_k
$$

Where $\bm{u}\_k$ is the k-th left and $\bm{v}\_k$ is the k-th right singular vector, and $\sigma\_k$ is the k-th singular value. There is the interesting corollary of this that **_every matrix can be rewritten as the sum of rank-one matricies_**, although we also could have derived this result from the matrix-multiplication theorem above.

#### Matrix-vector multiplication is a weighted sum of vectors

As an extension to our matrix-vector product observation in the previous section, we can realized that for any matrix $\mathbf{M}$, an input vector $\bm{x}$ _distributes over the summation_.

Ignoring (w.l.o.g.) $\sigma_k$, the output of a matrix multiplication $\mathbf{M} \bm{x}$ is computed via broadcasting over the outer product sum as:

$$
\mathbf{M} \bm{x} = \left( \sum_{k = 1}^{\text{rank}(M)}  \bm{u}_k \bm{v}_k^\top \right) \bm{x} = \sum_{k = 1}^{\text{rank}(M)} \left( \bm{u}_k \bm{v}_k^\top \bm{x} \right) = \sum_{k = 1}^{\text{rank}(M)} c_k \bm{u}_k
$$

where $c_k = \langle \bm{v}_k , \bm{x} \rangle$.

This is another property that adds to my _personal intuition_ of how matricies work. An input vector is compared against each "right singular vector" to determine a scalar to multiple the "left singular vector by". Although I say "singular vector" here, this is not specific to SVD -- rather just the correponsdence between matricies and sums of outer products.



Although I won't expand on it here, the outer product expansion _may_ give you more of an intuition as to how we may define [the pseudoinverse](https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse) in terms of SVD (or a similar outer-product construction). For me, it also gave me a good motivating argument as to why there should exist an inverse outside of the nullspace!

We can actually simplify the above "$\mathbf{M}\bm{x}$" statement, bypassed the SVD inituion. In the case where we represent a matrix as product $\mathbf{C} = \mathbf{AB}$, then we have that the output _is a weighted sum of the columns of $\mathbf{A}$_. Nifty! Furthermore, if we let matrix $\mathbf{B}$ be a (column) _vector_ $\bm{x}$, then we have that 

$$
\mathbf{AB} = \mathbf{A} \bm{x} = \sum_{k = 1}^n \bm{a}_k^{\text{col}} \otimes x_k^{\text{row}}
$$

And realize, the $k$-th row of column vector $\bm{x}$ is a scalar! **Thus, matrix-vector product is a weighted sum over the columns of the matrix.**

### The Dual View of Machine Learning

#### The Curious Case of the ReLU Network

ReLU Neural Networks are one of my favorite types of networks to analyze. Not only are they easy to analyze, but they admit elegant theories of their operation. For a further discussion on what I believe to be one of the most interesting properties of neural networks, please read [Mad Max: Affine Spline Insights into Deep Learning (Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576).

For now, I will work with a simplified model: a "two layer" ReLU network, meaning two matrix multiplications.

$$
\begin{aligned}
h^{(1)} &= \text{ReLU}(\mathbf{W}^{(1)} x) \\
y &= \mathbf{W}^{(2)} h^{(1)}
\end{aligned}
$$

Where $\text{ReLU}(x) = x$ when $x \geq 0$ and $=0$ when $x < 0$, or $\text{ReLU}(x) = x \cdot 𝟙(x > 0)$. It may also be convient to store in your mind that this can be represented more compactly as:

$$
y = \mathbf{W}^{(2)} (\sigma(\mathbf{W}^{(1)} x) )
$$

with $\sigma(x) = \text{ReLU}(x)$ for brevity.

Let's combine both ingredients of out inner- and outer-product perspectives.

**Ingredient 1:** Matrix-vector multiplication in the _inner product_ view tells us that we can represent the first layer output $h_1$ as:

$$
h_1 =
\sigma(\mathbf{W}^{(1)} x)
= 
\begin{bmatrix}
\sigma( \langle w_1^{(1)}, x \rangle ) \\
\sigma( \langle w_2^{(1)}, x \rangle ) \\
\vdots \\
\sigma( \langle w_n^{(1)}, x \rangle ) \\
\end{bmatrix}
$$

where $w_k^{(1)}$ is the $k$-th row of $\mathbf{W}^{(1)}$.

**Ingredient 2:** Matrix-vector multiplication is a weighted sum of the columns of the matrix.

$$
y = \mathbf{W}^{(2)} (\sigma (\mathbf{W}^{(1)} x)) = \sum_{k = 1}^n w_k^{(2)} \cdot \sigma(\langle w_k^{(1)}, x \rangle)
$$

Let's play with this a bit more. We can define a set $\Omega_x$ to denote the indicies $k$ where the $\text{ReLU}$ is "activated" (conditioned on the input $x$). That is, $\Omega_x = \left\\{ k : \langle w_k^{(1)}, x \rangle > 0 \right\\}$.

We can rewrite the above equation as:

$$
y = \sum_{m \in \Omega_x} w_m^{(2)} \cdot \langle w_m^{(1)}, x \rangle
$$

This (now linear) equation can be rearranged as:

$$
\begin{aligned}
y &= \sum_{m \in \Omega_x} w_m^{(2)} \left[w_m^{(1)}\right]^\top x \\
&= \sum_{m \in \Omega_x} \left( w_m^{(2)} \otimes w_m^{(1)} \right) x \\
&= \left( \sum_{m \in \Omega_x} w_m^{(2)} \otimes w_m^{(1)} \right) x
\end{aligned}
$$

Using those two ingredients from above, we discovered that **ReLU networks implicitly define input-specific matrix transformations**. Furthermote, **the primary method of matrix generation is through rank modulation**. By applying an argument by [mathematical induction](https://en.wikipedia.org/wiki/Mathematical_induction), we realize that this is true _regardless of the depth of the network_, and we can explicitly give the resulting transofmration matrix given any input.

This is very similar to the theorem proven by [(Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576), although we took a different approach to computing the resulting matrix transformation. It is worth noting, as is a core tenant of that paper, that this is _partition based_. That is, input vectors map to "matrix transformations" in a fuzzy manner such that two distinct output vectors may share the same set $\Omega$.

#### A Strange Kind of (Stochastic) Gradient Descent

Outer products may sneak into gradient descent when you least expect it. I can even give some hand-wavy explanations of why gradietn descent seems biased towards low-rank optimizations. For this section, I am only working with _ordinary least square_, that is, _linear regression_. I'd welcome other analysis in the same vein, especially if someone can describe how the outer product construction of ReLU networks changes in this setting.

As a refresher on least squares, this is a setting where the solution weights can be solved in closed form. The goal is to learn some _weight vector_ $\bm{\beta}$ such that an observed input vector $\bm{x}\_i$ is mapped to an observed output _scalar_ $y_i$.

When we stack $n$ sample inputs $x_i \in \mathbb{R}^p$, in a "training matrix" $\mathbf{X} \in \mathbb{R}^{n \times p}$.

First, let's begin with the case of "pure" stochastic gradient descent -- we run gradient descent with respect to a **batch size of 1**.

### Conclusion

When I originally planned this post, I wanted to create a section on how we can interpret Self-Attention and Linear Self-Attention through the lens of outer products. [Schlag et al, 2021](https://arxiv.org/abs/2102.11174) is a very interesting paper speaking on linear self-attention, but I hoped to add more to the discussion. Unfortunately, while writing this blog post, I discovered a "bug" in my Math such that I will exclude that section.
