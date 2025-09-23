---
layout: post
title: Fuzzy Finding, LLMs, and Langevin Dynamics
category: CS
description: I have been trying to categorize productive patterns of the use of AI tools, and along the way the convergence of a few of my favorite mathematical concepts have led me to see an interesting path forward -- fuzzy finding.
tags: [cs, math]
usemath: true
date: 2025-09-22
post_id: fuzzy-dynamics
---

Grappling with the dissonance between formal mathematical theories of deep learning (my passion) and the world's in-practice use of "AI", I've been trying to categorize applications that I think are theoretically well-grounded and "safe". **One of the principal questions on my mind is: how do we deal with systems that are inherently untrustworthy? Innately error-prone?**

One thing I'd like to note before we get started is I often put quotes around the term "AI" when referring to its use in the modern context (e.g. ChatGPT, LLM, etc.), since I do not believe it meets many useful definitions of "intelligence". If I do not put quotes around "AI", the quotes are implied! 

I also want to apologize in advance to any ML Theory people reading this who don't care for hand-wavy explanations and speculation. It's hard to be perfectly precise in this format! If you'd like to chat more, leave a comment or [send me an email](/contact/).

### Table of Contents
{:.no_toc}
* TOC
{:toc}

### The Trade Offs Users Face
Drawing inspiration from the patterns I've seen in others' usage of AI tools, I've formed the following three questions to ask yourself before applying an "AI" tool to your work:

1. **What is the cost of verification of an answer?**
2. **What is the accuracy of a quick verification? What about an extended verification?**
3. **What is the cost of answering a question yourself?**

As an illustration of a "positive pattern" and anti-pattern under these metrics, consider the following two examples.

**An anti-pattern: PDF Summarization.** Despite marketing to the contrary, LLMs still struggle to correct generate answers to questions, even if they have been "grounded" by feeding them documents to refer to. You, as the user, still need to be careful about (1) hallucinations, (2) "misunderstandings", (3) missing the point, and (4) biases towards certain parts of the document. Ultimately, _you still need to verify the results_ but this is as expensive as answering the question yourself! The cost of verification is the cost of "generation" -- you need to read the PDF to verify the accuracy of the LLM summary.

**A positive-pattern: Meeting Summarization.** A better example of a good use of these tools is meeting summarization. If meeting notes are sent out right after a meeting and they are verified by the participants, the verification cost is minimal and the accuracy is presumably high (since it is fresh on their minds). On the other hand, "answering the question themselves" is costly and error-prone -- one either needs to rewatch the meeting or take notes based on memory. The cost of generation _may_ be high, but on the other hand, the cost of verification is low and the accuracy rate is high.

For me at least, nearly every task relevant to me I can think of fails to make sense after considering those 3 points. As of now, I have not integrated any tools into my workflow, although the monetary cost and privacy concerns of using ChatGPT & friends definitely play a role in using it for tasks that pass my tests.


### A Bird's Eye View of a (Verification) Paradigm

Of the paradigms I've seen emerge in people's usage is a pattern akin to a "refinement loop". The basic idea is:

> User prompts -> AI generates an (often substandard) response -> User refines the prompt -> AI generates -> ...

Here is a basic diagram to show this flow:
<!-- https://www.mermaidchart.com/play?utm_source=mermaid_live_editor&utm_medium=toggle#pako:eNqrVkrOT0lVslIqTi0sTc1LTnXJTEwvSsyNyVMAgtDi1CJdOzttHx9fKwUbz7zMkszEHIWAovzcghI7bEqCS5OKSxLzUhKLUhTyS0sKSmHKgNK6QGW6IOVAdUGpaZl5qSkKBchG4VADN0epFgA0nzgp -->
<figure>
    <img src="/assets/per-post/fuzzy-dynamics/llm_user_interaction.svg" alt="A tiny architecture diagram" class="invertable" height="420" style="background: #eee;" />
    <figcaption>A tiny diagram showing the prompt refinement flow between a user and a LLM.</figcaption>
</figure>

This iterative refinement is one of the best tools that we currently have in our arsenal to deal with these error-prone systems. But it reminds my machine learning-inclined mind of something else: a form of gradient descent. A form of manual, multi-party, gradient descent where we iteratively refine our generated output to align it with our expectations.



<figure>
    <img src="/assets/per-post/fuzzy-dynamics/gradient_descent.svg" alt="A tiny architecture diagram" class="invertable" height="420" style="background: #eee;" />
    <figcaption>A small illustration of gradient descent, courtesy of <a href="https://commons.wikimedia.org/wiki/Category:Gradient_descent#/media/File:Gradient_descent.svg">Wikimedia</a>.</figcaption>
</figure>


### A Detour into Fuzzy Finding

Two of my favorite brain-worm topics have been [**Energy-Based Models**](https://en.wikipedia.org/wiki/Energy-based_model) and [**Langevin Dynamics**](https://en.wikipedia.org/wiki/Langevin_dynamics). These two topics have become intertwined in my mind after reading some recent literature linking the two concepts in the context of diffusion models (outside of those used for image generation). 

On a basic level, Langevin Dynamics describes a method for iteratively updating some input $\mathbf{X}$ according to the gradient of an "energy function", denoted $\nabla U$, plus some random noise, denoted $\mathbf{W}(t)$. A simplified version of the equation describing these dynamics is:

$$
\rm{d} \mathbf{X} = - \frac{1}{\gamma} \nabla U(\mathbf{X}) \rm{d}t + \frac{\sqrt{2}\sigma}{\gamma} \rm{d} \mathbf{W}(t)
$$

Stealing the intuitive explanation that a recent seminar talk speaker gave: this describes "taking a [random walk](https://en.wikipedia.org/wiki/Random_walk) on the surface of an energy function." Although it may be a little hand-wavy, I quite like this description. Using the [hill climbing analogy](https://en.wikipedia.org/wiki/Hill_climbing) of gradient descent: we are shifting our input in a way that it is navigating down a hill, with some noise describing a form of perturbation that allows for a certain amount of exploration.

For some, in the context of modern-day image generators built upon diffusion models, this explanation sort of makes sense. Our diffusion model image generators gradually denoise an image to be compatible with some prompt that may define the energy -- or compatibility -- landscape ($\nabla\mathbf{U}$).

Yet I also see another connection -- for those traditional CS nerds out there, you can think of this as a *butchered [A\* search algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm)*. Instead of moving according to Dijkstra's algorithm augmented by a heuristic function, here we move _randomly_ (in the manner of a random walk) augmented by a heuristic function (the gradient of our energy function). Perhaps you can even imagine a maze-solving algorithm built upon A\* that take a random direction while trying to minimize the heuristic ("as the bird flies" distance) function.

### Large Concept Models -- Fuzzy Finding in Latent Spaces

In [Meta's recent "Large Concept Model" paper](https://arxiv.org/abs/2412.08821), there are two key innovations that are related to our conversation about fuzzy finding and diffusion models. Meta described a method where we can:

1. Have a fixed _text encoder_ and train/evaluate the "meat" of the LLM separately.
2. After we have encoded our text, we can get the model to "reason" (ala "Chain of Thought") _in the **latent space** of the model_ by performing an operation akin to diffusion in the middle layers. The output is only decoded into "text space" after some number of diffusion steps.

Both of these tricks are pretty nifty, in my opinion, yet they both seem pretty intuitive, if not an natural method to try. 

<details>
<summary><strong>Detour:</strong> <i>Why do I think this is a natural thing to try?</i></summary> 
<div markdown=1>
Earlier I made the connection that through the user <-> LLM iterative refinement scheme, we are performing a version of gradient descent (or diffusion) by proxy. Chain of Thought achieves a similar goal in iterative refinement, although it is _self_-refinement versus multi-party.

Where reasoning "in concept space" comes into play is not necessarily that "thoughts don't need to be in natural language" (as some people have commented in response to that paper), but it's rather, in my opinion, that the gradient (of the energy function) is naturally defined in latent "concept" space, and you don't suffer information loss. 

While the human<->LLM interaction and Chain of Thought prompting provide visibility (and verifiability), you can't take the "true gradient" with respect to some platonic answer energy landscape. This is something that is easily achievable if you consider performing diffusion in latent space before decoding an answer.
</div>
</details>

**Of relevance to this post is that number (2)**. What I believe that Meta is doing here, in a general sense, is realizing some of the true power of diffusion and energy functions. Yes, the outputs from the model will not (necessarily) be more sound or accurate, but what it allows us to do is think of these models in that more general "fuzzy finder" sense!

### Program Synthesis, No Free Lunch

As I have alluded to in this post, one of the crucial paths forward that I see for improving the way we use our current paradigm of models is through _use as fuzzy finders_, such as through Langevin dynamics. In training any sort of machine learning model, something you are implicitly training is a narrowed representation of some concept space. If we can utilize these representations efficiently, and have a manner of querying that representation (e.g. through an energy function), then we may have a way of navigating that space.

There are many problems that are computationally infeasible on their own or have too many paths to follow. Whether you are trying to have a Python program automatically synthesized, or are trying to rephrase and refine an idea you had, leveraging the learned priors of these models converts infeasible problems to feasible, albeit at the cost of a lot of energy. Luckily for us, if we remove the "generative" requirement of our model, the narrow representations of smaller "weak learners" can still shine.

I would be remiss to fail to mention the bias problem. Of course, biases are still prevalent in these models. In doing a search in this high-dimensional space, there may be parts of that space explored due to the biases inherent in the trained model. Perhaps in some tasks, like program synthesis, this does not matter as much.

### Conclusion

Once I connected those dots, I gained a piece of insight that I think has allowed me to answer at least some of my question of "What are good uses for these error-prone systems?" The (partial) answer I came to is both satisfying and also not.

Perhaps the true value of our current paradigm of fuzzy models is not necessarily in generation itself, but rather in the representations they learn and how we may leverage them. 

Put more simply, perhaps we can consider a reformulated version of energy-based models as a fuzzy "compass" that may lead us around high-dimensional spaces. **The power of these models might not be in the _answers_ they provide but instead be the in _guidance_ they yield.**

