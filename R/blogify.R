pagify <- function(postFile){
  page = blogify:::parse_post(postFile)
  site = yaml.load_file('site.yml')
  render_page(page, payload = list(site = site))
}

blogify <- function(postDir){
  postFiles = dir(postDir, pattern = '*.Rmd', full = TRUE)
  pages = lapply(postFiles, blogify:::parse_post)
  site  = yaml.load_file('site.yml')
  render_pages(site, pages)
}

blogify <- function(postDir){
  postFiles = dir(postDir, pattern = '*.Rmd', full = TRUE)
  posts = lapply(postFiles, parse_post)
  tags = get_pages_by_groups(posts, 'tags')
  
  # Render all posts ----
  invisible(lapply(posts, function(post){
    post$site = modifyList(post$site, list(
      tags = tags, 
      posts = lapply(posts, "[", c('title', 'link', 'file', 'date'))
    ))
    render_post(post)
  }))
  
  # Extract R code from posts if any chunks present ---   
  invisible(lapply(postFiles, function(file){
    if (any(grep("^```\\{r", readLines(file)))){
      purl(file)
    }
  }))
  message('Blogification Successful :-)')
}

parse_post <- function(inputFile){
  opts_chunk$set(fig.path = "assets/fig/", cache.path = '.cache/', cache = TRUE)
  outputFile <- gsub(".Rmd", ".md", inputFile)
  post = knit(inputFile, outputFile) %|% parse_deck
  # post = inputFile %|% knit %|% parse_deck
  post$file = inputFile
  post$filename = tools:::file_path_sans_ext(inputFile)
  if (!is.null(post$date)) {
    post$date = as.Date(post$date, '%Y-%m-%d')
  }
  post$link = gsub("*.Rmd", ".html", post$file)
  post$raw = slidify:::read_file(inputFile)
  return(post)
}

get_pages_by_groups <- function(pages, gby = 'tags'){
  get_pages_by_group = function(g){
    p = pages[sapply(pages, function(page) g %in% page[[gby]])]
    p = lapply(p, '[', c('title', 'file', 'date', 'link'))
    list(pages = p, name = g, count = length(p))
  }
  get_all_groups <- function(){
    g = lapply(pages, '[[', gby)
    Reduce('union', g)
  }
  lapply(get_all_groups(), get_pages_by_group)
}

order_posts <- function(posts){
  d[order(as.Date(d$V3, format="%d/%m/%Y")),]
  x = order(unlist(lapply(posts, slidify:::pluck('date'))))
  posts[x]
}