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

# render the full draft book
xfun::in_dir("book", bookdown::render_book(config_file = "_bookdown_draft.yml"))
browseURL("docs/draft/index.html")

# render only completed chapters
# edit _bookdown_v1.yml to add chapters to rmd_files:
xfun::in_dir("book", bookdown::render_book(config_file = "_bookdown_v1.yml"))
browseURL("docs/index.html")

# preview a chapter (wrecks sidebar links)
 # browseURL(
 #   xfun::in_dir("book", bookdown::preview_chapter("02-reports.Rmd"))
 # )
