# book-specific code to include on every page

suppressPackageStartupMessages({
  library(kableExtra)
  # to get the function linking for tidyverse packages
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(readr)
  library(tibble)
  library(stringr)
  library(purrr)
  library(forcats)
})

# knitr::knit_engines$set(md = function(options) {
#   code <- gsub("^(#+)\\s+(.+)$", "<span class='md_header'>\\1 \\2</span>",
#                options$code)
#   code <- knitr:::one_string(code)
#   code <- gsub("`r([^`]+)`", "<span class='md_backtick'>`r\\1`</span>",
#                code, ignore.case = TRUE)
#
#   paste0("<pre class='md'><code>", code, "</code></pre>")
# })
