__Note__: Poirot shares a significant amount of codebase with Slidify. To ease development, I have integrated Poirot into the `dev` branch of Slidify. These will be ported back to Poirot once the code matures.

# Poirot

[Poirot](http://github.com/ramnathv/blogify) is an elegant, blog aware, static site generator to create, manage and publish websites with reproducible content using [R Markdown](http://www.r-project.org).

<a href="http://ramnathv.github.com/poirotBlog">
  <img width='600px' src="http://i.imgur.com/R6hhT.png" title="Hosted by imgur.com" alt="" />
</a>

## Installing Poirot

Poirot is still under development and can be installed from github using [devtools](http:github.com/hadley/devtools). You will also need to install the development versions of [slidify](http://github.com/ramnathv/slidify) and [slidifyLibraries](http://github.com/ramnathv/slidifyLibraries).

```{r eval = F}
require(devtools)
install_github('poirot', 'ramnathv')
install_github('slidify', 'ramnathv', ref = 'dev')
install_github('slidifyLibraries', 'ramnathv')
```


Poirot uses **markdown** for text content, **knitr** for code chunks and **mustache** for templating. Poirot is highly extensible using widgets. As a publishing framework for data scientists, Poirot comes pre-equipped with support for math, visualization and tables.

## Blogging with Poirot

You can start blogging with Poirot by cloning the sample blog, replacing the sample Rmd files with yours, modifying configuration in  `site.yml` and `posts/config.yml` and running `blogify(".")` from the root directory. You can view the blog by opening a local server using `python` or `ruby`.

```bash
$ git clone git@github.com:ramnathv/poirotBlog
$ cd poirotBlog
$ python -m SimpleHTTPServer 8080
$ open localhost:8080/posts
```


## How to contribute

You can [fork the repository](https://github.com/ramnathv/blogify) on Github.

## License

MIT License
