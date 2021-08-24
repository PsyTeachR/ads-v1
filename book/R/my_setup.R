# book-specific code to include on every page

hl <- function(code) {
  txt <- rlang::enexpr(code) %>% rlang::as_label()

  downlit::highlight(txt, classes = downlit::classes_pandoc()) %>%
    paste0("<code>", . , "</code>")
}

path <- function(txt) {
  sprintf("<code class='path'>%s</code>", txt)
}

pkg <- function(txt) {
  sprintf("<code class='package'>%s</code>", txt)
}
