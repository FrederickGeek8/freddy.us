---
layout: post
title: "Posts"
description: Frederick Morlock's personal blog.
permalink: '/blog/'
---

{% for post in site.posts %}

  <div class="post">
    <h3>
      <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </h3>
    <p>
      <b>Posted {{ post.date | date: "%B %e, %Y" }}</b> in {{ post.category }}.

      {% if post.last_modified_at %}
      <b><i>Last Updated {{ post.last_modified_at | date: "%B %e, %Y" }}</i></b>
      {% endif %}
    </p>
    <p>
      {{ post.description }}
    </p>
  </div>

{% endfor %}
