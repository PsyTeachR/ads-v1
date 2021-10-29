# zip the data files
zipfile <- "book/data/data"
if (file.exists(zipfile)) file.remove(zipfile)
f.zip <- list.files("book/data", full.names = TRUE)
zip(zipfile, c(f.zip), flags = "-j")

# copy data directory to docs
R.utils::copyDirectory(
  from = "book/data",
  to = "docs/data",
  overwrite = TRUE,
  recursive = TRUE)

# render the book

xfun::in_dir("book", bookdown::render_book("index.Rmd"))
browseURL("docs/index.html")

# preview a chapter (wrecks sidebar links)
 browseURL(
   xfun::in_dir("book", bookdown::preview_chapter("02-reports.Rmd"))
 )
