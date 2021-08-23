# render the book

browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::gitbook"))
)
