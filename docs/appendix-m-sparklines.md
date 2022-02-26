# Sparklines


This tutorial is inspired by https://cranky-chandrasekhar-cfefcd.netlify.app/. In it, we're going to visualise the distributions of a few names over the years covered by the <code class='package'>ukbabnames</code> package using a function from the <code class='package'>sparkline</code> package and display the results in a table.

## Setup

The following code loads the necessary packages and sets default options. `sparklines(0)` initialises the scripts that make the sparklines work in html (this is a bit of a hack). Normally, we don't want to see any of this in a report, so would put it in a chunk with `include = FALSE`.


```r
library(tidyverse)
library(sparkline)
library(ukbabynames)
library(kableExtra)

knitr::opts_chunk$set(echo = TRUE)

# stops tables from printing "NA" for cells with missing data
options(knitr.kable.NA = '')

#initialises sparklines
sparkline(0)
```

```{=html}
<span id="htmlwidget-a9b100c85cc24f598b9a" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-a9b100c85cc24f598b9a">{"x":{"values":0,"options":{"height":20,"width":60},"width":60,"height":20},"evals":[],"jsHooks":[]}</script>
```

## Data processing

First, we need to narrow down our data to a manageable number of names. You can run the code on all the names in this set, but there are more than half a million rows in the original dataset, so that will take a while to run.

We'll make a vector of a few people from the psyTeachR team.


```r
selected_names <- c("Lisa", "Emily", "Gaby", 
                    "Jaimie", "Dale", "Philip")
```

Filter the `ukbabynames` dataset to just the selected names from Scotland (the other nations only have records from 1996) and remove the rank and nation columns.


```r
subset <- ukbabynames %>%
  filter(name %in% selected_names,
         nation == "Scotland") %>%
  select(-rank, -nation)

head(subset)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> year </th>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:right;"> 112 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Dale </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Jaimie </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Lisa </td>
   <td style="text-align:right;"> 334 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Emily </td>
   <td style="text-align:right;"> 33 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1974 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Dale </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

</div>

Next, pivot wider so each year gets its own column. The argument `values_fill = 0` sets the value for any missing years to 0. The different nations have different years in the dataset and some rarer names might not have any babies born in a year.


```r
names_wide <- subset %>%
  pivot_wider(names_from = year, 
              values_from = n, 
              values_fill = 0)

head(names_wide)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:right;"> 1974 </th>
   <th style="text-align:right;"> 1975 </th>
   <th style="text-align:right;"> 1976 </th>
   <th style="text-align:right;"> 1977 </th>
   <th style="text-align:right;"> 1978 </th>
   <th style="text-align:right;"> 1979 </th>
   <th style="text-align:right;"> 1980 </th>
   <th style="text-align:right;"> 1981 </th>
   <th style="text-align:right;"> 1982 </th>
   <th style="text-align:right;"> 1983 </th>
   <th style="text-align:right;"> 1984 </th>
   <th style="text-align:right;"> 1985 </th>
   <th style="text-align:right;"> 1986 </th>
   <th style="text-align:right;"> 1987 </th>
   <th style="text-align:right;"> 1988 </th>
   <th style="text-align:right;"> 1989 </th>
   <th style="text-align:right;"> 1990 </th>
   <th style="text-align:right;"> 1991 </th>
   <th style="text-align:right;"> 1992 </th>
   <th style="text-align:right;"> 1993 </th>
   <th style="text-align:right;"> 1994 </th>
   <th style="text-align:right;"> 1995 </th>
   <th style="text-align:right;"> 1996 </th>
   <th style="text-align:right;"> 1997 </th>
   <th style="text-align:right;"> 1998 </th>
   <th style="text-align:right;"> 1999 </th>
   <th style="text-align:right;"> 2000 </th>
   <th style="text-align:right;"> 2001 </th>
   <th style="text-align:right;"> 2002 </th>
   <th style="text-align:right;"> 2003 </th>
   <th style="text-align:right;"> 2004 </th>
   <th style="text-align:right;"> 2005 </th>
   <th style="text-align:right;"> 2006 </th>
   <th style="text-align:right;"> 2007 </th>
   <th style="text-align:right;"> 2008 </th>
   <th style="text-align:right;"> 2009 </th>
   <th style="text-align:right;"> 2010 </th>
   <th style="text-align:right;"> 2011 </th>
   <th style="text-align:right;"> 2012 </th>
   <th style="text-align:right;"> 2013 </th>
   <th style="text-align:right;"> 2014 </th>
   <th style="text-align:right;"> 2015 </th>
   <th style="text-align:right;"> 2016 </th>
   <th style="text-align:right;"> 2017 </th>
   <th style="text-align:right;"> 2018 </th>
   <th style="text-align:right;"> 2019 </th>
   <th style="text-align:right;"> 2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:right;"> 112 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 117 </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Dale </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 203 </td>
   <td style="text-align:right;"> 141 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Jaimie </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Lisa </td>
   <td style="text-align:right;"> 334 </td>
   <td style="text-align:right;"> 465 </td>
   <td style="text-align:right;"> 366 </td>
   <td style="text-align:right;"> 460 </td>
   <td style="text-align:right;"> 564 </td>
   <td style="text-align:right;"> 708 </td>
   <td style="text-align:right;"> 741 </td>
   <td style="text-align:right;"> 844 </td>
   <td style="text-align:right;"> 808 </td>
   <td style="text-align:right;"> 621 </td>
   <td style="text-align:right;"> 727 </td>
   <td style="text-align:right;"> 598 </td>
   <td style="text-align:right;"> 555 </td>
   <td style="text-align:right;"> 565 </td>
   <td style="text-align:right;"> 534 </td>
   <td style="text-align:right;"> 498 </td>
   <td style="text-align:right;"> 502 </td>
   <td style="text-align:right;"> 406 </td>
   <td style="text-align:right;"> 354 </td>
   <td style="text-align:right;"> 333 </td>
   <td style="text-align:right;"> 279 </td>
   <td style="text-align:right;"> 219 </td>
   <td style="text-align:right;"> 198 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 101 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Emily </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 146 </td>
   <td style="text-align:right;"> 190 </td>
   <td style="text-align:right;"> 191 </td>
   <td style="text-align:right;"> 213 </td>
   <td style="text-align:right;"> 234 </td>
   <td style="text-align:right;"> 289 </td>
   <td style="text-align:right;"> 271 </td>
   <td style="text-align:right;"> 367 </td>
   <td style="text-align:right;"> 323 </td>
   <td style="text-align:right;"> 362 </td>
   <td style="text-align:right;"> 335 </td>
   <td style="text-align:right;"> 357 </td>
   <td style="text-align:right;"> 404 </td>
   <td style="text-align:right;"> 383 </td>
   <td style="text-align:right;"> 355 </td>
   <td style="text-align:right;"> 407 </td>
   <td style="text-align:right;"> 468 </td>
   <td style="text-align:right;"> 453 </td>
   <td style="text-align:right;"> 471 </td>
   <td style="text-align:right;"> 456 </td>
   <td style="text-align:right;"> 489 </td>
   <td style="text-align:right;"> 490 </td>
   <td style="text-align:right;"> 569 </td>
   <td style="text-align:right;"> 497 </td>
   <td style="text-align:right;"> 522 </td>
   <td style="text-align:right;"> 460 </td>
   <td style="text-align:right;"> 423 </td>
   <td style="text-align:right;"> 388 </td>
   <td style="text-align:right;"> 300 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Dale </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

</div>

Now convert back to the long format. This new long dataset will be the same as `subset`, but will include new rows with n = 0 for years where, for example, there were no male "Lisa"s born. It doesn't matter that the years or names aren't in any coherent order.


```r
names_long <- names_wide %>%
  pivot_longer(cols = -(sex:name),
               names_to = "year", 
               values_to = "n")

head(names_long)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1974 </td>
   <td style="text-align:right;"> 112 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1975 </td>
   <td style="text-align:right;"> 123 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1976 </td>
   <td style="text-align:right;"> 140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1977 </td>
   <td style="text-align:right;"> 102 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1978 </td>
   <td style="text-align:right;"> 106 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;"> 1979 </td>
   <td style="text-align:right;"> 118 </td>
  </tr>
</tbody>
</table>

</div>

## Make the sparklines

Now we're going to make a sparkline for each unique combination of name and sex (Jaimie is a unisex name, and there are even a few male Lisas), using the `spk_chr()` function. Pivot wider to put sex across the top.


```r
babies <- names_long %>%
  group_by(name, sex) %>%
  summarise(
    data = spk_chr(n, width = 120,
                   type = "bar",
                   barColor = ifelse(all(sex == "M"),
                                     "dodgerblue", 
                                     "hotpink")),
    .groups = "drop") %>%
  pivot_wider(names_from = sex,
              values_from = data)
```

## Display the table

Use kable to print the table, setting `escape = FALSE` to prevent the html in the three nations columns from being "escaped" and printing literally instead of functioning as html code.

If you run this code interactively in the source pane, you won't see the sparklines. You have to knit to be able to see them because they rely on some javascript code that is created by `sparkline(0)` in the setup chunk. 

Click on the sparklines and hover over them to see the actual numbers.


```r
caption <- paste("Baby name popularity from",
                 min(ukbabynames$year), "to",
                 max(ukbabynames$year))

kable(babies, 
      escape = FALSE, # allows the html
      caption = caption,
      col.names = c("Name", "Female Babies", "Male Babies")) %>%
  kable_styling(full_width = FALSE) 
```

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-7)Baby name popularity from 1974 to 2020</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Name </th>
   <th style="text-align:left;"> Female Babies </th>
   <th style="text-align:left;"> Male Babies </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Dale </td>
   <td style="text-align:left;"> <span id="htmlwidget-3914f17f891134efa67c" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-3914f17f891134efa67c">{"x":{"values":[1,2,3,5,2,2,5,2,4,3,1,1,1,3,1,3,1,3,2,2,2,2,2,1,0,0,0,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0],"options":{"type":"bar","barColor":"hotpink","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
   <td style="text-align:left;"> <span id="htmlwidget-e755a41cd7b8c8a0640e" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-e755a41cd7b8c8a0640e">{"x":{"values":[16,27,29,17,29,36,39,44,32,37,40,42,45,54,59,78,91,93,143,156,203,141,90,51,37,26,16,13,18,11,15,11,9,16,18,20,10,11,5,8,3,9,5,4,3,5,3],"options":{"type":"bar","barColor":"dodgerblue","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Emily </td>
   <td style="text-align:left;"> <span id="htmlwidget-c05c8da20098f7586bd0" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-c05c8da20098f7586bd0">{"x":{"values":[33,40,33,43,46,48,62,39,61,64,65,51,63,75,67,84,115,137,146,190,191,213,234,289,271,367,323,362,335,357,404,383,355,407,468,453,471,456,489,490,569,497,522,460,423,388,300],"options":{"type":"bar","barColor":"hotpink","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gaby </td>
   <td style="text-align:left;"> <span id="htmlwidget-36d7233a2c3170054fef" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-36d7233a2c3170054fef">{"x":{"values":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,2,0,0],"options":{"type":"bar","barColor":"hotpink","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Jaimie </td>
   <td style="text-align:left;"> <span id="htmlwidget-22db5ba361f8594602a4" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-22db5ba361f8594602a4">{"x":{"values":[0,0,0,3,4,0,4,5,1,2,1,5,4,4,5,7,4,7,3,5,0,2,1,2,1,2,5,2,3,5,5,3,2,5,2,2,3,1,3,2,2,1,1,1,1,0,2],"options":{"type":"bar","barColor":"hotpink","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
   <td style="text-align:left;"> <span id="htmlwidget-840d200698d1dcef47ba" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-840d200698d1dcef47ba">{"x":{"values":[2,2,0,6,9,7,3,4,4,1,2,1,7,3,7,4,3,4,3,3,4,2,1,3,2,2,0,0,0,3,3,1,2,0,1,0,1,1,2,0,0,1,0,0,0,0,0],"options":{"type":"bar","barColor":"dodgerblue","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lisa </td>
   <td style="text-align:left;"> <span id="htmlwidget-5c0c2e6ac13f836c9b57" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-5c0c2e6ac13f836c9b57">{"x":{"values":[334,465,366,460,564,708,741,844,808,621,727,598,555,565,534,498,502,406,354,333,279,219,198,155,150,101,78,78,75,47,38,42,24,22,16,18,11,6,8,7,9,4,4,4,4,2,2],"options":{"type":"bar","barColor":"hotpink","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
   <td style="text-align:left;"> <span id="htmlwidget-33006becdedef5ed380e" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-33006becdedef5ed380e">{"x":{"values":[0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,2,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],"options":{"type":"bar","barColor":"dodgerblue","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Philip </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> <span id="htmlwidget-eae9ea0edaa59208443e" class="sparkline html-widget"></span>
<script type="application/json" data-for="htmlwidget-eae9ea0edaa59208443e">{"x":{"values":[112,123,140,102,106,118,128,117,119,102,108,117,106,120,91,100,75,63,52,63,40,28,22,38,23,25,20,11,10,13,12,6,11,9,12,10,7,10,13,12,11,12,12,5,8,9,8],"options":{"type":"bar","barColor":"dodgerblue","height":20,"width":120},"width":120,"height":20},"evals":[],"jsHooks":[]}</script> </td>
  </tr>
</tbody>
</table>



