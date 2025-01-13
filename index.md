---
layout: homepage
title: ""
---

## Exploring My Website!
Click the "[Research](/research/)" page to check out my research interests. You can also click the "[Projects](/projects/)" page to see my personal projects that I've made. "[My Bookshelf](/bookshelf/)" shows you some of my favorite books, blog posts, and papers that I've read recently.

My "[Blog](/blog/)" is... well... a blog. It supports RSS though! 

If you want to get in touch with me, you can check out my "[Get In Touch!](/contact/)" page. I am always open to have a quick "coffee chat" or collaborate on a project.

## Things I'm Working On
- lkjasdlf

## News
{% assign sortedRec = site.data.news | sort: "date" | reverse %}
{% for item in sortedRec limit:3 %}
- {{ item.date }} -- {{ item.text }}
{% endfor %}
