---
layout: post
title: "Posts"
description: Frederick Morlock's personal blog.
backlink: "/"
---

{% for post in site.posts %}

  <div class="post">
    <h3>
      <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </h3>
    <p>
      <strong>Posted {{ post.date | date: "%B %e, %Y" }}</strong> in {{ post.category }}.
    </p>
    <p>
      {{ post.description }}
    </p>
  </div>

{% endfor %}
