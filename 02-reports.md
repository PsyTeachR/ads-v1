# Reports with R Markdown {#reports}

## Intended Learning Outcomes {#ilo-reports}

-   Be able to knit a simple reproducible report with R Markdown
-   Be able to edit Markdown to show/hide code and use inline coding
-   Be able to identify different types of data

You'll learn about the following functions in this chapter:

* `knitr::opts_chunk$set()`
* `kableExtra::kable()`
* `kableExtra::add_header_above()`
* `kableExtra::row_spec()`
* `kableExtra::column_spec()`
* `kableExtra::kable_classic()`

The chapter also has examples that uses functions that you'll learn more about in later chapters. Don't worry about learning these functions this week; just copy the examples into your practice script.

<!--
* `readr::read_csv()`
* `nrow()`
* `min()`
* `max()`
* `dplyr::group_by()`
* `dplyr::count()`
* `tidyr::pivot_wider()`
* `print()`
* `ggplot2::ggplot()`
* `ggplot2::aes()`
* `ggplot2::geom_violin()`
* `ggplot2::xlab()`
* `ggplot2::scale_y_continuous()`
* `ggplot2::scale_fill_viridis_d()`
* `ggplot2::theme()`
* `dplyr::summarise()`
* `dplyr::mutate()`
-->

## Setup {#setup-repro}

<div class="chunk" id="unnamed-chunk-42"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(tidyverse)</span>
<span class="hl kwd">library</span><span class="hl std">(knitr)</span>
<span class="hl kwd">library</span><span class="hl std">(kableExtra)</span>
</pre></div>
</div></div>































