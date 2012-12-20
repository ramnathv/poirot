# Poirot

[Poirot](http://github.com/ramnathv/blogify) is an elegant, blog aware, static site generator to create, manage and publish reproducible content using [R Markdown](http://www.r-project.org).

---

**Installing Poirot**

Poirot is still under development and can be installed from github using [devtools](http:github.com/hadley/devtools). You will also need to install the development versions of [slidify](http://github.com/ramnathv/slidify) and [slidifyLibraries](http://github.com/ramnathv/slidifyLibraries).

```{r eval = F}
require(devtools)
install_github('poirot', 'ramnathv')
install_github('slidify', 'ramnathv', ref = 'dev')
install_github('slidifyLibraries', 'ramnathv')
```

Poirot uses **markdown** for text content, **knitr** for code chunks and **mustache** for templating. Poirot is highly extensible using widgets. As a publishing framework for data scientists, Poirot comes pre-equipped with support for math, visualization and tables.

