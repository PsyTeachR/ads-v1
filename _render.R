# zip the data files
zipfile <- "book/data/data"
if (file.exists(zipfile)) file.remove(zipfile)
f.zip <- list.files("book/data", full.names = TRUE)
zip(zipfile, c(f.zip), flags = "-j")

# render the book
browseURL(
  xfun::in_dir("book", bookdown::render_book("index.Rmd", "bookdown::bs4_book"))
)


# browseURL(
#   xfun::in_dir("book", bookdown::preview_chapter("08-custom.Rmd", "bookdown::bs4_book"))
# )
