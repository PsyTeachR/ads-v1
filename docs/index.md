--- 
title: "Applied Data Skills"
subtitle: "Processing & Presenting Data"
author: "Emily Nordmann and Lisa DeBruine"
date: "2021-08-24"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
description: |
  This book provides an overview of the basic skills needed to turn raw data into informative summaries and visualisations presented in professional reports, presentations, and dashboards. The book will introduce learners to R, a programming language that can help automate working with data. The book will cover importing and processing data from spreadsheets, producing data summaries of descriptive statistics in tables, creating beautiful and informative visualisations, and constructing reports, presentations, and dashboards that automatically update when the underlying data changes.
url: https://psyteachr.github.io/ads-v1
github-repo: psyteachr/ads-v1
cover-image: images/twitter_card.png
apple-touch-icon: images/apple-touch-icon.png
apple-touch-icon-size: 180
favicon: images/favicon.ico
---



# Overview {-}

This book provides an overview of the basic skills needed to turn raw data into informative summaries and visualisations presented in professional reports, presentations, and dashboards. The book will introduce learners to R, a programming language that can help automate working with data. The book will cover importing and processing data from spreadsheets, producing data summaries of descriptive statistics in tables, creating beautiful and informative visualisations, and constructing reports, presentations, and dashboards that automatically update when the underlying data changes.

<div style="float: right; width: 200px; max-width: 25%;"><img src="images/logo.png" 
     style="width: 100%;"
     alt="ADS Hex Logo" /></div>

By the end of this book, you will be able to use R to:

* clean and process data  
* summarise data  
* informatively visualise data  
* create reusable report templates

## Conventions

This book will use the following conventions:

* File paths: <code class='path'>data/sales.csv</code>
* R Packages: <code class='package'>tidyverse</code>
* Functions: <code><span class='fu'>ggplot</span>(data)</code>
* Arguments: <code><span class='at'>width</span></code>
* Strings: <code><span class='st'>&quot;Lisa&quot;</span></code>
* Numbers: <code><span class='fl'>100</span></code>
* Logical values: <code><span class='cn'>TRUE</span></code>
* Other code: `x <- list(a = "Alligator", b = "Loki")`
* Glossary items: <a class='glossary' target='_blank' title='Discrete variables that have an inherent order, such as number of legs' href='https://psyteachr.github.io/glossary/o#ordinal'>ordinal</a>
* Internal links: Chapter\ \@ref(viz)
* External links: [Mastering Shiny](https://mastering-shiny.org/){target="_blank"}
* Menu/interface options: **`New File...`**

::: {.info data-latex=""}
Informational asides.
:::

::: {.warning data-latex=""}
Notes to warn you about something.
:::

::: {.dangerous data-latex=""}
Notes about things that could cause serious errors.
:::

::: {.try data-latex=""}
Try it yourself.
:::


```r
# code chunks
paste("Applied", "Data", "Skills", 1, sep = " ")
```

```
## [1] "Applied Data Skills 1"
```
