---
layout: blog.default
title: "Posts"
description: Frederick Morlock's personal blog.
permalink: '/blog/'
redirect_from: /blog.html
---

{% include ext-navigation.html %}

<div class="container tight">
<main>
  <header>
    <h1 id="title">Frederick's Blog</h1>
  </header>

  <h2>{{ page.title }}</h2>

  <div class="spacer">
    <b>Abstract:</b>
    <p>{{ page.description }}</p>
  </div>

{% for post in site.posts %}

  <div class="post">
    <h3>
      <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </h3>
    <p>
      <b>Posted:</b> {{ post.date | date: "%B %e, %Y" }} in
      <a href="/blog/categories/{{ post.category }}/">{{ post.category }}</a>. {%
      if post.last_modified_at %}
      <i
        ><b>Last Updated:</b> {{ post.last_modified_at | date: "%B %e, %Y" }}</i
      >
      {% endif %}
    </p>
    <p>
      {{ post.description }}
    </p>
  </div>

{% endfor %}
</main>
</div>

{% include footer.html tight='true' %}
