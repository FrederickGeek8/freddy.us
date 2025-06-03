---
layout: blog.basic
title: "RSS/Atom Feeds"
permalink: "/feeds/"
redirect_from: "/feed/"
---

<h1 id="title">{{ page.title }}</h1>

There are multiple RSS/Atom<sup><a href="#note-1">[1]</a></sup> feeds available on freddy.us, depending on what content you want to subscribe to.

The most important feed is the [**Primary Blog RSS Feed**]({{ "feed.xml" | absolute_url }}) located at [**{{ "feed.xml" | absolute_url }}**]({{ "feed.xml" | absolute_url }}).

There are other RSS feeds available if you do not want to subscribe to all posts.

## Per Category Feeds
If you'd prefer to just subscribe to one category, there are individual feeds for each:
{% for category in site.categories %}
- [{{ category[0] }}]({{ "/feed/" | absolute_url | append: category[0] | append: ".xml" }})
{% endfor %}

## Per Tag Feeds
Tags are more granual than feeds, and each blog post can have multiple tags (versus just a single category). If you'd prefer a more granual feed than the per-category feeds, you can subscribe to individual tags:
{% for tag in site.tags %}
- [{{ tag[0] }}]({{ "/feed/by_tag/" | absolute_url | append: tag[0] | append: ".xml" }})
{% endfor %}

<hr style="max-width: 250px; margin: 30px auto;" />
<p>
    <sup id="note-1">[1]</sup> This website uses <em>Atom</em> feeds rather than RSS feeds, however, most RSS readers also support the Atom feed standard.
</p>
