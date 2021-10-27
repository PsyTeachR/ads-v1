# source("renv/activate.R")
library(stats)
source("book/R/psyteachr_setup.R")

print.ggplot <- function(plot, ...){
  if (interactive() && !isTRUE(getOption("knitr.in.progress"))) {
    filename <- tempfile(fileext = ".png")
    suppressMessages(ggplot2::ggsave(filename, plot, ...))
    print(knitr::include_graphics(filename))
  } else {
    ggplot2:::print.ggplot(plot)
  }
  invisible(NULL)
}


print.patchwork <- function(plot, ...){
  if (interactive() && !isTRUE(getOption("knitr.in.progress"))) {
    filename <- tempfile(fileext = ".png")
    suppressMessages(ggplot2::ggsave(filename, plot, ...))
    print(knitr::include_graphics(filename))
  } else {
    patchwork:::print.patchwork(plot)
  }
  invisible(NULL)
}
