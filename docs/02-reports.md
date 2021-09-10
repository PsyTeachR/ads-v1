# Reports with R Markdown {#reports}

## Intended Learning Outcomes {#ilo-reports}

-   Be able to knit a simple reproducible report with R Markdown
-   Be able to edit Markdown to show/hide code and use inline coding
-   Be able to identify different types of data


```r
library(tidyverse) # readr, dplyr, tidyr, ggplot2
library(knitr)
library(kableExtra)
```

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




## Organising a project {#projects}

First, we need to get organised.

<a class='glossary' target='_blank' title='A way to organise related files in RStudio' href='https://psyteachr.github.io/glossary/p#project'>Projects</a> in RStudio are a way to group all of the files you need for one project. Most projects include scripts, data files, and output files like the PDF version of the script or images.

::: {.try data-latex=""}
Make a new <a class='glossary' target='_blank' title='A collection or “folder” of files on a computer.' href='https://psyteachr.github.io/glossary/d#directory'>directory</a> where you will keep all of your materials for this class.

Choose **`New Project...`** under the **`File`** menu to create a new project called <code class='path'>02-reports</code> in this directory.
:::

### Working Directory

Where should you put all of your files? You usually want to have all of your scripts and data files inside one folder on your computer, the <a class='glossary' target='_blank' title='The filepath where R is currently reading and writing files.' href='https://psyteachr.github.io/glossary/w#working-directory'>working directory</a>. You can organise files in subdirectories inside this main project directory, such as putting all raw data files in a directory called <code class='path'>data</code> and saving any image files to a directory called <code class='path'>images</code>.

Your script should only reference files in three locations, using the appropriate format.

| Where                    | Example                                                          |
|--------------------------|------------------------------------------------------------------|
| on the web               | "<https://psyteachr.github.io/ads-v1/data/widgets_gadgets.xlsx>" |
| in the working directory | "widgets_gadgets.xlsx"                                           |
| in a subdirectory        | "data/widgets_gadgets.xlsx"                                      |

::: {.warning data-latex=""}
Never set or change your working directory in a script.
:::

R Markdown files will automatically use the same directory the .Rmd file is in as the working directory.

If your script needs a file in a subdirectory of your working directory, such as, <code class='path'>data/widgets_gadgets.xlsx</code>, load it in using a <a class='glossary' target='_blank' title='The location of a file in relation to the working directory.' href='https://psyteachr.github.io/glossary/r#relative-path'>relative path</a> so that it is accessible if you move the working directory to another location or computer:


```r
dat <- read_csv("data/widgets_gadgets.xlsx")  # correct
```

Do not load it in using an <a class='glossary' target='_blank' title='A file path that starts with / and is not appended to the working directory' href='https://psyteachr.github.io/glossary/a#absolute-path'>absolute path</a>:


```r
dat <- read_csv("C:/Carla's_files/yearly_reports/2020-2021/data/widgets_gadgets.xlsx")   # wrong
```

::: {.info data-latex=""}
Also note the convention of using forward slashes, unlike the Windows-specific convention of using backward slashes. This is to make references to files work for everyone, regardless of their operating system.
:::

### Naming Things

Name files so that both people and computers can easily find things. Here are some important principles:

-   file and directory names should only contain letters, numbers, dashes, and underscores, with a full stop (`.`) between the file name and <a class='glossary' target='_blank' title='The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd).' href='https://psyteachr.github.io/glossary/e#extension'>extension</a> (that means no spaces!)
-   be consistent with capitalisation (I prefer to never use it to make it easy to remember)
-   use underscores (`_`) to separate parts of the file name, and dashes (`-`) to separate words in a section
-   name files with a pattern that alphabetises in a sensible order and makes it easy for you to find the file you're looking for
-   prefix a filename with an underscore to move it to the top of the list, or prefix all files with numbers to control their order

For example, these file names are a mess:

-   <code class='path'>report.doc</code>
-   <code class='path'>report final.doc</code>
-   <code class='path'>Data (Customers) 11-15.xls</code>
-   <code class='path'>Customers Data Nov 12.xls</code>
-   <code class='path'>final report2.doc</code>
-   <code class='path'>project notes.txt</code>
-   <code class='path'>Vendor Data November 15.xls</code>

Here is one way to structure them so that similar files have the same structure and it's easy for a human to scan the list or to use code to find relevant files. See if you can figure out what the last one should be.

-   <code class='path'>_project-notes.txt</code>
-   <code class='path'>report_v1.doc</code>
-   <code class='path'>report_v2.doc</code>
-   <code class='path'>report_v3.doc</code>
-   <code class='path'>data_customer_2021-11-12.xls</code>
-   <code class='path'>data_customer_2021-11-15.xls</code>
-   <select class='webex-select'><option value='blank'></option><option value=''>vendor-data_2021-11-15.xls</option><option value=''>data-vendor-2021_11_15.xls</option><option value='answer'>data_vendor_2021-11-15.xls</option><option value=''>data_2021-11-15_vendor.xls</option></select>

::: {.try data-latex=""}
Think of other ways to name the files above. Look at some of your own project files and see what you can improve.
:::

## R Markdown {#rmarkdown}

We will use <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> to create reproducible reports with a table of contents, text, tables, images, and code. The text can be written using <a class='glossary' target='_blank' title='A way to specify formatting, such as headers, paragraphs, lists, bolding, and links.' href='https://psyteachr.github.io/glossary/m#markdown'>markdown</a>, which is a way to specify formatting, such as headers, paragraphs, lists, bolding, and links.

If you open up a new R Markdown file from a template, you will see an example document with several b<a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>code chunks</a> in it. 

### Knitting {#rmd-knit}

To create an HTML or PDF report from an R Markdown (Rmd) document, you <a class='glossary' target='_blank' title='To create an HTML, PDF, or Word document from an R Markdown (Rmd) document' href='https://psyteachr.github.io/glossary/k#knit'>knit</a> it. There is a button that looks like a ball of yarn with needles through it that you click on to knit your file into a report.

::: {.info data-latex=""}
You can also type the following code into the console (substituting your specific file name). Never put this in an Rmd script itself, or it will try to knit itself in an infinite loop.


```r
knitr::knit2html("report.Rmd")
```
:::


::: {.try data-latex=""}
Create a new R Markdown file from the **`File > New File > R Markdown...`** menu. Change the title and author, then knit to create an html file.
:::

### YAML Header {#yaml}

The <a class='glossary' target='_blank' title='A structured format for information' href='https://psyteachr.github.io/glossary/y#yaml'>YAML</a> header is where you can set several options.

    ---
    title: "My Demo Document"
    author: "Me"
    output:
      html_document:
        df_print: kable
        theme: 
          version: 4
          bootswatch: yeti
        toc: true
        toc_float:
          collapsed: false
          smooth_scroll: false
        toc_depth: 3
        number_sections: false
    ---

::: {.info data-latex=""}
Try changing the values from `false` to `true` to see what the options do.
:::

The `df_print: kable` option prints data frames using `knitr::kable`. You'll learn below how to further customise tables.

The built-in bootswatch themes are: default, cerulean, cosmo, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, spacelab, united, and yeti. You can [view and download more themes](https://bootswatch.com/4/).

<div class="figure" style="text-align: center">
<img src="images/bootswatch.png" alt="Light themes in versions 3 and 4." width="100%" />
<p class="caption">(\#fig:img-bootswatch)Light themes in versions 3 and 4.</p>
</div>

::: {.warning data-latex=""}
YAML headers can be very picky about spaces and semicolons (the rest of R Markdown is much more forgiving). For example, if you put a space before "author", you will get an error that looks like:

```
Error in yaml::yaml.load(..., eval.expr = TRUE) : 
  Parser error: while parsing a block mapping at line 1, column 1 did not find expected key at line 2, column 2
```

The error message will tell you exactly where the problem is (the second character of the second line of the YAML header), and it's usually a matter of fixing typos or making sure that the indenting is exactly right.
:::

### Setup {#rmd-setup}

When you create a new R Markdown file in RStudio, a setup chunk is automatically created.

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r setup, include=FALSE}</code></pre>

```r
knitr::opts_chunk$set(echo = TRUE)
```

<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>

You can set more default options for your document here.

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r setup, include=FALSE}</code></pre>

```r
knitr::opts_chunk$set(
  fig.width  = 8, 
  fig.height = 5, 
  fig.path   = 'images/',
  echo       = FALSE, 
  warning    = TRUE, 
  message    = FALSE,
  cache      = FALSE
)
```

<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>

The code above sets the following options:

-   `fig.width  = 8` : default figure width is 8 inches (you can change this for individual figures)
-   `fig.height = 5` : default figure height is 5 inches
-   `fig.path   = 'images/'` : figures are saved in the directory "images"
-   `echo       = FALSE` : do not show code chunks in the rendered document
-   `warning    = FALSE` : do not show any function warnings
-   `message    = FALSE` : do not show any function messages
-   `cache      = FALSE` : run all the code to create all of the images and objects each time you knit (set to `TRUE` if you have time-consuming code)

Find a list of the current chunk options by typing <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/str.html'>str</a></span><span class='op'>(</span><span class='fu'>knitr</span><span class='fu'>::</span><span class='va'><a target='_blank' href='https://rdrr.io/pkg/knitr/man/opts_chunk.html'>opts_chunk</a></span><span class='op'>$</span><span class='fu'>get</span><span class='op'>(</span><span class='op'>)</span><span class='op'>)</span></code> in the console. See the [knitr options documentation](https://yihui.name/knitr/options/){target="_blank"} for explanations of the possible options.

You can also add the packages you need in this chunk using <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='op'>)</span></code>. Often when you are working on a script, you will realize that you need to load another add-on package. Don't bury the call to <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'>package_I_need</span><span class='op'>)</span></code> way down in the script. Put it in the top, so the user has an overview of what packages are needed.

::: {.try data-latex=""}
We'll frequently use functions from the package <code class='package'>tidyverse</code>, so load that in your setup chunk using the code <select class='webex-select'><option value='blank'></option><option value=''>install.packages("tidyverse")</option><option value='answer'>library(tidyverse)</option><option value=''>load(tidyverse)</option></select>
:::

### Markdown {#markdown}

You can use the visual <a class='glossary' target='_blank' title='A way to specify formatting, such as headers, paragraphs, lists, bolding, and links.' href='https://psyteachr.github.io/glossary/m#markdown'>markdown</a> editor if you have RStudio version 1.4 or higher. This will be a button at the top of the source pane with a pen tip. This is useful for complex styling, but you can also use these common plain-text style markups:

-   Headers are created by prefacing subtitles with one or more hashes (`#`). If you include a table of contents (`toc`) in the YAML, it is created from your document headers.
-   Format text with *italics* or **bold** by surrounding the text with one or two asterisks or underscores.
-   Make lists using numbers, asterisks or dashes before items. Indent items to make nested lists.
-   Make links like this: `[psyTeachR](https://psyteachr.github.io/)`

Download the [R Markdown Cheat Sheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf) to learn more.

::: {.try data-latex=""}
Delete the default text and add some structure to your document by creating headers and subheaders. We're going to present a summary table and plot the data.
:::

### Code Chunks {#code-chunks}

You can include <a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>code chunks</a> that create and display images, tables, or computations to include in your text. A code block starts and ends with three backtick symbols in a row. After the first three backticks, there is some information about the code between curly brackets, such as `{r chunk-name, echo=FALSE}` (this runs the code, but does not show the text of the code block in the compiled document).

Let's start by loading some data.

First, create a code chunk in your document. You can type in the backticks and chunk header manually, or use a keyboard shortcut (alt-cmd-I). This code loads some data from the web.

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r}</code></pre>

```r
# Data from https://www.kaggle.com/kyanyoga/sample-sales-data
sales <- read_csv("data/sales_data_sample.csv")
```

<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>

You can add comments inside R chunks with the hash symbol (`#`). The R interpreter will ignore characters from the hash to the end of the line.


```r
# important numbers

n <- nrow(sales) # the total number of sales
first <- min(sales$YEAR_ID) # the first year in the table
last <- max(sales$YEAR_ID) # the last year in the table
```

It's usually good practice to start a code chunk with a comment that explains what you're doing there, especially if the code is not explained in the text of the report.

If you name your objects clearly, you often don't need to add clarifying comments. For example, if I'd named the three objects above `total_number_of_sales`, `first_year` and `last_year`, I would omit the comments. It's a bit of an art to comment your code well.

### Tables {#rmd-tables}

Next, create a code chunk where you want to display a summary table. We'll use tidyverse functions you will learn in the [data wrangling lectures](#tidyr) to count the number of products per year for each product line.


```r
summary_table <- sales %>%
  group_by(YEAR_ID, PRODUCTLINE) %>%
  count() %>%
  pivot_wider(id_cols = PRODUCTLINE,
              names_from = YEAR_ID, 
              values_from = n) %>%
  print()
```

```
## # A tibble: 7 x 4
## # Groups:   PRODUCTLINE [7]
##   PRODUCTLINE      `2003` `2004` `2005`
##   <chr>             <int>  <int>  <int>
## 1 Classic Cars        366    442    159
## 2 Motorcycles         109    164     58
## 3 Planes               85    161     60
## 4 Ships                81    115     38
## 5 Trains               28     37     12
## 6 Trucks and Buses    110    142     49
## 7 Vintage Cars        221    284    102
```

The table above is OK, but it could be more reader-friendly by changing the column labels and adding a caption. You can also use more specialised functions from <code class='package'>kableExtra</code> to format your tables. These are very powerful, but take practice.


```r
kable(summary_table, 
      col.names = c("", "2003", "2004", "2005"),
      caption = "Number of sales per product line each year.") %>%
  add_header_above(c("Product Lines" = 1, "Sales" = 3), line = F, bold = T) %>%
  # change the header style
  row_spec(0, color = "grey") %>%
  # change the table style
  kable_classic(full_width = F) %>%
  # make the first column bold with a border to the right
  column_spec(1, bold = T, border_right = T) %>%
  # highlight sales over 200 in red
  column_spec(2, color = ifelse(summary_table$`2003` > 200, "red", "black")) %>%
  column_spec(3, color = ifelse(summary_table$`2004` > 200, "red", "black")) %>%
  column_spec(4, color = ifelse(summary_table$`2005` > 200, "red", "black")) 
```

<table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:unnamed-chunk-6)Number of sales per product line each year.</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; font-weight: bold; " colspan="1"><div style="">Product Lines</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; font-weight: bold; " colspan="3"><div style="">Sales</div></th>
</tr>
  <tr>
   <th style="text-align:left;color: grey !important;">  </th>
   <th style="text-align:right;color: grey !important;"> 2003 </th>
   <th style="text-align:right;color: grey !important;"> 2004 </th>
   <th style="text-align:right;color: grey !important;"> 2005 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Classic Cars </td>
   <td style="text-align:right;color: red !important;"> 366 </td>
   <td style="text-align:right;color: red !important;"> 442 </td>
   <td style="text-align:right;color: black !important;"> 159 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Motorcycles </td>
   <td style="text-align:right;color: black !important;"> 109 </td>
   <td style="text-align:right;color: black !important;"> 164 </td>
   <td style="text-align:right;color: black !important;"> 58 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Planes </td>
   <td style="text-align:right;color: black !important;"> 85 </td>
   <td style="text-align:right;color: black !important;"> 161 </td>
   <td style="text-align:right;color: black !important;"> 60 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Ships </td>
   <td style="text-align:right;color: black !important;"> 81 </td>
   <td style="text-align:right;color: black !important;"> 115 </td>
   <td style="text-align:right;color: black !important;"> 38 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Trains </td>
   <td style="text-align:right;color: black !important;"> 28 </td>
   <td style="text-align:right;color: black !important;"> 37 </td>
   <td style="text-align:right;color: black !important;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Trucks and Buses </td>
   <td style="text-align:right;color: black !important;"> 110 </td>
   <td style="text-align:right;color: black !important;"> 142 </td>
   <td style="text-align:right;color: black !important;"> 49 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;border-right:1px solid;"> Vintage Cars </td>
   <td style="text-align:right;color: red !important;"> 221 </td>
   <td style="text-align:right;color: red !important;"> 284 </td>
   <td style="text-align:right;color: black !important;"> 102 </td>
  </tr>
</tbody>
</table>

::: {.try data-latex=""}
See how many different ways you can style the table above. Use the [kableExtra vignette](https://haozhu233.github.io/kableExtra/awesome_table_in_html.html){target="_blank"} for inspiration.
:::

### Images {#rmd-images}

Next, create a code chunk where you want to display an image in your document. Let's put it after the table. We'll use some code that you'll learn more about in Chapter\ \@ref(viz) to show the range of sales within each country.

Notice how the figure caption is formatted in the chunk options.

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r item-by-line, fig.cap="The number of items in each order by product line."}</code></pre>

```r
ggplot(sales, aes(x = COUNTRY, y = SALES, fill = COUNTRY)) +
  geom_violin(alpha = 0.5, show.legend = FALSE) +
  xlab("") +
  scale_y_continuous(name = "Sales per order", 
                     breaks = seq(0, 14000, 2000), 
                     labels = paste0("£", seq(0, 14, 2), "K")) +
  scale_fill_viridis_d() +
  theme(text = element_text(size = 20, family = "Times"),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
```

<div class="figure" style="text-align: center">
<img src="02-reports_files/figure-html/item-by-line-1.png" alt="The number of items in each order by product line." width="100%" />
<p class="caption">(\#fig:item-by-line)The number of items in each order by product line.</p>
</div><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>

![All the Things by [Hyperbole and a Half](images/memes/x-all-the-things.png){float: right; style="width:50%"} You can also include images that you did not create in R using the markdown syntax for images:

    ![All the Things by Hyperbole and a Half](images/memes/x-all-the-things.png){style="float: right; width:50%"}

### Inline R {#rmd-inline-r}

Sometimes you just need to insert a number from the data into some text in your report. Inline R code lets you do that. First, we'll calculate the total number of sales per year in a code block. This block can be hidden in the final report.


```r
sales_per_year <- sales %>%
  group_by(YEAR_ID) %>%
  summarise(total = sum(SALES)) %>%
  # this adds commas as thousands separators
  mutate(fmt = format(total, big.mark=","))

sales03 <- sales_per_year %>% filter(YEAR_ID == 2003) %>% pull(fmt)
sales04 <- sales_per_year %>% filter(YEAR_ID == 2004) %>% pull(fmt)
sales05 <- sales_per_year %>% filter(YEAR_ID == 2005) %>% pull(fmt)
```

You can insert the results into a paragraph with inline R code that looks like this:

```{=html}
<pre><code>The total sales per year were 
£3,516,980 (2003), 
£4,724,163 (2004), and 
£1,791,487 (2005).</code></pre>
```
**Rendered text:**

The total sales per year were £3,516,980 (2003), £4,724,163 (2004), and £1,791,487 (2005).

::: {.info data-latex=""}
In a markdown document, new paragraphs are only created when you skip a blank line. If you include a single line break in a sentence, like above, it won't show up in the report. This can be a good way to organise complicated text with inline code.
:::

### Output Formats

You can knit your file to PDF or Word if you have the right packages installed on your computer. You can also create presentations, dashboards, websites, and even books with R markdown, which we'll learn more about in Chapter\ \@ref(present). In fact, the book you are reading right now was created using R markdown.


## Glossary {#glossary-reports}

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [absolute path](https://psyteachr.github.io/glossary/a.html#absolute-path){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A file path that starts with / and is not appended to the working directory </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [chunk](https://psyteachr.github.io/glossary/c.html#chunk){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A section of code in an R Markdown file </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [directory](https://psyteachr.github.io/glossary/d.html#directory){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A collection or “folder” of files on a computer. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [extension](https://psyteachr.github.io/glossary/e.html#extension){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd). </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [knit](https://psyteachr.github.io/glossary/k.html#knit){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> To create an HTML, PDF, or Word document from an R Markdown (Rmd) document </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [markdown](https://psyteachr.github.io/glossary/m.html#markdown){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A way to specify formatting, such as headers, paragraphs, lists, bolding, and links. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [project](https://psyteachr.github.io/glossary/p.html#project){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A way to organise related files in RStudio </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [r markdown](https://psyteachr.github.io/glossary/r.html#r-markdown){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [relative path](https://psyteachr.github.io/glossary/r.html#relative-path){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The location of a file in relation to the working directory. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [working directory](https://psyteachr.github.io/glossary/w.html#working-directory){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The filepath where R is currently reading and writing files. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [yaml](https://psyteachr.github.io/glossary/y.html#yaml){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A structured format for information </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-repro}

-   [R Markdown Cheat Sheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)
-   [kableExtra](https://haozhu233.github.io/kableExtra/awesome_table_in_html.html)
-   [R Markdown reference Guide](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)
-   [R Markdown Tutorial](https://rmarkdown.rstudio.com/lesson-1.html)
-   [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) by Yihui Xie, J. J. Allaire, & Garrett Grolemund
-   [Project Structure](https://slides.djnavarro.net/project-structure/) by Danielle Navarro
-   [How to name files](https://speakerdeck.com/jennybc/how-to-name-files) by Jenny Bryan

## Exercises {#exercises-reports}

### New project {#exercises-reports-project}

Create a new project called "demo_report" [section\ \@ref(projects)]

### Set up an R Markdown script {#exercises-reports-setup}

In the "demo_report" project, create a new Rmarkdown document called "job.Rmd" [section\ \@ref(rmarkdown)]. Edit the YAML header to output tables using kable. Set a custom theme. [section\ \@ref(yaml)]


<div class='webex-solution'><button>Solution</button>

    ---
    title: "My Job"
    author: "Me"
    output:
      html_document:
        df_print: kable
        theme: 
          version: 4
          bootswatch: sandstone
    ---

</div>


### R Markdown {#exercises-reports-rmarkdown}

Write a short paragraph describing your job [section\ \@ref(markdown)]. Include a bullet-point list of links to websites that are useful for your job [section\ \@ref(markdown)].


<div class='webex-solution'><button>Solution</button>


```
I am a research psychologist who is interested in open science 
and teaching computational skills.

* [psyTeachR books](https://psyteachr.github.io/)
* [Google Scholar](https://scholar.google.com/)
```


</div>




### Tables {#exercises-reports-tables}

Use the following code to load a small table of tasks [section\ \@ref(code-chunks)]. Edit it to be relevant to your job (you can change the categories entirely if you want).  


```r
tasks <- tibble::tribble(
  ~task,                   ~category,      ~frequency,
  "Respond to tweets",     "social media", "daily",
  "Create a twitter poll", "social media", "weekly",
  "Make the sales report", "reporting",    "montly"
)
```

Figure out how to make it so that code chunks don't show in your knitted document [section\ \@ref(rmd-setup)]


<div class='webex-solution'><button>Solution</button>


You can set the default to `echo = FALSE` in the setup chunk at the top of the script.


```r
knitr::opts_chunk$set(echo = FALSE)
```

To set visibility for a specific code chunk, put `echo = FALSE` inside the curly brackets.

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r, echo=FALSE}</code></pre>

```r
# code to hide
```

<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>


</div>


Display the table with purple italic column headers. Try different styles using <code class='package'>kableExtra</code> [section\ \@ref(rmd-tables)]


<div class='webex-solution'><button>Solution</button>

```r
kableExtra::kable(tasks) %>%
  kableExtra::kable_minimal() %>%
  kableExtra::row_spec(row = 0, italic = TRUE, color = "purple")
```

<table class=" lightable-minimal" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;font-style: italic;color: purple !important;"> task </th>
   <th style="text-align:left;font-style: italic;color: purple !important;"> category </th>
   <th style="text-align:left;font-style: italic;color: purple !important;"> frequency </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Respond to tweets </td>
   <td style="text-align:left;"> social media </td>
   <td style="text-align:left;"> daily </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Create a twitter poll </td>
   <td style="text-align:left;"> social media </td>
   <td style="text-align:left;"> weekly </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Make the sales report </td>
   <td style="text-align:left;"> reporting </td>
   <td style="text-align:left;"> montly </td>
  </tr>
</tbody>
</table>


</div>

### Images {#exercises-reports-images}

Add an image of anything relevant [section\ \@ref(rmd-images)]


<div class='webex-solution'><button>Solution</button>


You can add an image from the web using its URL:

`![Applied Data Skills](https://psyteachr.github.io/ads-v1/images/logos/logo.png)`
    
Or save an image into your project directory (e.g., in the images folder) and add it using the relative path:

`![Applied Data Skills](images/logos/logo.png)`
    

</div>


### Inline R {#exercises-reports-inline}

Use inline R to include the version of R you are using in the following sentence: "This report was created using R version 4.1.0 (2021-05-18)." You can get the version using the object `R.version.string`. [section\ \@ref(rmd-inline-r)]


<div class='webex-solution'><button>Solution</button>


This report was created using <code>&#096;r R.version.string&#096;</code>.


</div>


### Knit {#exercises-reports-kit}

Knit this document to html [section\ \@ref(rmd-knit)]


<div class='webex-solution'><button>Solution</button>

Click on the knit button or run the following code in the console. (Do not put it the Rmd script!)


```r
knitr::knit2html("demo.Rmd")
```


</div>


