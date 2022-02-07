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

# dl <- function(file, label = basename(file)) {
#   link <- paste0("https://psyteachr.github.io/ads-v1/", file)
#   downloadthis::download_link(
#     link = link,
#     button_label = label,
#     button_type = "default",
#     has_icon = TRUE,
#     icon = "fa fa-file-download"
#   )
# }
