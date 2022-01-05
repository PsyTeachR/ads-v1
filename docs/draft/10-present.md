# Advanced Reports  {#present}

## Intended Learning Outcomes {#ilo-present}

* Structure data in report, dashboard, and presentation formats
* Include table of contents, figure and table captions, and references in longer reports


```r
library(tidyverse)     # data wrangling functions
library(flexdashboard) # for dashboards
```


## Reports


## Presentations


## Dashboards

After you install <code class='package'>flexdashboard</code>, you can choose a flexdashboard template when you create a new RMarkdown document. 

<div class="figure" style="text-align: center">
<img src="images/present/flexdashboard-template.png" alt="Flexdashbard RMarkdown template." width="100%" />
<p class="caption">(\#fig:img-flx-template)Flexdashbard RMarkdown template.</p>
</div>


<code style='font-size: smaller;'><pre>
---
title: "Demo"
output: 
  flexdashboard::flex_dashboard:
    social: [ "twitter", "facebook", "linkedin", "pinterest" ]
    source_code: embed
    orientation: columns
    vertical_layout: fill
---

```{r setup, include=FALSE}
library(flexdashboard)
```

Column {data-width=650}
-----------------------------------------------------------------------

### Chart A

```{r}

```

Column {data-width=350}
-----------------------------------------------------------------------

### Chart B

```{r}

```

### Chart C

```{r}

```

</pre></code>




## Resources {#resources-present}

* [RStudio Formats](https://rmarkdown.rstudio.com/formats.html)
* [Flexdashboard](https://pkgs.rstudio.com/flexdashboard/)





