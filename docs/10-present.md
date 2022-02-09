# Advanced Reports  {#present}

<div class="incomplete-chapter"></div>

## Intended Learning Outcomes {#ilo-present}

* Structure data in report, presentation, and dashboard formats
* Include linked figures, tables, and references


```r
library(tidyverse)     # data wrangling functions
library(bookdown)      # for chaptered reports
library(flexdashboard) # for dashboards
library(DT)            # for interactive tables
```

Download the [R Markdown Cheat Sheet](https://www.rstudio.org/links/r_markdown_cheat_sheet).

Until now, we've only used the default `html_document` output format in an <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R markdown</a> report, but there are several other [output formats](https://rmarkdown.rstudio.com/formats.html){target="_blank"} that you can try.

## Reports

### Word documents

In the <a class='glossary' target='_blank' title='A structured format for information' href='https://psyteachr.github.io/glossary/y#yaml'>YAML</a> header of an R Markdown document, you can change output to `word_document` to create a Microsoft Word file. Make sure you carefully check your file; images and tables can often look odd or page breaks can happen in strange ways.

You can add page breaks by adding `\newpage` on a line by itself with blank lines above and below.

### PDF documents

If you have a latex installation (see Appendix\ \@ref(installing-r)), you can create a PDF by setting output to `pdf_document`. 

Note that this can sometimes cause problems with <code class='package'>kableExtra</code> tables and you can't use some elements like interactive plots. Additionally, the figures and tables are likely to shift from their position in text to the top or bottom of pages. 

See the [PDF section](https://bookdown.org/yihui/rmarkdown/pdf-document.html){target="_blank"} of *R Markdown: The Definitive Guide* [@rmarkdown_definitive] for more advanced customisation options.

### Linked documents

If you need to create longer reports with links between sections, you can use one of the bookdown formats. `bookdown::html_document2` is a useful one that adds figure and table numbers automatically to any figures or tables with a caption and allows you to link to these by reference.

Refer to figures and tables like the code below. Figures start with "fig:" and tables with "tab:", then the code <a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>chunk</a> name that created the figure or table.

```
See Table\ \@ref(tab:table-name) or Figure\ \@ref(fig:fig-name).
```

::: {.warning data-latex=""}
The code chunk names can only contain letters, numbers and dashes. If they contain other characters like spaces or underscores, the referencing will not work.
:::

The code below shows how to link text to figures or tables. You can see the [HTML output here](demos/html_document2.html).


<div class='webex-solution'><button>Solution</button>



````md
---
title: "Linked Document Demo"
output: 
  bookdown::html_document2:
    number_sections: false
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
                      message = FALSE,
                      warning = FALSE)
library(tidyverse)
library(kableExtra)
theme_set(theme_minimal())
```

Diamond price depends on many features, such as:

- cut (See Table\ \@ref(tab:by-cut))
- colour (See Table\ \@ref(tab:by-colour))
- clarity (See Figure\ \@ref(fig:by-clarity))
- carats (See Figure\ \@ref(fig:by-carat))

## Tables

### Cut

```{r by-cut}
diamonds %>%
  group_by(cut) %>%
  summarise(avg = mean(price),
            .groups = "drop") %>%
  kable(digits = 0, 
        col.names = c("Cut", "Average Price"),
        caption = "Mean diamond price by cut.") %>%
  kable_material()
```

### Colour

```{r by-colour}
diamonds %>%
  group_by(color) %>%
  summarise(avg = mean(price),
            .groups = "drop") %>%
  kable(digits = 0, 
        col.names = c("Cut", "Average Price"),
        caption = "Mean diamond price by colour.") %>%
  kable_material()
```

## Plots

### Clarity

```{r by-clarity, fig.cap = "Diamond price by clarity"}
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot() 
```

### Carats

```{r by-carat, fig.cap = "Diamond price by carat"}
ggplot(diamonds, aes(x = carat, y = price)) +
  stat_smooth()
```

````


</div>


This format defaults to numbered sections, so set `number_sections: false` in the <a class='glossary' target='_blank' title='A structured format for information' href='https://psyteachr.github.io/glossary/y#yaml'>YAML</a> header if you don't want this.

### References

There are several ways to do in-text references and automatically generate a [bibliography](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html){target="_blank"} in R Markdown. Markdown files need to link to a BibTex file (a plain text file with references in a specific format) that contains the references you need to cite. You specify the name of this file in the YAML header, like `bibliography: filename.bib` and cite references in text using an at symbol and a shortname, like `[@tidyverse]`.

#### Creating a BibTeX file

Most reference software like EndNote, Zotero or Mendeley have exporting options that can export to BibTeX format. You just need to check the shortnames in the resulting file.

You can also make a BibTeX file and add references manually. In RStudio, go to **`File`** > **`New File...`** > **`Text File`** and save the file as "bibliography.bib".

Next, add the line `bibliography: bibliography.bib` to your YAML header.

#### Adding references

You can add references to a journal article in the following format:

```
@article{shortname,
  author = {Author One and Author Two and Author Three},
  title = {Paper Title},
  journal = {Journal Title},
  volume = {vol},
  number = {issue},
  pages = {startpage--endpage},
  year = {year},
  doi = {doi}
}
```

See [A complete guide to the BibTeX format](https://www.bibtex.com/g/bibtex-format/){target="_blank"} for instructions on citing books, techincal reports, and more.

You can get the reference for an R package using the functions `citation()` and `toBibtex()`. You can paste the bibtex entry into your bibliography.bib file. Make sure to add a short name (e.g., "ggplot2") before the first comma to refer to the reference.


```r
citation(package="ggplot2") %>% toBibtex()
```

```
## @Book{,
##   author = {Hadley Wickham},
##   title = {ggplot2: Elegant Graphics for Data Analysis},
##   publisher = {Springer-Verlag New York},
##   year = {2016},
##   isbn = {978-3-319-24277-4},
##   url = {https://ggplot2.tidyverse.org},
## }
```


[Google Scholar](https://scholar.google.com/) entries have a BibTeX citation option. This is usually the easiest way to get the relevant values, although you have to add the DOI yourself. You can keep the suggested shortname or change it to something that makes more sense to you.

#### Citing references

You can cite references in text like this: 

```
This tutorial uses several R packages [@tidyverse;@rmarkdown].
```

This tutorial uses several R packages [@tidyverse;@rmarkdown].

Put a minus in front of the @ if you just want the year:

```
Franconeri and colleagues [-@franconeri2021science] review research-backed guidelines for creating effective and intuitive visualizations.
```

Franconeri and colleagues [-@franconeri2021science] review research-backed guidelines for creating effective and intuitive visualizations.


If you want to add an item to the reference section without citing it, add it to the YAML header like this:

```
nocite: |
  @ref1, @ref2, @ref3
```

Or add all of the items in the .bib file like this:

```
nocite: '@*'
```

#### Citation styles

You can search a [list of style files](https://www.zotero.org/styles){target="_blank"} (e.g., APA, MLA, Harvard) and download a file that will format your bibliography. You'll need to add the line `csl: filename.csl` to your YAML header. 

#### Reference section

By default, the reference section is added to the end of the document. If you want to change the position (e.g., to add figures and tables after the references), include `<div id="refs"></div>` where you want the references. 

### Interactive tables

One way to make your reports more exciting is to use interactive tables. The `DT::datatable()` function displays a table with some extra interactive elements to allow readers to search and reorder the data, as well as controlling the number of rows shown at once. This can be especially helpful. This only works with HTML output types. The [DT website](https://rstudio.github.io/DT/){target="_blank"} has extensive tutorials, but we'll cover the basics here.


```r
library(DT)

scotpop <- read_csv("data/scottish_population.csv", 
                    show_col_types = FALSE)

datatable(data = scotpop)
```

```{=html}
<div id="htmlwidget-f136803105dc6de1ba24" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f136803105dc6de1ba24">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"],["Aberdeen","Aberdeenshire","Angus","Argyll and Bute","Edinburgh","Clackmannanshire","Dumfries and Galloway","Dundee","East Ayrshire","East Dunbartonshire","East Lothian","East Renfrewshire","Eilean Siar","Falkirk","Fife","Glasgow","Highland","Inverclyde","Midlothian","Moray","North Ayrshire","North Lanarkshire","Orkney","Perthshire and Kinross","Renfrewshire","Scottish Borders","Shetland Islands","South Ayrshire","South Lanarkshire","Stirling","West Dunbartonshire","West Lothian"],[217120,245780,110570,89200,486120,50630,148190,144290,120240,104580,97500,89540,26190,153280,365020,592820,221630,79770,81140,87720,135180,326360,20110,147780,170250,112870,22400,111440,311880,89850,90570,172080]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>name<\/th>\n      <th>population<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":2},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```


You can customise the display, such as changing column names, adding a caption, moving the location of the filter boxes, removing row names, applying [classes](https://datatables.net/manual/styling/classes){target="_blank"} to change table appearance, and applying [advanced options](https://datatables.net/reference/option/){target="_blank"}.


```r
# https://datatables.net/reference/option/
my_options <- list(
  pageLength = 5, # how many rows are displayed
  lengthChange = FALSE, # whether pageLength can change
  info = TRUE, # text with the total number of rows
  paging = TRUE, # if FALSE, the whole table displays
  ordering = FALSE, # whether you can reorder columns
  searching = FALSE # whether you can search the table
)

datatable(
  data = scotpop,
  colnames = c("County", "Population"),
  caption = "The population of Scottish counties.",
  filter = "none", # "none", "bottom" or "top"
  rownames = FALSE, # removes the number at the left
  class = "cell-border hover stripe", # default is "display"
  options = my_options
)
```

```{=html}
<div id="htmlwidget-326245f3425689972af3" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-326245f3425689972af3">{"x":{"filter":"none","vertical":false,"caption":"<caption>The population of Scottish counties.<\/caption>","data":[["Aberdeen","Aberdeenshire","Angus","Argyll and Bute","Edinburgh","Clackmannanshire","Dumfries and Galloway","Dundee","East Ayrshire","East Dunbartonshire","East Lothian","East Renfrewshire","Eilean Siar","Falkirk","Fife","Glasgow","Highland","Inverclyde","Midlothian","Moray","North Ayrshire","North Lanarkshire","Orkney","Perthshire and Kinross","Renfrewshire","Scottish Borders","Shetland Islands","South Ayrshire","South Lanarkshire","Stirling","West Dunbartonshire","West Lothian"],[217120,245780,110570,89200,486120,50630,148190,144290,120240,104580,97500,89540,26190,153280,365020,592820,221630,79770,81140,87720,135180,326360,20110,147780,170250,112870,22400,111440,311880,89850,90570,172080]],"container":"<table class=\"cell-border hover stripe\">\n  <thead>\n    <tr>\n      <th>County<\/th>\n      <th>Population<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"lengthChange":false,"info":true,"paging":true,"ordering":false,"searching":false,"columnDefs":[{"className":"dt-right","targets":1}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```



## Other formats

You can create more than just reports with R Markdown. You can also create presentations, interactive dashboards, books, websites, and web applications.

### Presentations

You can choose a presentation template when you create a new R Markdown document. We'll use ioslides for this example, but the other formats work similarly.

<div class="figure" style="text-align: center">
<img src="images/present/new-ioslides.png" alt="Ioslides RMarkdown template." width="100%" />
<p class="caption">(\#fig:img-ioslides-template)Ioslides RMarkdown template.</p>
</div>

The main differences between this and the Rmd files you've been working with until now are that the `output` type in the <a class='glossary' target='_blank' title='A structured format for information' href='https://psyteachr.github.io/glossary/y#yaml'>YAML</a> header is `ioslides_presentation` instead of `html_document` and this format requires a specific title structure. Each slide starts with a level-2 header.

The template provides you with examples of text, bullet point, code, and plot slides. You can knit this template to create an <a class='glossary' target='_blank' title='Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages.' href='https://psyteachr.github.io/glossary/h#html'>HTML</a> document with your presentation. It often looks odd in the RStudio built-in browser, so click the button to open it in a web browser. You can use the space bar or arrow keys to advance slides.

The code below shows how to load some packages and display text, a table, and a plot. You can see the [HTML output here](demos/ioslides.html).


<div class='webex-solution'><button>Solution</button>



````md
---
title: "Presentation Demo"
author: "Lisa DeBruine"
output: ioslides_presentation
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
library(tidyverse)
library(kableExtra)
```

## Slide with Markdown

The following slides will present some data from the `diamonds` dataset from **ggplot2**.

Diamond price depends on many features, such as:

- cut
- colour
- clarity
- carats

## Slide with a Table

```{r}
diamonds %>%
  group_by(cut, color) %>%
  summarise(avg_price = mean(price),
            .groups = "drop") %>%
  pivot_wider(names_from = cut, values_from = avg_price) %>%
  kable(digits = 0, caption = "Mean diamond price by cut and colour.") %>%
  kable_material()
```

## Slide with a Plot

```{r pressure}
ggplot(diamonds, aes(x = cut, y = price, color = color)) +
  stat_summary(fun = mean, geom = "point") +
  stat_summary(aes(x = as.integer(cut)), 
               fun = mean, geom = "line") +
  scale_x_discrete(position = "top") +
  scale_color_viridis_d(guide = guide_legend(reverse = TRUE)) +
  theme_minimal() 
```

````


</div>


### Dashboards

Dashboards are a way to display text, tables, and plots with dynamic formatting. After you install <code class='package'>flexdashboard</code>, you can choose a flexdashboard template when you create a new R Markdown document. 

<div class="figure" style="text-align: center">
<img src="images/present/flexdashboard-template.png" alt="Flexdashboard RMarkdown template." width="100%" />
<p class="caption">(\#fig:img-flx-template)Flexdashboard RMarkdown template.</p>
</div>

The code below shows how to load some packages, display two tables in a tabset, and display two plots in a column. You can see the [HTML output here](demos/flexdashboard.html).


<div class='webex-solution'><button>Solution</button>



````md
---
title: "Flexdashboard Demo"
output: 
  flexdashboard::flex_dashboard:
    social: [ "twitter", "facebook", "linkedin", "pinterest" ]
    source_code: embed
    orientation: columns
    vertical_layout: fill
---

```{r setup, include=FALSE}
library(flexdashboard)
library(tidyverse)
library(kableExtra)
library(DT) # for interactive tables
theme_set(theme_minimal())
```

Column {data-width=350, .tabset}
--------------------------------

### By Cut

This table uses `kableExtra` to render the table with a specific theme.

```{r}
diamonds %>%
  group_by(cut) %>%
  summarise(avg = mean(price),
            .groups = "drop") %>%
  kable(digits = 0, 
        col.names = c("Cut", "Average Price"),
        caption = "Mean diamond price by cut.") %>%
  kable_classic()
```

### By Colour

This table uses `DT::datatable()` to render the table with a searchable interface.

```{r}
diamonds %>%
  group_by(color) %>%
  summarise(avg = mean(price),
            .groups = "drop") %>%
  DT::datatable(colnames = c("Colour", "Average Price"), 
                caption = "Mean diamond price by colour",
                options = list(pageLength = 5),
                rownames = FALSE) %>%
  DT::formatRound(columns=2, digits=0)
```

Column {data-width=350}
-----------------------

### By Clarity

```{r by-clarity, fig.cap = "Diamond price by clarity"}
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot() 
```


### By Carats

```{r by-carat, fig.cap = "Diamond price by carat"}
ggplot(diamonds, aes(x = carat, y = price)) +
  stat_smooth()
```

````


</div>


Change the size of your web browser to see how the boxes, tables and figures change.

The best way to figure out how to format a dashboard is trial and error, but you can also look at some [sample layouts](https://pkgs.rstudio.com/flexdashboard/articles/layouts.html){target="_blank"}.

### Books

You can create online books with <code class='package'>bookdown</code>. In fact, the book you're reading was created using bookdown. After you download the package, start a new project and choose "Book project using bookdown" from the list of project templates. 

<div class="figure" style="text-align: center">
<img src="images/present/bookdown.png" alt="Bookdown project template." width="100%" />
<p class="caption">(\#fig:img-bookdown-template)Bookdown project template.</p>
</div>

Each chapter is written in a separate .Rmd file and the general book settings can be changed in the `_bookdown.yml` and `_output.yml` files. 

### Websites

You can create a simple website the same way you create any R Markdown document. Choose "Simple R Markdown Website" from the project templates to get started. See Appendix\ \@ref(webpages) for a step-by-step tutorial.

For more complex, blog-style websites, you can investigate [<code class='package'>blogdown</code>](https://bookdown.org/yihui/blogdown/). After you install this package, you will also be able to crate template blogdown projects to get you started.

### Shiny

To get truly interactive, you can take your R coding to the next level and learn Shiny. Shiny apps let your R code react to user input. You can do things like [make a word cloud](https://shiny.psy.gla.ac.uk/debruine/wordcloud/), [search a google spreadsheet](https://shiny.psy.gla.ac.uk/debruine/seen/), or [conduct a survey](https://shiny.psy.gla.ac.uk/debruine/question/).

This is well outside the scope of this class, but the skills you've learned here provide a good start. The free book [Building Web Apps with R Shiny](https://debruine.github.io/shinyintro/) by one of the authors of this book can get you started creating shiny apps.

## Further resources {#resources-present}

* [RStudio Formats](https://rmarkdown.rstudio.com/formats.html)
* [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook)
* [DT](https://rstudio.github.io/DT/)
* [Flexdashboard](https://pkgs.rstudio.com/flexdashboard/)
* [Bookdown](https://bookdown.org/yihui/bookdown/)
* [Blogdown](https://bookdown.org/yihui/blogdown/)
* [Shiny](https://shiny.rstudio.com/)
* [Building Web Apps with R Shiny](https://debruine.github.io/shinyintro/)



