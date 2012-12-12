blogify <- function(postDir){
  postFiles = dir(postDir, pattern = '*.Rmd', full = TRUE)
  posts = lapply(postFiles, parse_post)
  tags = get_pages_by_groups(posts, 'tags')
  lapply(posts, function(post){
    post$site = modifyList(post$site, list(
      tags = tags, 
      posts = lapply(posts, "[", c('title', 'link', 'file', 'date'))
    ))
    render_post(post)
    return(invisible())
  })
}

parse_post <- function(inputFile){
  knitr::opts_knit$set(fig.path = "assets/fig/")
  post = inputFile %|% knit %|% parse_deck
  post$file = inputFile
  if (!is.null(post$date)) {
    post$date = as.Date(post$date, '%Y-%m-%d')
  }
  post$link = gsub("*.Rmd", ".html", post$file)
  return(post)
}

get_pages_by_groups <- function(pages, gby = 'tags'){
  get_pages_by_group = function(g){
    p = pages[sapply(pages, function(page) g %in% page[[gby]])]
    p2 = lapply(lapply(p, '[', c('title', 'file', 'date')), function(x){
      x$url = gsub("*.Rmd", ".html", x$file);
      return(x)
    })
    list(pages = p2, name = g, count = length(p))
  }
  get_all_groups <- function(){
    g = lapply(pages, '[[', gby)
    Reduce('union', g)
  }
  lapply(get_all_groups(), get_pages_by_group)
}
