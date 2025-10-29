---
layout: post
title: "Outer Products: The Dual View of Linear Algebra"
category: Math
description: >-
    Walk by my whiteboard, or look in my notebooks, and you'll often see a canvas covered in outer product-based equations. But why should I be so obsessed with a concept barely worth mentioning in a Linear Algebra class? In this post, I will introduce you to outer products and hopefully convince you that they are worth more than just a footnote.
tags: [math, tutorial, ML]
usemath: true
date: 2025-10-28
post_id: outer-products
---

I cannot speak to others' Linear Algebra education in university, merely my own. However, despite getting what I thought was a good upbringing in Linear Algebra, there was one topic that was missing: **_outer products_**.

Frankly, I rarely hear about outer products in the (machine learning) research I read, and I barely remember them being taught in the classroom [^note-1]. Perhaps for other people outer products were also just a casual mention in class, or perhaps there is an inadvertent research bias that diminishes their impact. It's also possible I'm just out of touch, and maybe outer products are not anything noteworthy or the wrong way to frame problems. Regardless, the journey from ignorance to obsession has certainly changed me.

Despite the relationship (or lack thereof) society has to the inner product's strange cousin, outer products have been increasingly on my mind. As I've grown to know them more and integrate their "dual view" into more of my analysis, they have increasingly become a fundamental piece of my thought processes and intuition surrounding Linear Algebra (and Deep Learning, as a result).

These days, I think it's almost always worth considering the meaning of the outer product "dual" for any Linear Algebra problem or theorem. Perhaps, if I get the opportunity to teach an undergraduate course in Linear Algebra in the future, I will design my course to have outer products on similar footing as inner products. For now, I have to resign myself to motivating _you_ through _this blog post_ about why outer products are worth thinking about.


**In this blog post, I hope to:**
1. Give you an introduction to **outer products** (and a small refresher on inner products).
2. Reframe some of your existing Linear Algebra knowledge in the context of outer products.
3. Prove a tiny Deep Learning theorem leveraging outer products.

### Table of Contents
{:.no_toc}
* TOC
{:toc}

### A Brief Refresher of _Inner_ Products

Before introducing the outer product, let me first remind you of the basic definition of the dot product -- which I will interchangeably refer to as the "inner product" at times [^1].

#### Vector Dot Products

Given two n-dimensional vectors $u, v \in \mathbb{R}^n$, the **dot product** between $u$ and $v$, denoted as $u \cdot v$ or $\langle u , v\rangle$ is defined as:

$$
u \cdot v = \langle u , v \rangle = u_1 v_1 + u_2 v_2 + \cdots + u_n v_n \in \mathbb{R}
$$

There are several useful properties of the inner/dot product, [for which Wikipedia can be a easy reference](https://en.wikipedia.org/wiki/Inner_product_space#Basic_properties){:target='blank'}, but for now it's important to introduce the notation of the norm, which measures the _length_ of a vector: $ \Vert u \Vert = \sqrt{\langle u , u \rangle}$. 

<details>
<summary><em>If you're asking: "Wait, why is the 'norm' equivalent to measuring the length?"</em></summary>
<div markdown="1">
As an example to try and convince you that these two concepts are equivalent:

In the setting where we select a point in the 2D-plane $u = (x, y)$ and imagine it as the hypotenuse of a triangle, then by computing the norm as defined above, we recover the Pythagorean theorem: $\Vert u \Vert = \sqrt{x^2 + y^2}$.
</div>
</details>

One way of viewing this operation, although it might not be entirely clear immediately, is computing the _similarity_ between $u$ and $v$. In fact, we can rearrange the dot product to show that it is computing (a scaled version of) the _angle_ between the vectors $u$ and $v$:

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

Extending this to matrix-matrix products by creating one or more columns in our "vector" is intuitive -- every new column added our "vector" adds a new column to the output matrix:

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

Looking back at the (vector) inner product defined [above](#vector-dot-products), we see that we can represent the inner product as a special case of matrix multiplication! Namely, the matrix multiplication between a transposed column vector (a.k.a. row vector) and a column vector is equivalent to the vector dot product:

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

An **outer product** is a small tweak to the equation of the inner (dot) product between two vectors. Instead of writing the inner product as:

$$
x \cdot y = x^\top y
$$

the **outer product** of two vectors is defined as:

$$
x \otimes y = x y^\top
$$

While relocating the position of the matrix transpose to $y$ seems like a trivially small modification, it has profound implication. One of the immediate implication is: **the outer product between two vectors yields _a matrix_ output.**

Follow the pattern from above we can see this in action:

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

There are some particularly interesting properties that are worth mentioning about the outer product:

### Some Interesting Properties of the Outer Product

#### The outer product of two vectors is a _rank one matrix_

If you forget the definition of [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)){:target='blank'} from Linear Algebra class, that's okay. Even if I "knew the definition" of rank, I didn't really _understand_ it until I learned about the outer product.

The Wikipedia definition of rank is useful, but also not entirely helpful in its intuition:
> The **rank** of a matrix $A$ is the dimension of the vector space generated (or spanned) by its columns.

Although I have omitted the proof of the fact "the outer product of two vectors is a rank one matrix", knowing this fact can give us some intuition as to what "rank" means.

Let's choose two vectors $(u, v) \in \mathbb{R}^n$ to be those from which we construct our outer product matrix $\mathbf{M}$.

$$
\mathbf{M} = u \otimes v = u v^\top \in \mathbb{R}^{n \times n}
$$

One thing that we notice is that the result of multiplying $\mathbf{M}$ by any vector $x$ is a _scalar multiple_ of $u$. That is, for any vector $x$

$$
\mathbf{M} x = u(v^\top x) = \langle v , x \rangle u
$$


In other words, **$\mathbf{M} x$ will output a scaled version of $u$ based on the _inner product_ (similarly) of $v$ and $x$.**

We can also notice that for vectors $x$ that do not contain some scalar multiple of $v$ (i.e., they are orthogonal to $v$), we have that

$$
\mathbf{M} x = u (v^\top x) = 0 * u = \bm{0}
$$

This has connection to the [Rank-nullity theorem](https://en.wikipedia.org/wiki/Rank%E2%80%93nullity_theorem), namely that the dimension of the _image_ of $\mathbf{M}$ is $1$, and the dimension of the _null-space_ (vectors that map to 0) is $(n - 1)$. Saying that the "rank of $\mathbf{M}$ is 1" is equivalent to the observation the output space of $\mathbf{M}$ is _only_ contains scalar multiples of $u$.


#### Matrix multiplication is a summation over outer products

One of the most interesting properties of outer products, in my opinion, is that **any matrix multiplication can be rewritten as a _sum over outer products_**. More specifically, a matrix multiplication $\mathbf{C} = \mathbf{AB}$ can be rewritten as a sum over the outer product of the columns of the left matrix (denoted $\bm{a}\_i^{\text{col}}$) with the rows of the right matrix (denoted $\bm{b}\_i^{\text{row}}$):

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

Where above we take $[\bm{b}\_k^{\text{row}}]^\top$ to translate the _row vector_ from $\mathbf{B}$ to a _column vector_ for clarity [^2].

A fascinating corollary of this is **every _matrix_ can be rewritten as a sum of rank-one matrices**. A trivial way of showing this is to replace either $\mathbf{A}$ or $\mathbf{B}$ with the identity matrix. A special case of an outer product decomposition of a matrix is an operation you've likely heard of in a different context: the [_singular value decomposition_](https://en.wikipedia.org/wiki/Singular_value_decomposition){:target="blank"} (SVD).

Although I won't go into the proof in this post, it turns out that we can rewrite our "canonical" SVD formulation for a matrix $\mathbf{A}$ in an outer product form:

$$
\mathbf{A} = \mathbf{U \Sigma V^\top} = \sum_{k = 1}^{\text{rank}(A)} (\bm{u}_k \otimes \bm{v}_k) \sigma_k
$$

Where $\bm{u}\_k$ is the k-th left and $\bm{v}\_k$ is the k-th right singular vector, and $\sigma\_k$ is the k-th singular value. If you don't remember what a "singular vector" is or "singular value", that's fine. Like "rank", I feel like I didn't _truly_ understand until I had the outer product in my toolbelt. I will provide some intution for singular vectors in the next section.

#### Matrix-vector multiplication is a weighted sum of vectors

As an extension to our matrix-vector product observation in the previous section, we can realize that for any matrix $\mathbf{M}$, an input vector $\bm{x}$ _distributes over the outer product summation_.

If we ignore (without loss of generality) $\sigma_k$ from the SVD reformulation above, the output of a matrix-vector product $\mathbf{M} \bm{x}$ is computed via broadcasting over the outer product sum as:

$$
\mathbf{M} \bm{x} = \left( \sum_{k = 1}^{\text{rank}(M)}  \bm{u}_k \bm{v}_k^\top \right) \bm{x} = \sum_{k = 1}^{\text{rank}(M)} \left( \bm{u}_k \bm{v}_k^\top \bm{x} \right) = \sum_{k = 1}^{\text{rank}(M)} c_k \bm{u}_k
$$

where $c_k = \langle \bm{v}_k , \bm{x} \rangle \in \mathbb{R}$.

This is another property that adds to my _personal intuition_ of how matrices work. **An input vector is compared against each "right singular vector" (in the input space) to determine a scalar to multiply the "left singular vector" by (in the output space).** Although I say "singular vector" here, this is not specific to SVD -- rather just the correspondence between matrices and sums of outer products.

Although I won't expand on it here, the outer product expansion _may_ give you more of an intuition as to how we may define [the pseudoinverse](https://en.wikipedia.org/wiki/Moore%E2%80%93Penrose_inverse){:target='blank'} in terms of SVD (or a similar outer-product construction). For me, it also gave me a good motivating argument as to why there should exist an inverse outside the nullspace for generally non-invertible matrices!

While framing our observation of this section in terms of singular vectors can be useful, we can actually simplify the above "$\mathbf{M}\bm{x}$" statement and bypass the SVD. In the case where we represent a matrix as product $\mathbf{C} = \mathbf{AB}$, then we have that the output _is a weighted sum of the columns of $\mathbf{A}$_. Nifty! Furthermore, if we let matrix $\mathbf{B}$ be a (column) _vector_ $\bm{x}$ with elements $x_k$, then we have that 

$$
\mathbf{AB} = \mathbf{A} \bm{x} = \sum_{k = 1}^n \bm{a}_k^{\text{col}} \otimes x_k^{\text{row}} = \sum_{k = 1}^n x_k \bm{a}_k^{\text{col}}
$$

And remember, the $k$-th row of column vector $\bm{x}$ is a scalar!

**Thus, matrix-vector product is a weighted sum over the columns of the matrix**.

### The Curious Case of the ReLU Network

ReLU neural networks are one of my favorite types of networks to analyze. Not only are they easy to dissect mathematically, but the theory and structures that they admit are quite elegant.[^4] To our benefit, ReLU neural networks are likely the most common form of neural networks, so anything we can prove in these settings can have quite an impact.

I want to walk you through proving something very interesting about these ubiquitous neural networks using the toolkit we acquired above. First, let's refresh our knowledge of _what a ReLU network actually is_.

#### A Small Neural Network Refresher

For those who don't already have a background in machine learning, there are two ingredients of a ReLU neural network: matrix multiplication and the $\text{ReLU}$ function. Luckily for us, the ReLU function is quite simple: $\text{ReLU}(x) = \max(0, x)$ -- meaning that when $x \geq 0$, then $\text{ReLU}(x) = x$, otherwise $\text{ReLU(x)} = 0$. This function is applied to a single _number_ $x \in \mathbb{R}$, and when it is applied to vectors, it is applied _element-wise_ (i.e., to each element of the vector individually).

Below is a plot that shows this function:

<figure>
    <img src="/assets/per-post/outer-products/desmos-graph.svg" alt="Plot of the function ReLU(x) = max(0, x)" class="invertable" width="300" height="300" style="background: #eee; height:auto;" />
    <figcaption>Plot of the function $\text{ReLU(x)} = \max(0, x)$</figcaption>
</figure>

As an example application to apply our outer product toolkit to, we will work with a simplified model neural network: a "two layer" ReLU network, meaning two matrix multiplications ($\mathbf{W}^{(1)}$ and $\mathbf{W}^{(2)}$) and one ReLU activation function that is applied _element-wise_ to a vector. For a given input vector $x$, we compute the neural network output $y$ as:

$$
\begin{aligned}
h^{(1)} &= \text{ReLU}(\mathbf{W}^{(1)} x) \\
y &= \mathbf{W}^{(2)} h^{(1)}
\end{aligned}
$$


We can also rewrite the above two layer network more compactly as:

$$
y = \mathbf{W}^{(2)} (\sigma(\mathbf{W}^{(1)} x) )
$$

where we write $\sigma(x) = \text{ReLU}(x)$ for brevity.

#### The Curious Insight

Now that we remember our neural network background knowledge, let's combine both ingredients of the inner- and outer-product perspectives of matrix multiplication to cook up our interesting mini-theorem.

**Ingredient 1:** Matrix-vector multiplication from the _inner product_ view tells us that we can represent the first layer output $h^{(1)}$ as:

$$
h^{(1)} =
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

**Ingredient 2:** "Matrix-vector multiplication is a weighted sum of the columns of the matrix" tells us that we can rewrite the merged equation as:

$$
y = \mathbf{W}^{(2)} (\sigma (\mathbf{W}^{(1)} x)) = \sum_{k = 1}^n w_k^{(2)} \cdot \sigma(\langle w_k^{(1)}, x \rangle)
$$

_Let's play with this equation a bit more._ 

We can define a set $\Omega_x$ (conditioned on the input $x$) to denote the indices $k$ where the $\text{ReLU}$ is "activated". That is, for a given vector $x$, $\Omega_x = \left\\{ k : \langle w_k^{(1)}, x \rangle > 0 \right\\}$. With this set $\Omega_x$ can rewrite the above equation in terms of the indicies in this set:

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

This is very similar to the theorem proven by [(Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576){:target='blank'}, although we took a different approach to computing the resulting matrix transformation. It is worth noting, as is a core tenant of that paper, that matrix generation process is _partition based_. That is, input vectors map to "matrix transformations" in a fuzzy manner such that two distinct input vectors may share the same set $\Omega$ and thus the same generated matrix transformation.


### Conclusion

A core motivation for writing this post is my belief that **outer products are interesting because they express _computations themselves_ rather than just the _result_ of the computations.** By viewing Linear Algebra through the lens of computation, we can capture an intuition for the mechanisms of _operation_ instead of just the human mechanisms employed to compute a result. For example, in the setting of neural networks, outer products allow us to say "this is the _exact_ circuit that was used to compute the result" rather than just giving the result of a computation.

Hopefully, and without too much pain, I was able to plant the seed in your mind of why outer products are more interesting and useful than the casual in-class mention may suggest. If you are someone that leverages linear algebra in your work, I'd encourage you to ponder if your problem can be reframed in the language of outer products -- even as just an exercise. Perhaps it cannot be, or perhaps it's not useful, but in most of the settings I've played with similar reframings, I've gained a deeper intuition as to what the computations I am performing actually represent. 

I'd love to know: For those of you who have a background in Linear Algebra, did you get taught much about outer products? If you're a Linear Algebra instructor, are outer products taught in your class? To those who wield matrices day-to-day, are outer products something that come up often in your work? Let me know in the comments below!

Thanks for reading!

### Meta-Notes
{:.no_toc}

I started writing this article back in early October and it took a _bit_ longer than I originally hoped. On one hand, I wanted this to be an article trying to motivate the argument that "outer products are cool"! On the other hand, I was desperate to share some of the cool results I had discovered by reframing certain problems in this light. After a bit of back-and-forth, with a few drafts written in-between, I decided on the former -- to try and keep the post more isolated to "I think outer products are interesting, and I hope to plant a seed in your mind as to why".

I do intend to write a few more posts on the topic of reframing concepts through the lens of outer products. Beyond reframing well-known concepts that appear in Linear Algebra, or results that Deep Learning Theory researchers might already know, I think that there are a lot of novel (and relatively simple) corollaries of the above observation with ReLU networks. On the other hand, perhaps it's worth pursuing writing short manuscripts to post on arXiv. Having some extra Google Scholar entries will hopefully help me in PhD applications. We'll see what my time (outside my full-time job) affords me!

Throughout this post, I struggled to navigate how to best cite basic Linear Algebra and "[well-knowable](https://en.wikipedia.org/wiki/Mathematical_folklore){:target='blank'} theorems". I especially feel a little embarrassed to have given Wikipedia as a reference so frequently. Any tips for better giving references for basic Math and "easily-provable" theorems would be appreciated! Referencing a random textbook, especially if I can't link directly to an HTML page, seems a little contrived.

**From anyone reading this, I would love some feedback on how you felt about this post!** It can be tough to know who I want to write be writing to in a post like this, and this post definitely fell more on the side of my mathematical interests than my computer science interests. Hopefully, even if you just had a basic background in Linear Algebra, this post was relatively comprehensible. 

Thanks again!

### Footnotes
{:.no_toc}

[^note-1]: If you are curious, my LA courses in college were taught from the legendary book ["Linear Algebra Done Right" by Sheldon Axler](https://linear.axler.net/){:target='blank'}. It's a great reference, but it does not cover outer products. In fact the word "outer" does not appear even once in the text!


[^1]: If I were to be accurate, then the "dot product" and "inner product" cannot be used interchangeably. The dot product is just one inner product defined on Euclidean space. The main reason I might tend to use inner product in this post is because it contrasts nicely with the term "outer product".

[^2]: 
    This equation is a derivative of [the one used in the Wikipedia article for "outer products"](https://en.wikipedia.org/wiki/Outer_product#Connection_with_the_matrix_product){:target='blank'}. There is one major difference between the equations -- a stylistic one. On Wikipedia, they represent this sum as:
    
    $$
    \sum_{k = 1}^p \bm{a}_k^{\text{col}} \bm{b}_k^{\text{row}}
    $$

    This is technically correct! Since this post is about "the magic of outer products", and I really like the $\otimes$ symbol, I had to manipulate the equation slightly to fit it in. That required me to take the transpose because technically(!) $\bm{b}$ is a row vector, meaning $\bm{a}\_k^{\text{col}} \bm{b}\_k^{\text{row}}$ is an outer product, even if it doesn't use the fancy symbol. _In order to remain correct and keep my $\otimes$ symbol, I had to take the transpose of $\bm{b}$._

[^4]: For a deeper discussion on what I believe to be some of the most interesting properties of neural networks, please read [Mad Max: Affine Spline Insights into Deep Learning (Balestriero & Baraniuk, 2018)](https://arxiv.org/abs/1805.06576){:target='blank'}.

