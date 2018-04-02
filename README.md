# R vs Python

Despite that machine learning is growing exponentially, references are generally disorganized and incomplete. Documentation is spread out, tutorials are wordy and hard to browse. This app attempts to put as many relevant algorithms and tricks in one place, with R and Python code side by side. While language comparisons exist, they are usually introductory and not comprehensive.

R vs Python was intended to be hosted as a static site to reduce server costs; therefore, I intentionally avoided using a backend. Still, I wanted some of the functionality of templates and partials. Handlebars.js seems like overkill, but still lacks the 'extends' functionality of Django. I decided to write my own simple templates in Javascript, so that I could update the menu as an XML document, and update codes and descriptions without touching the main site entirely. This has the advantage of organization, avoiding clutter.

Prism.js is used for code highlighting, and MathJax is used for LaTeX.

## Built With

* [Prism](http://prismjs.com/) - Code highlighting
* [MathJax](https://www.mathjax.org/) - Asynchronous LaTeX

## Authors

* **Jonathan Chang** - *Initial work* - [PurpleBooth](https://github.com/jachang820)
