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

I cannot speak to other's Linear Algebra education in university, merely my own. However, despite getting what I thought was a good upbringing in Linear Algebra, there was one topic that was missing: **_outer products_**.

Frankly, I rarely hear about outer products in the (machine learning) research I read, and I barely remember them being taught in the classroom. Perhaps for other people outer products were a casual mention in class. Alternatively, maybe there a inadvertent research bias that diminishes their impact. Or maybe outer products are just flat-out not useful for people's work. My goal with this blog post is to try and reverse this bias.

Despite the relationship (or lack-there-of) society has to the inner product's strange cousin, outer products have been increasingly on my mind. As I've grown to know them more and integrate their "dual view" into more of my analysis, they have increasingly become a fundamental piece of my thought processes and intuition surrounding Linear Algebra (and Deep Learning, as a result).

These days, I think it's almost always worth considering the meaning of the outer product dual for any Linear Algebra problem or theorem. Perhaps, if I get the opportunity to teach an undergraduate course in Linear Algebra in the future, I will design my course to have outer products on similar footing as inner products. For now, I have to resign myself to motivating _you_ through _this blog post_ why outer products are worth thinking about.


**In this blog post, I hope to:**
1. Give you an introduction to **outer products** (and a small refresher on inner products)
2. Reframe some of your existing Linear Algebra knowledge in the context of outer products
3. Prove a tiny Deep Learning theorem leveraging outer products

### Table of Contents
{:.no_toc}
* TOC
{:toc}

### A Brief Refresher of _Inner_ Products

Before explaining the outer product, let me first remind you of the basic definition of the dot product -- which I will interchangably refer to as the "inner product" at times [^1].

#### Vector Dot Products

Given two n-dimensional vectors $u, v \in \mathbb{R}^n$, the **dot product** between $u$ and $v$, denoted as $u \cdot v$ or $\langle u , v\rangle$ is defined as:

$$
u \cdot v = \langle u , v \rangle = u_1 v_1 + u_2 v_2 + \cdots + u_n v_n \in \mathbb{R}
$$

There are several useful properties of the inner/dot product, [for which Wikipedia is helpful](https://en.wikipedia.org/wiki/Inner_product_space#Basic_properties){:target='blank'}, but for now it is also useful to introduce the notation of the norm, which measures the _length_ of a vector: $ \Vert u \Vert = \sqrt{\langle u , u \rangle}$. As an example: in the setting where we select a point in the 2D-plane $u = (x, y)$ and want to compute it's distance from the origin $(0,0)$, we recover the Pythagorean theorem with the length of $u$ as the hypotenuse of a triangle: $\Vert u \Vert = \sqrt{x^2 + y^2}$.

One way of viewing this operation, although may not not entirely clear immediately, is computing the _similarity_ between $u$ and $v$. In fact, we can rearrange the dot product to show that it is computing (a scaled version of) the _angle_ between the vectors $u$ and $v$:

$$
\begin{aligned}
\langle u , v \rangle &=  \Vert u \Vert \Vert v \Vert  \cos(\theta) \\ 
\iff \theta &= \arccos \left( \frac{\langle u , v \rangle}{\Vert u \Vert \Vert v \Vert} \right)
\end{aligned}
$$

One simple consequence is that when $u$ and $v$ are perpendicular (also known as "**orthogonal**"; a.k.a. $\theta = 90 \degree$), then $\langle u , v \rangle = 0$.

It may be worth noting the trivial example of the "axes" of n-dimensional space. In two dimension space, a vector laying along the x-axis is $\bm{x} = (x, y) = (1, 0)$, and whereas the y-axis is $\bm{y} = (x, y) = (0, 1)$. In three dimensions, we have $\bm{x} = (x, y, z) = (1, 0, 0)$, $\bm{y} = (x, y, z) = (0, 1, 0)$, $\bm{z} = (x, y, z) = (0, 0, 1)$. In both dimensions (and beyond), each of those "axis" defined by vectors are mutually orthogonal -- $90 \degree$ apart -- and have a dot product of 0.

#### Matrix Multiplication

**Matrix multiplication** is a generalization of the dot (inner) product. For matrix-vector products, you may compute the result by taking the dot product of the vector with each _row_ of the matrix -- assuming we are representing the vector as a "column vector".

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

Looking this back to (vector) inner product, we see that we can represent the inner product as a special case of matrix multiplication! Namely the matrix multiplication between a transposed column vector (a.k.a. row vector) and a column vector:

$$
\langle x , y \rangle = x^\top y = 

\begin{bmatrix}
x_1 \\
x_2 \\
\vdots \\
x_n
\end{bmatrix}^\top

\begin{bmatrix}
y_1 \\
y_2 \\
\vdots \\
y_n
\end{bmatrix}
=
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

### Some Interesting Properties of the Outer Product

#### The outer product of two vectors is a _rank one matrix_

If you forget the definition of [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)){:target='blank'} in Linear Algebra, that's okay. Even if I "knew the defintion" of rank, I didn't really _understand_ it until I learned about the outer product.

The Wikipedia definition of rank is useful, but also not entirely helpful in it's intuition:
> The **rank** of a matrix $A$ is the dimension of the vector space generated (or spanned) by its columns.

Although I have omitted the proof of the fact "the outer product of two vectors is a rank one matrix", knowing this fact can give us some intuition as to what it means.

Let's choose some two vectors $(u, v) \in \mathbb{R}^n$ to be those which we construct our outer product matrix $\mathbf{M}$.

$$
\mathbf{M} = u \otimes v = u v^\top \in \mathbb{R}^{n \times n}
$$

One thing that we notice is that the result multiplying $\mathbf{M}$ by any vector $x$ is a _scalar multiple_ of $u$. That is, for any vector $x$

$$
\mathbf{M} x = u(v^\top x) = \langle v , x \rangle u
$$


In other words, **$Mx$ will output a scaled version of $u$ based on the _inner product_ (similarly) of $v$ and $x$.**

We can also notice that for vectors $x$ does not contain some scalar multiple of $v$ (i.e., it is orthogonal to $v$), we have that

$$
\mathbf{M} x = u (v^\top x) = 0 * u
$$

This has connection to the [Rank-nullity theorem](https://en.wikipedia.org/wiki/Rank%E2%80%93nullity_theorem), namely that the dimension of the _image_ of $\mathbf{M}$ is $1$, and the dimension of the _null-space_ (vectors that map to 0) is $(n - 1)$. Saying that the "rank of $\mathbf{M}$ is 1" is equivalent to counting the number of $x$'s orthogonal to $v$ (the number of zeros in $\mathbf{M}$) and observing the output space is spanned only by $u$ (with an effective dimension of 1).


#### Matrix multiplication is a summation over outer products

One of the most interesting results (inspired by [Wikipedia](https://en.wikipedia.org/wiki/Outer_product#Connection_with_the_matrix_product){:target='blank'}) is that **any matrix multiplication can be written as a _sum over outer products_**. More specifically, a sum over the outer product of the columns of the left matrix with the rows of the right matrix:

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

Where we take $[\bm{b}\_k^{\text{row}}]^\top$ to translate the _row vector_ from $B$ to a _column vector_ for clarity [^2].


You may say: **Hey, this looks _strangely_ like the [singular value decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition){:target="blank"}...**

It does! Or at least the above representation of matrix multiplication services a similar purpose. It turns out that we can rewrite our "canonical" SVD formulation for a matric $\mathbf{A}$ as:

$$
\mathbf{A} = \mathbf{U \Sigma V^\top} = \sum_{k = 1}^{\text{rank}(A)} (\bm{u}_k \otimes \bm{v}_k) \sigma_k
$$

Where $\bm{u}\_k$ is the k-th left and $\bm{v}\_k$ is the k-th right singular vector, and $\sigma\_k$ is the k-th singular value. If you don't remember what a "singular vector" is or "singular value", that's fine. Like "rank", I feel like I didn't _truly_ understand until I had the outer product in my toolbelt. I will give this intution in the next section.

There is the interesting corollary of the above SVD result: **_every matrix can be rewritten as the sum of rank-one matricies_**. We didn't actually need the SVD for this result -- we could have derived this from the matrix-multiplication theorem above, using the identity matrix as a surrogate for the $\mathbf{A}$ or $\mathbf{B}$ matricies.

#### Matrix-vector multiplication is a weighted sum of vectors

As an extension to our matrix-vector product observation in the previous section, we can realized that for any matrix $\mathbf{M}$, an input vector $\bm{x}$ _distributes over the summation_.

Ignoring (w.l.o.g.) $\sigma_k$, the output of a matrix multiplication $\mathbf{M} \bm{x}$ is computed via broadcasting over the outer product sum as:

$$
\mathbf{M} \bm{x} = \left( \sum_{k = 1}^{\text{rank}(M)}  \bm{u}_k \bm{v}_k^\top \right) \bm{x} = \sum_{k = 1}^{\text{rank}(M)} \left( \bm{u}_k \bm{v}_k^\top \bm{x} \right) = \sum_{k = 1}^{\text{rank}(M)} c_k \bm{u}_k
$$

where $c_k = \langle \bm{v}_k , \bm{x} \rangle$.

This is another property that adds to my _personal intuition_ of how matricies work. **An input vector is compared against each "right singular vector" to determine a scalar to multiple the "left singular vector by".** Although I say "singular vector" here, this is not specific to SVD -- rather just the correspondence between matricies and sums of outer products.



Although I won't expand on it here, the outer product expansion _may_ give you more of an intuition as to how we may define [the pseudoinverse](https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse){:target='blank'} in terms of SVD (or a similar outer-product construction). For me, it also gave me a good motivating argument as to why there should exist an inverse outside of the nullspace!

We can actually simplify the above "$\mathbf{M}\bm{x}$" statement, bypassed the SVD inituion. In the case where we represent a matrix as product $\mathbf{C} = \mathbf{AB}$, then we have that the output _is a weighted sum of the columns of $\mathbf{A}$_. Nifty! Furthermore, if we let matrix $\mathbf{B}$ be a (column) _vector_ $\bm{x}$, then we have that 

$$
\mathbf{AB} = \mathbf{A} \bm{x} = \sum_{k = 1}^n \bm{a}_k^{\text{col}} \otimes x_k^{\text{row}} = \sum_{k = 1}^n x_k \bm{a}_k^{\text{col}}
$$

And remember, the $k$-th row of column vector $\bm{x}$ is a scalar! **Thus, matrix-vector product is a weighted sum over the columns of the matrix** [^3].

### The Curious Case of the ReLU Network

ReLU Neural Networks are one of my favorite types of networks to analyze. Not only are they easy to analyze, but they admit elegant theories of their operation. For a deeper discussion on what I believe to be one of the most interesting properties of neural networks, please read [Mad Max: Affine Spline Insights into Deep Learning (Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576){:target='blank'}.

For now, I will work with a simplified model: a "two layer" ReLU network, meaning two matrix multiplications.

$$
\begin{aligned}
h^{(1)} &= \text{ReLU}(\mathbf{W}^{(1)} x) \\
y &= \mathbf{W}^{(2)} h^{(1)}
\end{aligned}
$$

Where $\text{ReLU}(x) = x$ when $x \geq 0$ and $=0$ when $x < 0$, or equivalently $\text{ReLU}(x) = x \cdot 𝟙(x > 0)$. It may also be convenient to store in your mind that the above two layer network can be represented more compactly as:

$$
y = \mathbf{W}^{(2)} (\sigma(\mathbf{W}^{(1)} x) )
$$

with $\sigma(x) = \text{ReLU}(x)$ for brevity.

Let's combine both ingredients of the inner- and outer-product perspectives to cook up an interesting insight.

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

Using those two ingredients from above, we discovered that **ReLU networks implicitly define input-specific _matrix_ (linear!!) transformations**. Furthermore, **the primary method of matrix generation is through _dynamic rank modulation_**. By applying an argument by simple [mathematical induction](https://en.wikipedia.org/wiki/Mathematical_induction){:target='blank'}, we realize that this is true _regardless of the depth of the network_, and we can _explicitly_ give the resulting transformation matrix given any input.

This is very similar to the theorem proven by [(Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576){:target='blank'}, although we took a different approach to computing the resulting matrix transformation. It is worth noting, as is a core tenant of that paper, that this is _partition based_. That is, input vectors map to "matrix transformations" in a fuzzy manner such that two distinct output vectors may share the same set $\Omega$.


### Conclusion

**A core aspect of my believe is that outer products are interesting is because outer products express _the computations themselves_ rather than just the _result_ of the computation.** By viewing Linear Algebra through the lens of computation captures an intuition for the mechanisms of _operation_, not just the human mechanisms employed to compute a result. For example, in the setting of neural networks, outer products allow us to say "this is the _exact_ circuit that was used to compute the result" rather than just giving the result.

Hopefully I was able to plant a seed in your mind with minimal pain through this article and you understand a bit more of why I find outer products not only facinating, but a necessary piece of the intution of Linear Algebra. If you have any feedback or questions, I'd love to hear about them in the comments below.

Thanks for reading!

### Meta-Notes
{:.no_toc}

While writing this post, there were couple sections that I had written that were cut or ideas I had but hesitated to add here. Instead of overburdening the post with more "motivating examples" in the form of reframing more aspects of Deep Learning, I decided to try and keep the post more isolated to "I think outer products are interesting and I hope to plant a seed in your mind as to why".

I intend to make a few more posts on the topic of reframing concepts through the lens of outer products. Beyond reframing well-known concepts that in Linear Algebra, or results that Deep Learning Theory researchers might know, I think that there are a lot of novel (and relatively simple) corollaries of the above observation with ReLU networks. On the other hand, perhaps it's worth pursuing writing short manuscripts to post on arXiV. Having some extra Google Scholar entries will hopefully help me in PhD applications. We'll see what my time (outside of my full-time job) affords me!

### Footnotes
{:.no_toc}

[^1]: If I were to be accurate, then the "dot product" and "inner product" cannot be used interchangably. The dot product is just one inner product defined on Euclidean space. The main reason I might tend to use inner product in this post is because it constrasts nicely with the term "outer product".

[^2]: 
    This is one difference with the Wikipedia article referenced. On Wikipedia, they represent this sum as:
    
    $$
    \sum_{k = 1}^p \bm{a}_k^{\text{col}} \bm{b}_k^{\text{row}}
    $$

    This is technically correct! Since this post is about "the magic of outer products", and I really like the $\otimes$ symbol, I had to manipulate the equation slightly to fit it in. That required me to take the transpose because technically(!) $\bm{b}$ is a row vector, meaning $\bm{a}\_k^{\text{col}} \bm{b}\_k^{\text{row}}$ is an outer product, even if it doesn't use the fancy symbol. _In order to remain correct and keep my $\otimes$ symbol, I had to take the transpose of $\bm{b}$._

[^3]: This sounds eerily similar to another topic reframed earlier in this article...
