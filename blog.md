---
layout: post
title: "Posts"
description: Frederick Morlock's personal blog.
comments: false
tracking: true
---
{% for post in site.posts %}
  <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h3>
  <p><small><strong>Posted {{ post.date | date: "%B %e, %Y" }}</strong> in {{ post.category }}.
  <p>{{ post.description }}</p>
{% endfor %}
