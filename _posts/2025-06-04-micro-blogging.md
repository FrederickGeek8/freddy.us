---
layout: post
title: Microblogging Is Fun! (Maybe)
date: 2025-06-04 14:00:00 -0400
category: meta
description: >-
    A number of blogs that I read have inspired me to try my hand at "microblogging".
    I've now added this feature to my blog, so here we go!
tags: [meta-update]
post_id: microblogging
---

I follow a number of blogs that either explicitly have a feed for "micro-posts" (like [aliquote.org](https://aliquote.org/)), or more generally have short-form, "off the dome"-style content in addition to their longer posts. I think there is something pretty empowering about that, especially when disconnected from social media, and as I discussed in my [recent "A New Era for My Blog" post]({% post_url 2025-05-23-a-new-era %}):

> In line with my goals this year, I hope to remove some _personal_ barriers to entry to writing, like:
> - **"Micro-blogging" -- not every post needs to be a long, well-thought-out essay!**
> - "Drafts folder" -- I have had several posts sitting in a "drafts" state for a long time. Some for over 1 year! It would be great to have a "drafts" tag on my blog for those posts.
> - Ideas in Math/CS -- "micro-papers"

In making progress towards that goal, I spent some time today modifying [the code for freddy.us](https://github.com/FrederickGeek8/freddy.us) and [my fork of `jekyll-feed`](https://github.com/FrederickGeek8/jekyll-feed), and ultimately wrote a micro-blogging system for freddy.us. If you're reading this post, those changes should now be live!

**By default, the "micro-posts" are hidden**, but can be found by clicking the "Show micros" link on the main Blog page ([/blog/](/blog/)). This is to avoid spamming the main blog feed with these smaller posts.

<figure>
    <img src="/assets/per-post/2025-06-04-micro-blogging/screenshot.png" alt='A screenshot of the "Show micros button' width="256" />
    <figcaption>A screenshot of the "Show micros button on the main blog page.</figcaption>
</figure>

In a similar spirit, there are two separate RSS feeds available (which you can find [on the RSS "hub" page](/feeds/)) depending on whether you want my "micro-posts" including in your RSS feed: 
- The [**Main Blog RSS Feed**]({{ "feed.xml" | absolute_url }})
- The [**Main Blog RSS Feed _with_ "micro blog-posts"**]({{ "feed_w_microposts.xml" | absolute_url }})

For now, I am relatively happy with these changes. I'm unsure how I want to approach exposing "drafts" in the future, but I'm hoping I won't need to change the end-user semantics on my website to accommodate them.

I wrote a micropost after this. Can you find it?
