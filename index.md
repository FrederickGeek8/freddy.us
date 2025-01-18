---
layout: homepage
title: ""
---

## Exploring My Website!
You can find out more about my personal background, hobby & research passions, as well as my current tinkerings over on my [About Me](/about/) page. For more of a focus on my professional background and experiences, you may check out the [Resume/CV](/resume/) tab. Over on "[My Bookshelf](/bookshelf/)" you can find of my favorite books, blog posts, and papers that I've read recently.

My "[Blog](/blog/)" is... well... a blog. It supports RSS though! 

If you want to get in touch with me, you can check out my "[Get In Touch!](/contact/)" page. I am always open to have a quick "coffee chat" or collaborate on a project.

## News
{% assign sortedRec = site.data.news | sort: "date" | reverse %}
{% for item in sortedRec limit:3 %}
- {{ item.date }} -- {{ item.text }}
{% endfor %}
