---
layout: homepage
title: ""
---

## Exploring My Website!
You can find out more about my personal background, [research interests](/about/#research-interests), and my current tinkering and hobbies over on my [About Me](/about/) page. For more of a focus on my professional background and experiences, you may check out the [Resume/CV](/resume/) tab. Over on "[My Bookshelf](/bookshelf/)" you can find my favorite books, blog posts, and papers that I've read recently.

My "[Blog](/blog/)" is... well... a blog. It supports [RSS](/feeds/) too!

If you want to get in touch with me, or find the other platforms I'm on, you can check out my "[Contact Me](/contact/)" page. I am always open to having a quick "coffee chat" or collaborating on a project.

## Recent News
{% assign sortedRec = site.data.news | sort: "date" | reverse %}
{% for item in sortedRec limit:3 %}
- <time>{{ item.date }}</time> -- {{ item.text }}
{% endfor %}

## Recent Blog Posts
{% assign sortedRec = site.posts | sort: "date" | reverse %}
{% for item in sortedRec limit:3 %}
- <time>{{ item.date | date: "%Y-%m-%d" }}</time> -- **[{{ item.title }}]({{ item.url }})**
{% endfor %}
