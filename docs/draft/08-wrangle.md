# Data Wrangling {#wrangle}

<div class="incomplete-chapter"></div>

## Intended Learning Outcomes {#ilo-wrangle}

* Be able to select and filter data for relevance
* Be able to create new columns and edit existing ones
* Be able to handle missing data

## Set-up

First, create a new project for the work we'll do in this chapter named <code class='path'>08-wrangle</code>. Second, open and save and new R Markdown document named `wrangle.Rmd`, delete the welcome text and load the required packages for this chapter.


```r
library(tidyverse)   # data wrangling functions
```

Download the [Data transformation cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf).

## Wrangling functions

Data wrangling refers to the process of cleaning, transforming, and restructuring your data to get it into the format you need for analysis and it's something you will spend an awful lot of time doing. Most <a class='glossary' target='_blank' title='The process of preparing data for visualisation and statistical analysis.' href='https://psyteachr.github.io/glossary/d#data-wrangling'>data wrangling</a> involves the reshaping functions you learned in Chapter\ \@ref(tidy) and six functions from the <code class='package'>dplyr</code> package that is loaded as part of the <code class='package'>tidyverse</code>: `select`, `filter`, `arrange`, `mutate`, `summarise`, and `group_by`. You'll remember the last two from Chapter\ \@ref(summary), so we'll only cover them briefly.

It's worth highlighting that in this chapter we're going to cover these common functions and common uses of said functions. However, <code class='package'>dplyr</code> (and packages beyond it) has a huge number of additional wrangling functions and each function has many different arguments. Essentially, if you think you should be able to wrangle your data in a particular way that we haven't explicitly shown you, you almost certainly can, it might just take a bit of Googling to find out how. 



We'll use a small example table with the sales, expenses, and satisfaction for two years from four regions over two products.


```r
budget <- read_csv("data/budget.csv", show_col_types = FALSE)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> 6328 </td>
   <td style="text-align:right;"> 5069 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10376 </td>
   <td style="text-align:right;"> 8948 </td>
   <td style="text-align:right;"> 12132 </td>
   <td style="text-align:right;"> 10256 </td>
   <td style="text-align:left;"> very low </td>
   <td style="text-align:left;"> very low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:right;"> 6336 </td>
   <td style="text-align:right;"> 5752 </td>
   <td style="text-align:right;"> 7178 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10361 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 9313 </td>
   <td style="text-align:right;"> 10417 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 3983 </td>
   <td style="text-align:right;"> 6369 </td>
   <td style="text-align:right;"> 4712 </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
</tbody>
</table>

</div>


### Select

You can select columns (variables) by name or number (which is sometimes referred to as the column index).  Selecting by number can be useful when the column names are long or complicated.


```r
# select single column by name
product_dat <- budget %>% select(product) 

# select single column by number
product_dat <- budget %>% select(2) 
```


You can select each column individually, separated by commas (e.g., `region, sales_2019`) but you can also select all columns from one to another by separating them with a colon (e.g., `sales_2019:expenses_2020`).

The colon notation can be much faster because you don't need to type out each individual variable name, but make sure that you know what order your columns are in and always check the output to make sure you have selected what you intended.


```r
# select columns individually
sales2019 <- budget %>% select(region, product, sales_2019)

# select columns with colon
sales2019 <- budget %>% select(region:sales_2019)
```

You can rename columns at the same time as selecting them by setting `new_name = old_col`. 


```r
regions <- budget %>% select(`Sales Region` = 1, 3:6)
names(regions)
```

```
## [1] "Sales Region"  "sales_2019"    "sales_2020"    "expenses_2019"
## [5] "expenses_2020"
```

You can select columns either by telling R which ones you want to keep as in the previous examples, or by specifying which ones you want to exclude by using a minus symbol to un-select columns. You can also use the colon notation to de-select columns, but to do so you need to put parentheses around the span first, e.g., `-(sales_2019:expenses_2020)`, not `-sales_2019:expenses_2020`.


```r
# de-select individual columns
sales <- budget %>% select(-expenses_2019, -expenses_2020)

# de-select a range of columns
sales <- budget %>% select(-(expenses_2019:expenses_2020))
```

Finally, you can select columns based on criteria about the column names.

| function | definition |
|----------|------------|
| `starts_with()` | select columns that start with a character string|
| `ends_with()` | select columns that end with a character string |
| `contains()` | select columns that contain a character string |
| `num_range()` | select columns with a name that matches the pattern `prefix` |




::: {.try data-latex=""}
What are the resulting columns for these four examples?

* `budget %>% select(starts_with("sales"))`
    <select class='webex-select'><option value='blank'></option><option value='x'>sales_2020, expenses_2020, satisfaction_2020</option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020, satisfaction_2019, satisfaction_2020</option><option value='answer'>sales_2019, sales_2020</option><option value='x'>expenses_2019, expenses_2020</option></select> 
* `budget %>% select(ends_with("2020"))`
    <select class='webex-select'><option value='blank'></option><option value='x'>expenses_2019, expenses_2020</option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020, satisfaction_2019, satisfaction_2020</option><option value='answer'>sales_2020, expenses_2020, satisfaction_2020</option><option value='x'>sales_2019, sales_2020</option></select>
* `budget %>% select(contains("_"))`
    <select class='webex-select'><option value='blank'></option><option value='x'>sales_2020, expenses_2020, satisfaction_2020</option><option value='x'>sales_2019, sales_2020</option><option value='x'>expenses_2019, expenses_2020</option><option value='answer'>sales_2019, sales_2020, expenses_2019, expenses_2020, satisfaction_2019, satisfaction_2020</option></select>
* `budget %>% select(num_range("expenses_", 2019:2020))`
    <select class='webex-select'><option value='blank'></option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020, satisfaction_2019, satisfaction_2020</option><option value='answer'>expenses_2019, expenses_2020</option><option value='x'>sales_2019, sales_2020</option><option value='x'>sales_2020, expenses_2020, satisfaction_2020</option></select>
:::


### Filter

Whilst `select()` selects which variables you want to retain, `filter()` selects which rows to keep by matching column criteria.

You can filter by a single criterion. This criterion can be a character value (e.g., "North"), a number (e.g., 9003), or the result of a logical equation (e.g., keep all numbers larger than a certain value). For logical equations, the equation is checked for each row, and if the result is FALSE, the row is removed. You can reverse this equation by specifying `!=` where `!` means "not".


```r
# select all rows where region equals North
budget %>% filter(region == "North")

# select all rows where expenses_2020 were exactly equal to 9003
budget %>% filter(expenses_2020 == 9003)

# select all rows where sales_2019 was more than 10,000
budget %>% filter(sales_2019 > 10000)

# everything but the North
budget %>% filter(region != "North")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>

  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10376 </td>
   <td style="text-align:right;"> 8948 </td>
   <td style="text-align:right;"> 12132 </td>
   <td style="text-align:right;"> 10256 </td>
   <td style="text-align:left;"> very low </td>
   <td style="text-align:left;"> very low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10361 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 9313 </td>
   <td style="text-align:right;"> 10417 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> 6328 </td>
   <td style="text-align:right;"> 5069 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10376 </td>
   <td style="text-align:right;"> 8948 </td>
   <td style="text-align:right;"> 12132 </td>
   <td style="text-align:right;"> 10256 </td>
   <td style="text-align:left;"> very low </td>
   <td style="text-align:left;"> very low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:right;"> 6336 </td>
   <td style="text-align:right;"> 5752 </td>
   <td style="text-align:right;"> 7178 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10361 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 9313 </td>
   <td style="text-align:right;"> 10417 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 3983 </td>
   <td style="text-align:right;"> 6369 </td>
   <td style="text-align:right;"> 4712 </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
Remember to use `==` and not `=` to check if two things are equivalent. A single `=` assigns the right-hand value to the left-hand variable (much like the `<-` operator).
:::

You can also select on multiple criteria by using `&` ("and") and `|` ("or").


```r
# regions and products with profit in both 2019 and 2020
profit_both <- budget %>% 
  filter(
    sales_2019 > expenses_2019 &
    sales_2020 > expenses_2020
  )

# regions and products with profit in 2019 or 2020
profit_either <- budget %>% 
  filter(
    sales_2019 > expenses_2019 |
    sales_2020 > expenses_2020
  )

# 2020 profit greater than 1000
profit_1000 <- budget %>%
  filter(sales_2020 - expenses_2020 > 1000)
```

If you want the filter to retain multiple specific values in the same variable, the <a class='glossary' target='_blank' title='A binary operator (%in%) that returns a logical vector indicating if there is a match or not for its left operand.' href='https://psyteachr.github.io/glossary/m#match-operator'>match operator</a> (`%in%`) should be used rather than `|`/or. The `!` can also be used in combination here, but it is placed before the variable name.


```r
# retain any rows where region is north or south, and where product equals widget
budget %>%
  filter(region %in% c("North", "South"),
         product == "widgets")

# retain any rows where the region is not east or west, and where the product does not equal gadgets
budget %>%
  filter(!region %in% c("East", "West"),
         product != "gagdets")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> 6328 </td>
   <td style="text-align:right;"> 5069 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
</tbody>
</table>

</div>

Operator	|Name	                 |is TRUE if and only if
----------|----------------------|---------------------------------
A < B 	  |less than 	           |A is less than B
A <= B 	  |less than or equal    |A is less than or equal to B
A > B 	  |greater than 	       |A is greater than B
A >= B 	  |greater than or equal |A is greater than or equal to B
A == B 	  |equivalence 	         |A exactly equals B
A != B 	  |not equal 	           |A does not exactly equal B
A %in% B 	|in 	                 |A is an element of vector B

Finally, you can also pass many other functions to filter. For example, the <code class='package'>stringr</code> that is loaded as part of the <code class='package'>tidyverse</code> contains many different functions for working with strings (character data). For example, you you use `str_detect()` to only retain rows where the customer satisfaction rating includes the word "high" (note that `str_detect()` is case sensitive so it would not return values of "High" or "HIGH".


```r
budget %>%
  filter(str_detect(satisfaction_2019, "high"))
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
`filter()` is incredibly powerful and can allow you to select very specific subsets of data. But, it is also quite dangerous because when you start combining multiple criteria and operators, it's very easy to accidentally specify something slightly different than what you intended. **Always check your output**. If you have a small dataset than you can eyeball it to see if it looks right, with a larger dataset you may wish to compute summary statistics or count the number of groups/observations in each variable to verify your filter is correct. There is no level of expertise in coding that can substitute knowing and checking your data. 
:::

### Arrange

You can sort your dataset using `arrange()`. You will find yourself needing to sort data in R much less than you do in Excel, since you don't need to have rows next to each other in order to, for example, calculate group means. But `arrange()` can be useful when preparing data for display in tables. `arrange()` works on character data where it will sort alphabetically, as well as numeric data where the default is ascending order (smallest to largest). Reverse the order using `desc()`.


```r
budget %>%
  arrange(product, desc(region))
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 3983 </td>
   <td style="text-align:right;"> 6369 </td>
   <td style="text-align:right;"> 4712 </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> 6328 </td>
   <td style="text-align:right;"> 5069 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:right;"> 6336 </td>
   <td style="text-align:right;"> 5752 </td>
   <td style="text-align:right;"> 7178 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10361 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 9313 </td>
   <td style="text-align:right;"> 10417 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 9560 </td>
   <td style="text-align:right;"> 12456 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> neutral </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 9270 </td>
   <td style="text-align:right;"> 8778 </td>
   <td style="text-align:left;"> high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10376 </td>
   <td style="text-align:right;"> 8948 </td>
   <td style="text-align:right;"> 12132 </td>
   <td style="text-align:right;"> 10256 </td>
   <td style="text-align:left;"> very low </td>
   <td style="text-align:left;"> very low </td>
  </tr>
</tbody>
</table>

</div>


::: {.try data-latex=""}
If you want to sort character data/categories in a specific order, turn the column into a <a class='glossary' target='_blank' title='A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter' href='https://psyteachr.github.io/glossary/f#factor'>factor</a> and set the `levels` in the desired order.


```r
budget %>%
  mutate(region = factor(region, levels = c("North", "South", "East", "West"))) %>%
  filter(product == "gadgets") %>%
  arrange(region)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> sales_2019 </th>
   <th style="text-align:right;"> sales_2020 </th>
   <th style="text-align:right;"> expenses_2019 </th>
   <th style="text-align:right;"> expenses_2020 </th>
   <th style="text-align:left;"> satisfaction_2019 </th>
   <th style="text-align:left;"> satisfaction_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 4014 </td>
   <td style="text-align:right;"> 6504 </td>
   <td style="text-align:left;"> very high </td>
   <td style="text-align:left;"> very high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> 6328 </td>
   <td style="text-align:right;"> 5069 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:right;"> 6336 </td>
   <td style="text-align:right;"> 5752 </td>
   <td style="text-align:right;"> 7178 </td>
   <td style="text-align:left;"> neutral </td>
   <td style="text-align:left;"> high </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 3983 </td>
   <td style="text-align:right;"> 6369 </td>
   <td style="text-align:right;"> 4712 </td>
   <td style="text-align:right;"> 5871 </td>
   <td style="text-align:left;"> low </td>
   <td style="text-align:left;"> low </td>
  </tr>
</tbody>
</table>

</div>

:::

### Mutate

The function `mutate()` allows you to add new columns or change existing ones by overwriting them by using the syntax `new_column = operation`.  You can add more than one column in the same mutate function by separating the columns with a comma. Once you make a new column, you can use it in further column definitions. For example, the creation of `profit` below uses the column `expenses` which is created above it.


```r
budget2 <- budget %>%
  mutate(
    sales = sales_2019 + sales_2020,
    expenses = expenses_2019 + expenses_2020,
    profit = sales - expenses,
    region = paste(region, "Office")
  )
```

`mutate()` can also be used in conjunction with other functions and Boolean operators. For example, we can add another column to `budget2` that states whether a profit was returned that year or overwrite our `product` variable as a factor. Just like when we used Boolean operators with filter, it will evaluate the equation and return TRUE or FALSE depending on whether the observation meets the criteria.


```r
budget2 <- budget2 %>%
  mutate(profit_category = profit > 0,
         product = as.factor(product))
```

::: {.warning data-latex=""}
You can overwrite a column by giving a new column the same name as the old column (see `region` or `product`) above. Make sure that you mean to do this and that you aren't trying to use the old column value after you redefine it.
:::

You can also use `case_when()` to specify what values to return, rather than defaulting to TRUE or FALSE:


```r
budget3 <- budget2 %>%
  mutate(profit_category = case_when(profit > 0 ~ "PROFIT",
                                     profit < 0 ~ "NO PROFIT"))
```

Use it to recode values:


```r
# create a column where people get a bonus if customer satisfaction was overall high or very high

bonus <- budget3 %>%
  mutate(bonus_2019 = case_when(satisfaction_2019 %in% c("very low", "low", "neutral") ~ "no bonus",
                                satisfaction_2019 %in% c("high", "very high") ~ "bonus"))
```

And combine different criteria:


```r
# new management takes over - people only get a bonus if customer satisfaction was overall high or very high AND if a profit was returned

bonus2 <- budget3 %>%
  mutate(bonus_2020 = case_when(satisfaction_2020 == "high" & 
                                  profit_category == "PROFIT" ~ "bonus",
                                satisfaction_2020 == "very high" & 
                                  profit_category == "PROFIT" ~ "bonus",
                                TRUE ~ "No bonus")) # set all other values to "no bonus"
```

Just like `filter()`, `mutate()` is incredibly powerful and the scope of what you can create is far beyond what we can cover in this book. 

### Summarise {#dplyr-summarise}

You were introduced to the `summarise()` function in Chapter\ @\ref({#summary-summarise}). This applies summary functions to an entire table (or groups, as you'll see in the next section).

Let's say we want to determine the mean sales and expenses, plus the minimum and maximum profit, for any region, product and year. First, we need to reshape the data like we learned in Chapter\ \@ref(tidy), so that there is a column for year and one column each for sales and expenses, instead of separate columns for each year. We'll also drop the satisfaction data as we don't need it for this analysis. 


```r
budget4 <- budget %>%
  select(-satisfaction_2019, -satisfaction_2020) %>%
  pivot_longer(cols = sales_2019:expenses_2020,
               names_to = c("type", "year"),
               names_sep = "_",
               values_to = "value") %>%
  pivot_wider(names_from = type,
              values_from = value)

head(budget4) # check the format
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> sales </th>
   <th style="text-align:right;"> expenses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9270 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 8778 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 4014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 6937 </td>
   <td style="text-align:right;"> 6504 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 9560 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 12456 </td>
  </tr>
</tbody>
</table>

</div>

Now we can create summary statistics for the table.


```r
budget4 %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales)
  )
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 7900.438 </td>
   <td style="text-align:right;"> 7975.625 </td>
   <td style="text-align:right;"> -2429 </td>
   <td style="text-align:right;"> 1756 </td>
  </tr>
</tbody>
</table>

</div>

### Group By {#dplyr-groupby}

You were introduced to the `group_by()` function in Chapter\ \@ref(grouping). For example, you can break down the summary statistics above by year and product.


```r
year_prod <- budget4 %>%
  group_by(year, product) %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales)
  ) %>%
  ungroup()
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

```r
year_prod
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4936.75 </td>
   <td style="text-align:right;"> 5201.50 </td>
   <td style="text-align:right;"> -1194 </td>
   <td style="text-align:right;"> 1643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10377.50 </td>
   <td style="text-align:right;"> 10068.75 </td>
   <td style="text-align:right;"> -2429 </td>
   <td style="text-align:right;"> 1756 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 6083.50 </td>
   <td style="text-align:right;"> 6155.50 </td>
   <td style="text-align:right;"> -498 </td>
   <td style="text-align:right;"> 842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10204.00 </td>
   <td style="text-align:right;"> 10476.75 </td>
   <td style="text-align:right;"> -1011 </td>
   <td style="text-align:right;"> 1308 </td>
  </tr>
</tbody>
</table>

</div>


Note that you can use the other wrangling functions on the summary table, for example: 


```r
# arrange by maximum profit
year_prod %>%
  arrange(desc(max_profit))

# filter out gadgets
year_prod %>%
  filter(product != "gadgets")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10377.50 </td>
   <td style="text-align:right;"> 10068.75 </td>
   <td style="text-align:right;"> -2429 </td>
   <td style="text-align:right;"> 1756 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4936.75 </td>
   <td style="text-align:right;"> 5201.50 </td>
   <td style="text-align:right;"> -1194 </td>
   <td style="text-align:right;"> 1643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10204.00 </td>
   <td style="text-align:right;"> 10476.75 </td>
   <td style="text-align:right;"> -1011 </td>
   <td style="text-align:right;"> 1308 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 6083.50 </td>
   <td style="text-align:right;"> 6155.50 </td>
   <td style="text-align:right;"> -498 </td>
   <td style="text-align:right;"> 842 </td>
  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10377.5 </td>
   <td style="text-align:right;"> 10068.75 </td>
   <td style="text-align:right;"> -2429 </td>
   <td style="text-align:right;"> 1756 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10204.0 </td>
   <td style="text-align:right;"> 10476.75 </td>
   <td style="text-align:right;"> -1011 </td>
   <td style="text-align:right;"> 1308 </td>
  </tr>
</tbody>
</table>

</div>


::: {.try data-latex=""}
How would you find out the maximum sales for each region?

<div class='webex-radiogroup' id='radio_DEZRXDSRJP'><label><input type="radio" autocomplete="off" name="radio_DEZRXDSRJP" value="x"></input> <span><pre>budget3 %>%
  group_by(sales) %>%
  summarise(max_sales = max(sales)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_DEZRXDSRJP" value="answer"></input> <span><pre>budget3 %>%
  group_by(region) %>%
  summarise(max_sales = max(sales)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_DEZRXDSRJP" value="x"></input> <span><pre>budget3 %>%
  group_by(sales) %>%
  summarise(max_sales = max(region)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_DEZRXDSRJP" value="x"></input> <span><pre>budget3 %>%
  group_by(region) %>%
  summarise(max_sales = max(region)</pre></span></label></div>

:::

You can also use `group_by()` in combination with other functions. For example, `slice_max()` returns the top N rows, ordered by a specific variable.


```r
# return top 3 sales
budget4 %>%
  slice_max(n = 3, order_by = sales)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> sales </th>
   <th style="text-align:right;"> expenses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 9560 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> 12456 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 10417 </td>
  </tr>
</tbody>
</table>

</div>

But this can be combined with `group_by()` to return the top sales for each region:


```r
# return top sale for each region
budget4 %>%
  group_by(region) %>%
  slice_max(n = 1, order_by = sales)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> sales </th>
   <th style="text-align:right;"> expenses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> East </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 10376 </td>
   <td style="text-align:right;"> 12132 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 9789 </td>
   <td style="text-align:right;"> 8778 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 9560 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> West </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 10885 </td>
   <td style="text-align:right;"> 10417 </td>
  </tr>
</tbody>
</table>

</div>

## Complications

### Rounding

Let's say we want to round all the values to the nearest pound. The pattern below uses the `across()` function to apply the `round()` function to the columns from `mean_sales` to `max_profit`.


```r
year_prod %>%
  mutate(across(.cols = mean_sales:max_profit, 
                .fns = round))
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 4937 </td>
   <td style="text-align:right;"> 5202 </td>
   <td style="text-align:right;"> -1194 </td>
   <td style="text-align:right;"> 1643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10378 </td>
   <td style="text-align:right;"> 10069 </td>
   <td style="text-align:right;"> -2429 </td>
   <td style="text-align:right;"> 1756 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 6084 </td>
   <td style="text-align:right;"> 6156 </td>
   <td style="text-align:right;"> -498 </td>
   <td style="text-align:right;"> 842 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 10204 </td>
   <td style="text-align:right;"> 10477 </td>
   <td style="text-align:right;"> -1011 </td>
   <td style="text-align:right;"> 1308 </td>
  </tr>
</tbody>
</table>

</div>

If you compare this table to the one in Section\ \@ref(dplyr-groupby), you'll see that the 2019 gadgets mean sales rounded up from 4936.75 to 4937, while the mean expenses rounded from 5201.5 to 5202. What's going on!?

This may seem like a mistake, but R rounds .5 to the nearest even number, rather than always up, like you were probably taught in school. This prevents overestimation biases, since x.5 is *exactly* halfway between x and x+1, so there is no reason it should always round up.


```r
round(0.5)
round(1.5)
```

```
## [1] 0
## [1] 2
```

However, this might throw a monkey wrench into your own systems. For example, our school policy is to round up for course marks at x.5. The solution is to define your own version of `round()` (modified from [Andrew Landgraf's blog](http://andrewlandgraf.com/2012/06/15/rounding-in-r/){target="_blank"}). Put it in a hidden code block at the top of your script, with a clear warning that this is changing the way `round()` normally works. You don't need to understand how this function works, just how to use it.

when you run this code, a new section will appear in the environment pane labelled "Functions". In addition to using functions from packages, you can also make your own. It's not something we are going to go into detail on in this course but it's useful to know the functionality exists.


```r
#!!!!!! redefining round so 5s round up !!!!!! 
round <- function(x, digits = 0) {
  posneg = sign(x)
  z = abs(x)*10^digits
  z = z + 0.5 + sqrt(.Machine$double.eps)
  z = trunc(z)
  z = z/10^digits
  z*posneg
}
```

Now `round()` should work as you'd expect.


```r
round(0.5)
round(1.5)
```

```
## [1] 1
## [1] 2
```

Just remove your version if you want R to go back to the original method. Remember that you have to define the new round method in any script that uses it, and run the definition code before you use it interactively. You can check your Environment pane to see whether `round` is listed under "Functions".


```r
# remove new round() method
rm(round)
```

### Missing values

If you have control over your data, it is always best to keep missing values as empty cells rather than using denoting missingness with a word or implausible number. If you used e.g., "missing" rather than leaving the cell empty, the entire variable would be read as character data which means you wouldn't be able to perform mathematical operations like calculating the mean. If you use an implausible number (0 or 999 are common), then you risk these value being included in any calculations as real numbers.

However, we often don't have control over how the data come to us, so let's run through how to fix this.

What if the North region hadn't returned their sales data for 2020 yet (entered as "missing") and the South region hadn't returned their expenses (entered as 0)? 

We'll create two separate objects to demonstrate two approaches.


```r
north_data <- budget4 %>%
  filter(region == "North")

south_data <- budget4 %>%
  filter(region == "South")
```

For the South data, we can use `case_when()` to convert the expenses for 2020 to "0".


```r
south_missing <- south_data %>%
  mutate(expenses = case_when(year == 2020 ~ 0,
                           TRUE ~ sales))
```

For the North, we need to use `ifelse()` to recode these values as "missing". `ifelse()` is similar to `case_when()`, it's harder to use when you have multiple different conditions but it's also less picky. `case_when()` requires all the values in the variable to be of the same type, whereas `ifelse()` doesn't. In this case, because sales will contain both character and numeric data, we need to use `ifelse()`.


```r
# set sales values to "missing" for North 2020 rows
north_missing <- north_data %>%
  mutate(sales = ifelse(region == "North" & year == 2020,
                        "missing", sales))
# check structure of data, sales now character
str(north_missing)

# try to compute mean sales
north_missing %>%
  summarise(mean_sales = mean(sales))
```

```
## Warning in mean.default(sales): argument is not numeric or logical: returning NA
```

```
## tibble [4 x 5] (S3: tbl_df/tbl/data.frame)
##  $ region  : chr [1:4] "North" "North" "North" "North"
##  $ product : chr [1:4] "widgets" "widgets" "gadgets" "gadgets"
##  $ year    : chr [1:4] "2019" "2020" "2019" "2020"
##  $ sales   : chr [1:4] "8784" "missing" "5208" "missing"
##  $ expenses: num [1:4] 9270 8778 4014 6504
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> mean_sales </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

</div>

To set the missing values to NA, you could use either `ifelse()` or `case_when()`. For the North data, because the variable was converted to character, we also need to transform this back to numeric.


```r
# set "missing" values to NA using case_when
north_missing <- north_missing %>%
  mutate(sales = case_when(sales == "missing" ~ NA_character_,
                           TRUE ~ sales),
         sales = as.numeric(sales))

# set "0" values to NA using ifelse

south_missing <- south_missing %>%
  mutate(expenses = ifelse(expenses == 0, NA, sales))
```

Now, if we try to calculate the mean sales and profits, we get missing values for any summary value that used one of the North 2020 sales values.


```r
north_missing %>%
  group_by(product) %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales)) %>%
  ungroup()
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 5259 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 9024 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

</div>

This is because `NA` basically means "I don't know", and the sum of 100 and "I don't know" is "I don't know", not 100. However, when you're calculating means, you often want to just ignore missing values. Set `na.rm = TRUE` in the summary function to remove missing values before calculating.


```r
north_missing %>%
  group_by(product) %>%
  summarise(
    mean_sales = mean(sales, na.rm = TRUE),
    mean_expenses = mean(expenses, na.rm = TRUE),
    min_profit = min(expenses - sales, na.rm = TRUE),
    max_profit = max(expenses - sales, na.rm = TRUE)
  ) %>%
  ungroup()
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> mean_sales </th>
   <th style="text-align:right;"> mean_expenses </th>
   <th style="text-align:right;"> min_profit </th>
   <th style="text-align:right;"> max_profit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 5259 </td>
   <td style="text-align:right;"> -1194 </td>
   <td style="text-align:right;"> -1194 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9024 </td>
   <td style="text-align:right;"> 486 </td>
   <td style="text-align:right;"> 486 </td>
  </tr>
</tbody>
</table>

</div>

If you want to find out how many missing or non-missing values there are in a column, use the `is.na()` function to get a <a class='glossary' target='_blank' title='A data type representing TRUE or FALSE values.' href='https://psyteachr.github.io/glossary/l#logical'>logical</a> vector of whether or not each value is missing, and use `sum()` to count how many values are TRUE or `mean()` to calculate the proportion of TRUE values.


```r
north_missing %>%
  group_by(year, product) %>%
  summarise(
    n_valid = sum(!is.na(sales)),
    n_missing = sum(is.na(sales)),
    prop_missing = mean(is.na(sales))
  ) %>%
  ungroup()
```

```
## `summarise()` has grouped output by 'year'. You can override using the `.groups` argument.
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> year </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:right;"> n_valid </th>
   <th style="text-align:right;"> n_missing </th>
   <th style="text-align:right;"> prop_missing </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

</div>

You may also want to remove rows that have missing values and only work from complete datasets. `drop_na()` will remove any row that has a missing observation. You can use `drop_na()` on the entire dataset which will remove any row that has *any* missing value, or you can specify to only remove rows that are missing a specific value.


```r
# combine missing datasets

missing_data <- bind_rows(north_missing, south_missing)

# remove any rows with any missing values
missing_data %>%
  drop_na()

# remove any rows that are missing a value for sales
missing_data %>%
  drop_na(sales)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> sales </th>
   <th style="text-align:right;"> expenses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9270 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 4014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11989 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4685 </td>
  </tr>
</tbody>
</table>

</div><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> product </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> sales </th>
   <th style="text-align:right;"> expenses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 8784 </td>
   <td style="text-align:right;"> 9270 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> North </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 5208 </td>
   <td style="text-align:right;"> 4014 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 11989 </td>
   <td style="text-align:right;"> 11989 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> widgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 11194 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 4685 </td>
   <td style="text-align:right;"> 4685 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> South </td>
   <td style="text-align:left;"> gadgets </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 4692 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

</div>

Missing data can be quite difficult to deal with depending on how it is represented. As always, no amount of coding expertise can make up for not understanding the structure and idiosyncrasies of your data. 

## Exercises {#together-wrangle}

Let's try some exercises using a dataset you already encountered in Chapter\ \@ref(viz) so that you can see how much more you're able to do with the data now.

* Save your current Markdown, close it, and open a new Rmd named "survey_data_mad_skillz".
* In the set-up code chunk, load the tidyverse then load the dataset from https://psyteachr.github.io/ads-v1/data/survey_data.csv into an object named `survey_data`.
* Use your method of choice to review the dataset and familiarise yourself with its structure.


<div class='webex-solution'><button>Solution</button>

```r
# from https://www.kaggle.com/kyanyoga/sample-sales-data
library(tidyverse)
survey_data <- read_csv("https://psyteachr.github.io/ads-v1/data/survey_data.csv")
```

```
## Rows: 707 Columns: 7
```

```
## -- Column specification --------------------------------------------------------
## Delimiter: ","
## chr  (3): caller_id, employee_id, issue_category
## dbl  (3): wait_time, call_time, satisfaction
## dttm (1): call_start
```

```
## 
## i Use `spec()` to retrieve the full column specification for this data.
## i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


</div>

### Creating new categories

Employees 1-5 were trained by Michael and employees 6-10 were trained by Dwight. 

* Create a new column named `trainer` that lists the trainer for each employee.
* Then, calculate the average satisfaction scores for employees trained by each trainer and visualise the satisfaction scores for each in whatever way you think best.


<div class='webex-solution'><button>Solution</button>

```r
survey_data <- survey_data %>%
  mutate(trainer = case_when(employee_id %in% c("E01", "E02", "E03", "E04", "E05") ~ "Michael",
                             employee_id %in% c("E06", "E07", "E08", "E09", "E10") ~ "Dwight"))

# mean satisfaction scores
survey_data %>%
  group_by(trainer) %>%
  summarise(mean_satisfaction = mean(satisfaction))

# possible visualisation 

ggplot(survey_data, aes(x = satisfaction, fill = trainer)) +
  geom_histogram(binwidth = 1, show.legend = FALSE, colour = "black") +
  facet_wrap(~trainer) +
  labs(title = "Satisfaction scores by employee trainer")
```

<img src="08-wrangle_files/figure-html/unnamed-chunk-32-1.png" width="100%" style="display: block; margin: auto;" /><div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> trainer </th>
   <th style="text-align:right;"> mean_satisfaction </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Dwight </td>
   <td style="text-align:right;"> 3.366755 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Michael </td>
   <td style="text-align:right;"> 3.088415 </td>
  </tr>
</tbody>
</table>

</div>
</div>

### Filter by calculated score

First, calculate the average wait time and store this in an object named `mean_wait`. This should be a single value rather than a table.


<div class='webex-solution'><button>Hint</button>

There are multiple ways to achieve this. You could create the table and then pull put the single value, or just calculate the single value.

</div>



<div class='webex-solution'><button>Solution</button>

```r
# method 1 - tidyverse
mean_wait <- survey_data %>%
  summarise(mean_wait = mean(wait_time)) %>%
  pull(mean_wait)

# method 2 - base R
mean_wait <- mean(survey_data$wait_time)
```


</div>

Now create a dataset named `long_wait` that just contains data from customers who waited more than the average wait time.


<div class='webex-solution'><button>Solution</button>

```r
long_wait <- survey_data %>%
  filter(wait_time > mean_wait)
```


</div>

Create a visualisation that shows how many customers waited more than the average wait time for each employee.


<div class='webex-solution'><button>Solution</button>

```r
long_wait %>%
  ggplot(aes(x = employee_id)) +
  geom_bar()
```

<img src="08-wrangle_files/figure-html/unnamed-chunk-35-1.png" width="100%" style="display: block; margin: auto;" />
</div>

### Multiple critera

Now, add a column to `survey_data` named `follow_up` that flags whether a customer should be followed up with a courtesy phone call. Your company is short-staffed so only customers that meet all three of the following criteria should be followed-up:

* Their wait time should be above the average **for all calls**
* Their call time should be above the average **for their category**
* Their satisfaction should be less than three 3. 

This is quite complicated and there are multiple ways to achieve the desired outcome. Some approaches may need other functions that were covered in previous chapters and you may need to create intermediate objects.

Call the final object `follow_data` and keep only the customer ID, employee ID, trainer, and follow up columns. 


<div class='webex-solution'><button>Solution</button>

```r
# this is one possible solution, there are many other valid approaches 

# calculate mean wait time across all calls
mean_wait <- mean(survey_data$wait_time)

# calculate mean call time for each category
follow_data <- survey_data %>%
  group_by(issue_category) %>%
  summarise(mean_call = mean(call_time)) %>%
#then join it to the survey data  
  left_join(survey_data, by = "issue_category") %>%
# then add on the column
  mutate(follow_up = case_when(wait_time > mean_wait & 
                                 call_time > mean_call & 
                                 satisfaction < 3 ~ "yes",
                               TRUE ~ "no")) %>%
  select(caller_id, employee_id, trainer, follow_up)
```


</div>

For all of the above, write code that stores the answer as a single value, so that you could easily use it in inline coding.

How many customers need to be followed up:

* In total? <input class='webex-solveme nospaces' size='3' data-answer='["120"]'/>
* From calls by employee 06? <input class='webex-solveme nospaces' size='2' data-answer='["16"]'/>
* From calls by employees trained by Michael <input class='webex-solveme nospaces' size='2' data-answer='["65"]'/>
* From calls by employees trained by Dwight <input class='webex-solveme nospaces' size='2' data-answer='["55"]'/>


<div class='webex-solution'><button>Hint</button>

`group_by %>% count() %>% filter() %>% pull()
` r unhide()`

Which employee needs to make the largest number of follow-up courtesy calls? <input class='webex-solveme nospaces' size='3' data-answer='["E02"]'/>


<div class='webex-solution'><button>Hint</button>

As above but add in an `ungroup()` and `slice_max()` along the way. 
` r unhide()`


<div class='webex-solution'><button>Solution</button>

```r
# in total
follow_data %>%
  group_by(follow_up) %>%
  count()%>%
  filter(follow_up == "yes") %>%
  pull(n)

# by employee 6
follow_data %>%
  group_by(follow_up, employee_id) %>%
  count() %>%
  filter(employee_id == "E06",
         follow_up == "yes") %>%
  pull(n)

# by michael
follow_data %>%
  group_by(follow_up, trainer) %>%
  count() %>%
  filter(trainer == "Michael",
         follow_up == "yes") %>%
  pull(n)

# by dwight
follow_data %>%
  group_by(follow_up, trainer) %>%
  count() %>%
  filter(trainer == "Dwight",
         follow_up == "yes") %>%
  pull(n)

# most follow-ups needed
follow_data %>%
  group_by(follow_up, employee_id) %>%
  count() %>%
  ungroup() %>%
  filter(follow_up == "yes") %>%
  slice_max(n = 1, order_by = n) %>%
  pull(employee_id)
```

```
## [1] 120
## [1] 16
## [1] 65
## [1] 55
## [1] "E02"
```


</div>

### Original insight

In preparation for the final summative assessment, explore the data to provide one original insight of your own.

### Report

Compile all the above into a visually appealing reproducible report that could be used to target employees and trainers for extra training (or depending on what mood you're in, to fire them). Use inline coding to report any numbers in the text. Once you're finished, post your Rmd and knitted html document on teams so that other learners can see your approach.


## Glossary {#glossary-wrangle}

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [data wrangling](https://psyteachr.github.io/glossary/d.html#data-wrangling){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The process of preparing data for visualisation and statistical analysis. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [factor](https://psyteachr.github.io/glossary/f.html#factor){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [logical](https://psyteachr.github.io/glossary/l.html#logical){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing TRUE or FALSE values. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [match operator](https://psyteachr.github.io/glossary/m.html#match-operator){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A binary operator (%in%) that returns a logical vector indicating if there is a match or not for its left operand. </td>
  </tr>
</tbody>
</table>



## Further resources {#resources-wrangle}

* [Data transformation cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf)
* [Chapter 5: Data Transformation ](http://r4ds.had.co.nz/transform.html) in *R for Data Science*
* [Chapter 19: Functions](https://r4ds.had.co.nz/functions.html) in *R for Data Science*
* [Introduction to stringr](https://stringr.tidyverse.org/articles/stringr.html)




