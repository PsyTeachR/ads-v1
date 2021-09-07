# Data Tidying {#tidy}

## Intended Learning Outcomes {#ilo-tidy}

* Be able to change data between long and wide formats
* Separate, mutate, rename column headers and category labels
* Use pipes to chain together operations


```r
library(tidyverse)
```

## Data Tidying

There are three rules for "tidy data":

* Each <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/v#variable'>variable</a> must have its own column
* Each <a class='glossary' target='_blank' title='All of the data about a single trial or question.' href='https://psyteachr.github.io/glossary/o#observation'>observation</a> must have its own row
* Each <a class='glossary' target='_blank' title='A single number or piece of data.' href='https://psyteachr.github.io/glossary/v#value'>value</a> must have its own cell




### Untidy data

This table has three observations per row (2018, 2019, and 2020) and the `itemsprice_{year}` columns contain two values (number of items and price per item). 

<table>
<caption>(\#tab:unnamed-chunk-1)Untidy table</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:left;"> itemsprice_2018 </th>
   <th style="text-align:left;"> itemsprice_2019 </th>
   <th style="text-align:left;"> itemsprice_2020 </th>
   <th style="text-align:right;"> totalprice_2018 </th>
   <th style="text-align:right;"> totalprice_2019 </th>
   <th style="text-align:right;"> totalprice_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2 (3.91) </td>
   <td style="text-align:left;"> 8 (4.72) </td>
   <td style="text-align:left;"> 10 (5.59) </td>
   <td style="text-align:right;"> 7.82 </td>
   <td style="text-align:right;"> 37.76 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 1 (3.91) </td>
   <td style="text-align:left;"> 6 (4.72) </td>
   <td style="text-align:left;"> 1 (5.59) </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 28.32 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 4 (3.91) </td>
   <td style="text-align:left;"> 5 (4.72) </td>
   <td style="text-align:left;"> 5 (5.59) </td>
   <td style="text-align:right;"> 15.64 </td>
   <td style="text-align:right;"> 23.60 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 10 (3.91) </td>
   <td style="text-align:left;"> 1 (4.72) </td>
   <td style="text-align:left;"> 3 (5.59) </td>
   <td style="text-align:right;"> 39.10 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 3 (3.91) </td>
   <td style="text-align:left;"> 9 (4.72) </td>
   <td style="text-align:left;"> 8 (5.59) </td>
   <td style="text-align:right;"> 11.73 </td>
   <td style="text-align:right;"> 42.48 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>



Let's say you wanted to calculate the total price per customer over the three years and the total number of items bought per customer. You can't perform mathematical operations on the `itemsprice_{year}` columns because they are <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a> <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data types</a>.

You would probably normally use Excel to 

1. split `itemsprice_2018` columns into `item_2018` and `price_2018` columns
2. split `itemsprice_2019` columns into `item_2019` and `price_2019` columns
3. split `itemsprice_2020` columns into `item_2018` and `price_2020` columns
4. add item_2018 + item_2019 + item_2020 to get the total number of items bought per customer
5. add totalprice_2018 + totalprice_2019 + totalprice_2020 to get the total price per customer

::: {.try data-latex=""}
Think about how many steps in Excel this would be if there were 10 years in the table, or a different number of years each time you encountered data like this.
:::

### Tidy data

This is the tidy version, where each row is a customer's orders in a particular year. The number of items (`items`) and price per item (`price_per_item`) are in separate columns, so now you can perform mathematical operations on them.

<table>
<caption>(\#tab:unnamed-chunk-1)Tidy table</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> items </th>
   <th style="text-align:right;"> price_per_item </th>
   <th style="text-align:right;"> totalprice </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 7.82 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 37.76 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 3.91 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 28.32 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 15.64 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 23.60 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 39.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 4.72 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 11.73 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 42.48 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>



To calculate the total price per customer over the three years and the total number of items bought per customer in R, you would need to:

1. group the table by customer_id
2. sum the `items` column to get the total number of items bought per customer
3. sum the `totalprice` column to get the total price per customer


```r
tidy_data <- read_csv("data/tidy_data.csv")

grouped_data <- group_by(.data = tidy_data,
                         customer_id)
summarise(
  .data = grouped_data,
  total_items = sum(items),
  totalprice = sum(totalprice)
)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:right;"> total_items </th>
   <th style="text-align:right;"> totalprice </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 101.48 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 37.82 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 67.19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 60.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 98.93 </td>
  </tr>
</tbody>
</table>

</div>

::: {.info data-latex=""}
If there were 10 years in the table, or a different number of years each time you encountered data like this, the code for producing the table above never changes.
:::

If you have control over how the data are recorded, it will make your life easier to record it in a tidy format. However, we don't always have control, so this class will also teach you how to convert an untidy table into a tidy tables.

## Reshaping Data


### Too many observations per row

Data tables can be in <a class='glossary' target='_blank' title='Data where all of the observations about one subject are in the same row' href='https://psyteachr.github.io/glossary/w#wide'>wide</a> format or <a class='glossary' target='_blank' title='Data where each observation is on a separate row' href='https://psyteachr.github.io/glossary/l#long'>long</a> format (and sometimes a mix of the two). Wide data are where all of the observations about one thing are in the same row, while long data are where each observation is on a separate row. You often need to convert between these formats to do different types of summaries or visualisation.

Let's look again at just the `totalprice` data from the untidy table above. We can select just the columns we want using the `dplyr::select()` function. This function's first argument is the data table you want to select from, then each argument after that is either the name of a column in that table, or `new_name = old_name`. This is a useful function for changing the column names and order of columns, as well as selecting a subset of columns.


```r
# select just the customer ID and 3 total price columns
untidy_price <- select(
  .data = untidy_data,
  customer_id, 
  `2018` = totalprice_2018,
  `2019` = totalprice_2019,
  `2020` = totalprice_2020
)
```

This is in wide format, where each row is a customer, and represents the data from several years. This is a really intuitive way for humans to read a table, but it's not as easy for a computer to process it.

<table>
<caption>(\#tab:wide-data)Wide data</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:right;"> 2018 </th>
   <th style="text-align:right;"> 2019 </th>
   <th style="text-align:right;"> 2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 7.82 </td>
   <td style="text-align:right;"> 37.76 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 28.32 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 15.64 </td>
   <td style="text-align:right;"> 23.60 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 39.10 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11.73 </td>
   <td style="text-align:right;"> 42.48 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>

The same data can be represented in a long format by creating a new column that specifies what `item` the observation is from and a new column that specifies the `value` of that observation. This is easier to use to make summaries and plots.

<table>
<caption>(\#tab:long-data)Long data</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:left;"> year </th>
   <th style="text-align:right;"> totalprice </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 7.82 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 3.91 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 15.64 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 39.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 2018 </td>
   <td style="text-align:right;"> 11.73 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 37.76 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 28.32 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 23.60 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 4.72 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 2019 </td>
   <td style="text-align:right;"> 42.48 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 2020 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>

::: {.try data-latex=""}

Create a long version of the following table. You don't need to use code, just sketch it in a notebook or make a table in a spreadsheet.

| id     | twitter_followers | instagram_followers |
|:-------|:------------------|:--------------------|
| Emily  | 3487              | 120                 |
| Lisa   | 9110              | 110                 |



<div class='webex-solution'><button>Answer</button>

Your answer doesn't need to have the same column headers or be in the same order.

| id     | social_media | followers |
|:-------|:-------------|:----------|
| Emily  | twitter      | 3487      |
| Emily  | instagram    | 120       |
| Lisa   | twitter      | 9110      | 
| Lisa   | instagram    | 110       |


</div>


:::


The pivot functions allow you to transform a data table from wide to long or long to wide.


#### Wide to long

The function `pivot_longer()` converts a wide data table to a longer format by converting the headers from specified columns into the values of new columns, and combining the values of those columns into a new condensed column.

This function has several arguments:

* `cols`: the columns you want to make long You can refer to them by their names, like `col1, col2, col3, col4` or `col1:col4` or by their numbers, like `8, 9, 10` or `8:10`.
* `names_to`: what you want to call the new columns that the gathered column headers will go into; it's "domain" and "qnumber" in this example. 
* `names_sep`: an optional argument if you have more than one value for `names_to`. It specifies the characters or position to split the values of the `cols` headers.
* `values_to`: what you want to call the values in the columns `...`; they're "score" in this example. 


```r
untidy_price_long <- pivot_longer(
  data = untidy_price, 
  cols = `2018`:`2020`, # columns to make long 
  names_to = "year", # new column name for headers
  values_to = "totalprice" # new column name for values
) %>% print()
```

```
## # A tibble: 15 x 3
##    customer_id year  totalprice
##          <int> <chr>      <dbl>
##  1           1 2018        7.82
##  2           1 2019       37.8 
##  3           1 2020       55.9 
##  4           2 2018        3.91
##  5           2 2019       28.3 
##  6           2 2020        5.59
##  7           3 2018       15.6 
##  8           3 2019       23.6 
##  9           3 2020       28.0 
## 10           4 2018       39.1 
## 11           4 2019        4.72
## 12           4 2020       16.8 
## 13           5 2018       11.7 
## 14           5 2019       42.5 
## 15           5 2020       44.7
```



#### Long to wide

We can also go from long to wide format using the `pivot_wider()` function.

* `names_from`: the columns that contain your new column headers.
* `values_from`: the column that contains the values for the new columns.
* `names_sep`:the character string used to join names if `names_from` is more than one column.


```r
untidy_price_wide <- pivot_wider(
  data = untidy_price_long,
  names_from = year,
  values_from = totalprice
) %>% print()
```

```
## # A tibble: 5 x 4
##   customer_id `2018` `2019` `2020`
##         <int>  <dbl>  <dbl>  <dbl>
## 1           1   7.82  37.8   55.9 
## 2           2   3.91  28.3    5.59
## 3           3  15.6   23.6   28.0 
## 4           4  39.1    4.72  16.8 
## 5           5  11.7   42.5   44.7
```

#### Multi-step tidying

You often need to go from wide, to long, to an intermediate shape in order to get your data into a format that is useful for plotting, where there is a column for each type of data that you want to represent with an aesthetic.

Our full `untidy_data` table has seven columns: a customer ID, three columns for `itemsprice` and 3 columns for `totalprice`.

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:left;"> itemsprice_2018 </th>
   <th style="text-align:left;"> itemsprice_2019 </th>
   <th style="text-align:left;"> itemsprice_2020 </th>
   <th style="text-align:right;"> totalprice_2018 </th>
   <th style="text-align:right;"> totalprice_2019 </th>
   <th style="text-align:right;"> totalprice_2020 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> 2 (3.91) </td>
   <td style="text-align:left;"> 8 (4.72) </td>
   <td style="text-align:left;"> 10 (5.59) </td>
   <td style="text-align:right;"> 7.82 </td>
   <td style="text-align:right;"> 37.76 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> 1 (3.91) </td>
   <td style="text-align:left;"> 6 (4.72) </td>
   <td style="text-align:left;"> 1 (5.59) </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 28.32 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> 4 (3.91) </td>
   <td style="text-align:left;"> 5 (4.72) </td>
   <td style="text-align:left;"> 5 (5.59) </td>
   <td style="text-align:right;"> 15.64 </td>
   <td style="text-align:right;"> 23.60 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 10 (3.91) </td>
   <td style="text-align:left;"> 1 (4.72) </td>
   <td style="text-align:left;"> 3 (5.59) </td>
   <td style="text-align:right;"> 39.10 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> 3 (3.91) </td>
   <td style="text-align:left;"> 9 (4.72) </td>
   <td style="text-align:left;"> 8 (5.59) </td>
   <td style="text-align:right;"> 11.73 </td>
   <td style="text-align:right;"> 42.48 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>

</div>

We want to get it into the tidy format where each row is an observation of one customer per year, with the columns of `customer_id`, `year`, `item`, `price_per_item` and `totalprice`.

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> customer_id </th>
   <th style="text-align:right;"> year </th>
   <th style="text-align:right;"> items </th>
   <th style="text-align:right;"> price_per_item </th>
   <th style="text-align:right;"> totalprice </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 7.82 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 37.76 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 55.90 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 3.91 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 28.32 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 5.59 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 15.64 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 23.60 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 27.95 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 39.10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 4.72 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 16.77 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3.91 </td>
   <td style="text-align:right;"> 11.73 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 4.72 </td>
   <td style="text-align:right;"> 42.48 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 5.59 </td>
   <td style="text-align:right;"> 44.72 </td>
  </tr>
</tbody>
</table>

</div>

First we start by making the table super-long. Because we'll be combining columns with numeric and character data type, we need to  make the new `value` column a character data type using `values_transform`, since numbers can be represented as characters (like <code><span class='st'>"3.5"</span></code>), but character strings can't be represented as numbers.


```r
longer_data <- pivot_longer(
  data = untidy_data, 
  cols = itemsprice_2018:totalprice_2020, # columns to make long 
  names_to = c("category", "year"),       # new column names for cols
  names_sep = "_",                        # how to split cols into new columns
  # names_pattern = "(.*)_(.*)", # alternative to names_sep
  values_to = "value", # new column name for values
  
  # make sure new columns are the right data type
  names_transform = list(year = as.integer),
  values_transform = list(value = as.character) 
) %>% print()
```

```
## # A tibble: 30 x 4
##    customer_id category    year value    
##          <int> <chr>      <int> <chr>    
##  1           1 itemsprice  2018 2 (3.91) 
##  2           1 itemsprice  2019 8 (4.72) 
##  3           1 itemsprice  2020 10 (5.59)
##  4           1 totalprice  2018 7.82     
##  5           1 totalprice  2019 37.76    
##  6           1 totalprice  2020 55.9     
##  7           2 itemsprice  2018 1 (3.91) 
##  8           2 itemsprice  2019 6 (4.72) 
##  9           2 itemsprice  2020 1 (5.59) 
## 10           2 totalprice  2018 3.91     
## # … with 20 more rows
```


Now we need to make the table wider, but not as wide as before. We want to keep the `year` column and make new columns called `itemsprice` and `totalprice` with the relevant customer's `value` for that category and year.


```r
wider_data <- pivot_wider(
  data = longer_data,
  id_cols = c(customer_id, year),
  names_from = category,
  values_from = value
) %>% print()
```

```
## # A tibble: 15 x 4
##    customer_id  year itemsprice totalprice
##          <int> <int> <chr>      <chr>     
##  1           1  2018 2 (3.91)   7.82      
##  2           1  2019 8 (4.72)   37.76     
##  3           1  2020 10 (5.59)  55.9      
##  4           2  2018 1 (3.91)   3.91      
##  5           2  2019 6 (4.72)   28.32     
##  6           2  2020 1 (5.59)   5.59      
##  7           3  2018 4 (3.91)   15.64     
##  8           3  2019 5 (4.72)   23.6      
##  9           3  2020 5 (5.59)   27.95     
## 10           4  2018 10 (3.91)  39.1      
## 11           4  2019 1 (4.72)   4.72      
## 12           4  2020 3 (5.59)   16.77     
## 13           5  2018 3 (3.91)   11.73     
## 14           5  2019 9 (4.72)   42.48     
## 15           5  2020 8 (5.59)   44.72
```


### Too many variables per column

Notice that the `itemsprice` and `totalprice` columns are characters, not numeric types. This happens any time you have non-numeric characters in a column, like parentheses, or when you put numeric and character data together in a column.


```r
glimpse(wider_data)
```

```
## Rows: 15
## Columns: 4
## $ customer_id <int> 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5
## $ year        <int> 2018, 2019, 2020, 2018, 2019, 2020, 2018, 2019, 2020, 2018…
## $ itemsprice  <chr> "2 (3.91)", "8 (4.72)", "10 (5.59)", "1 (3.91)", "6 (4.72)…
## $ totalprice  <chr> "7.82", "37.76", "55.9", "3.91", "28.32", "5.59", "15.64",…
```

What we want to do is to split the `itemsprice` column into two columns, `items`, and `price_per_item`.

You can split a column into parts with the function `tidyr::separate()`. 


```r
split_data <- separate(
  data = wider_data, 
  col = itemsprice, # the column to split
  into = c("items", "price_per_item"), # the new columns to create
  sep = " ", # how to split col
  remove = TRUE, # whether to remove to old col
  convert = TRUE # whether to fix the data type of the new columns
) %>% print()
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <int> <int> <int> <chr>          <chr>     
##  1           1  2018     2 (3.91)         7.82      
##  2           1  2019     8 (4.72)         37.76     
##  3           1  2020    10 (5.59)         55.9      
##  4           2  2018     1 (3.91)         3.91      
##  5           2  2019     6 (4.72)         28.32     
##  6           2  2020     1 (5.59)         5.59      
##  7           3  2018     4 (3.91)         15.64     
##  8           3  2019     5 (4.72)         23.6      
##  9           3  2020     5 (5.59)         27.95     
## 10           4  2018    10 (3.91)         39.1      
## 11           4  2019     1 (4.72)         4.72      
## 12           4  2020     3 (5.59)         16.77     
## 13           5  2018     3 (3.91)         11.73     
## 14           5  2019     9 (4.72)         42.48     
## 15           5  2020     8 (5.59)         44.72
```

### Changing data

The column `price_per_item` is still a character column because it has parentheses. There are a few ways to fix this. You can use the `dplyr::mutate()` function to change a column or add a new one.

Here, we'll use `stringr::str_replace_all()` to replace all of the "(" and ")" with "".


```r
fixed_data <- mutate(
  .data = split_data,
  price_per_item = stringr::str_replace_all(
    string = price_per_item, 
    pattern = "[()]", 
    replacement = ""
  )
) %>%
  print()
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <int> <int> <int> <chr>          <chr>     
##  1           1  2018     2 3.91           7.82      
##  2           1  2019     8 4.72           37.76     
##  3           1  2020    10 5.59           55.9      
##  4           2  2018     1 3.91           3.91      
##  5           2  2019     6 4.72           28.32     
##  6           2  2020     1 5.59           5.59      
##  7           3  2018     4 3.91           15.64     
##  8           3  2019     5 4.72           23.6      
##  9           3  2020     5 5.59           27.95     
## 10           4  2018    10 3.91           39.1      
## 11           4  2019     1 4.72           4.72      
## 12           4  2020     3 5.59           16.77     
## 13           5  2018     3 3.91           11.73     
## 14           5  2019     9 4.72           42.48     
## 15           5  2020     8 5.59           44.72
```

### Fixing data types

The `price_per_item` and `totalprice` columns are still characters. You can fix all of your column data types in one step, once the data are clean and tidy.


```r
tidy_data <- type_convert(
  df = fixed_data,
  trim_ws = TRUE,
) %>% print()
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <int> <int> <int>          <dbl>      <dbl>
##  1           1  2018     2           3.91       7.82
##  2           1  2019     8           4.72      37.8 
##  3           1  2020    10           5.59      55.9 
##  4           2  2018     1           3.91       3.91
##  5           2  2019     6           4.72      28.3 
##  6           2  2020     1           5.59       5.59
##  7           3  2018     4           3.91      15.6 
##  8           3  2019     5           4.72      23.6 
##  9           3  2020     5           5.59      28.0 
## 10           4  2018    10           3.91      39.1 
## 11           4  2019     1           4.72       4.72
## 12           4  2020     3           5.59      16.8 
## 13           5  2018     3           3.91      11.7 
## 14           5  2019     9           4.72      42.5 
## 15           5  2020     8           5.59      44.7
```



## Pipes {#pipes}

<div style="width: 200px; float: right;"><img src="images/pipe_sticker.png" style="width: 100%" /></div>

Pipes are a way to order your code in a more readable format. 

You can always create a new object at every step and use that object in the next step, like we did above. This is pretty clear, but you've created several unnecessary data objects in your environment. This can get confusing in very long scripts. 


```r
untidy_data <- read_csv(file = "data/untidy_data.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   customer_id = col_double(),
##   itemsprice_2018 = col_character(),
##   itemsprice_2019 = col_character(),
##   itemsprice_2020 = col_character(),
##   totalprice_2018 = col_double(),
##   totalprice_2019 = col_double(),
##   totalprice_2020 = col_double()
## )
```

```r
longer_data <- pivot_longer(
  data = untidy_data,
  cols = itemsprice_2018:totalprice_2020,
  names_to = c("category", "year"),
  names_sep = "_", 
  values_to = "value", 
  names_transform = list(year = as.integer),
  values_transform = list(value = as.character) 
) 

wider_data <- pivot_wider(
  data = longer_data,
  id_cols = c(customer_id, year),
  names_from = category,
  values_from = value
)

split_data <- separate(
  data = wider_data,
  col = itemsprice,
  into = c("items", "price_per_item"),
  sep = " ", 
  remove = TRUE, 
  convert = TRUE
) 

fixed_data <- mutate(
  .data = split_data,
  price_per_item = stringr::str_replace_all(
    string = price_per_item, 
    pattern = "[()]", 
    replacement = ""
  )
) 

tidy_data <- type_convert(
  df = fixed_data,
  trim_ws = TRUE,
)
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   price_per_item = col_double(),
##   totalprice = col_double()
## )
```

```r
print(tidy_data)
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <dbl> <int> <int>          <dbl>      <dbl>
##  1           1  2018     2           3.91       7.82
##  2           1  2019     8           4.72      37.8 
##  3           1  2020    10           5.59      55.9 
##  4           2  2018     1           3.91       3.91
##  5           2  2019     6           4.72      28.3 
##  6           2  2020     1           5.59       5.59
##  7           3  2018     4           3.91      15.6 
##  8           3  2019     5           4.72      23.6 
##  9           3  2020     5           5.59      28.0 
## 10           4  2018    10           3.91      39.1 
## 11           4  2019     1           4.72       4.72
## 12           4  2020     3           5.59      16.8 
## 13           5  2018     3           3.91      11.7 
## 14           5  2019     9           4.72      42.5 
## 15           5  2020     8           5.59      44.7
```

::: {.warning data-latex=""}
You *can* name each object `data` and keep replacing the old data object with the new one at each step. This will keep your environment clean, but I don't recommend it because it makes it too easy to accidentally run your code out of order when you are running line-by-line for development or debugging.
:::

One way to avoid extra objects is to nest your functions, literally replacing each data object with the code that generated it in the previous step. This can be fine for very short chains.


```r
mean_petal_width <- round(mean(iris$Petal.Width), 2)
```

But it gets extremely confusing for long chains:


```r
# do not ever do this!!!!!!
print(type_convert(
  df = mutate(
    .data = separate(
      data = pivot_wider(
        data = pivot_longer(
          data = read_csv(file = "data/untidy_data.csv"),
          cols = itemsprice_2018:totalprice_2020,
          names_to = c("category", "year"),
          names_sep = "_",
          values_to = "value",
          names_transform = list(year = as.integer),
          values_transform = list(value = as.character)
        ) ,
        id_cols = c(customer_id, year),
        names_from = category,
        values_from = value
      ),
      col = itemsprice,
      into = c("items", "price_per_item"),
      sep = " ",
      remove = TRUE,
      convert = TRUE
    ) ,
    price_per_item = stringr::str_replace_all(
      string = price_per_item,
      pattern = "[()]",
      replacement = ""
    )
  ),
  trim_ws = TRUE,
))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   customer_id = col_double(),
##   itemsprice_2018 = col_character(),
##   itemsprice_2019 = col_character(),
##   itemsprice_2020 = col_character(),
##   totalprice_2018 = col_double(),
##   totalprice_2019 = col_double(),
##   totalprice_2020 = col_double()
## )
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   price_per_item = col_double(),
##   totalprice = col_double()
## )
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <dbl> <int> <int>          <dbl>      <dbl>
##  1           1  2018     2           3.91       7.82
##  2           1  2019     8           4.72      37.8 
##  3           1  2020    10           5.59      55.9 
##  4           2  2018     1           3.91       3.91
##  5           2  2019     6           4.72      28.3 
##  6           2  2020     1           5.59       5.59
##  7           3  2018     4           3.91      15.6 
##  8           3  2019     5           4.72      23.6 
##  9           3  2020     5           5.59      28.0 
## 10           4  2018    10           3.91      39.1 
## 11           4  2019     1           4.72       4.72
## 12           4  2020     3           5.59      16.8 
## 13           5  2018     3           3.91      11.7 
## 14           5  2019     9           4.72      42.5 
## 15           5  2020     8           5.59      44.7
```


The pipe lets you "pipe" the result of each function into the next function, allowing you to put your code in a logical order without creating too many extra objects.


```r
tidy_data <- read_csv(file = "data/untidy_data.csv") %>%
  pivot_longer(
    cols = itemsprice_2018:totalprice_2020,
    names_to = c("category", "year"),
    names_sep = "_", 
    values_to = "value", 
    names_transform = list(year = as.integer),
    values_transform = list(value = as.character) 
  ) %>%
  pivot_wider(
    id_cols = c(customer_id, year),
    names_from = category,
    values_from = value
  ) %>%
  separate(
    col = itemsprice,
    into = c("items", "price_per_item"),
    sep = " ", 
    remove = TRUE, 
    convert = TRUE
  ) %>%
  mutate(
    price_per_item = stringr::str_replace_all(
      string = price_per_item, 
      pattern = "[()]", 
      replacement = ""
    )
  ) %>%
  type_convert(
    trim_ws = TRUE,
  ) %>% 
  print()
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   customer_id = col_double(),
##   itemsprice_2018 = col_character(),
##   itemsprice_2019 = col_character(),
##   itemsprice_2020 = col_character(),
##   totalprice_2018 = col_double(),
##   totalprice_2019 = col_double(),
##   totalprice_2020 = col_double()
## )
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   price_per_item = col_double(),
##   totalprice = col_double()
## )
```

```
## # A tibble: 15 x 5
##    customer_id  year items price_per_item totalprice
##          <dbl> <int> <int>          <dbl>      <dbl>
##  1           1  2018     2           3.91       7.82
##  2           1  2019     8           4.72      37.8 
##  3           1  2020    10           5.59      55.9 
##  4           2  2018     1           3.91       3.91
##  5           2  2019     6           4.72      28.3 
##  6           2  2020     1           5.59       5.59
##  7           3  2018     4           3.91      15.6 
##  8           3  2019     5           4.72      23.6 
##  9           3  2020     5           5.59      28.0 
## 10           4  2018    10           3.91      39.1 
## 11           4  2019     1           4.72       4.72
## 12           4  2020     3           5.59      16.8 
## 13           5  2018     3           3.91      11.7 
## 14           5  2019     9           4.72      42.5 
## 15           5  2020     8           5.59      44.7
```


You can make intermediate objects whenever you need to break up your code because it's getting too complicated or if you need to debug something.

::: {.info data-latex=""}
You can debug a pipe by highlighting from the beginning to just before the pipe you want to stop at. Try this by highlighting from `data <-` to the end of the `separate` function and typing cmd-return. What does `data` look like now?
:::



## Exercise

Let's say you have a [small Excel table](data/widgets_gadgets.xlsx) with 10 customer IDs, and how many widgets and gadgets each purchased in 2020 and 2021. 



You want to calculate the total number of items purchased per year make a table sorted by the total number of  items purchased.





```r
# get the data with better column names
data_original <- readxl::read_excel(
  path = "data/widgets_gadgets.xlsx", 
  skip = 2,
  col_names = c("customer_id", 
                "widgets_2020", 
                "widgets_2021", 
                "gadgets_2020", 
                "gadgets_2021")
)

# gather columns 2 to 5 into "item_year" and "number" columns
data_gathered <- gather(data = data_original, 
                        key = item_year, 
                        value = number, 2:5)

# separate the item_year column at the _ into "item" and "year" columns
data_separated <- separate(data = data_gathered, 
                           col = item_year, 
                           into = c("item", "year"), 
                           sep = "_")

# group the data by item and year
data_grouped <- group_by(.data = data_separated, item, year)

# calculate the total number for each item/year 
data_summarised <- summarise(.data = data_grouped, 
                             year_total = sum(number), 
                             .groups = "drop")

# spread the year_total column into columns by year
data_spread <- spread(data = data_summarised, 
                      key = year, 
                      value = year_total)
```



```r
data <- readxl::read_excel(
  path = "data/widgets_gadgets.xlsx", 
  skip = 2,
  col_names = c("customer_id", 
                "widgets_2020", 
                "widgets_2021", 
                "gadgets_2020", 
                "gadgets_2021")
) %>%
  gather(key = item_year, value = number, 2:5) %>%
  separate(col = item_year, into = c("item", "year"), sep = "_") %>%
  group_by(item, year) %>%
  summarise(year_total = sum(number), .groups = "drop") %>%
  spread(key = year, value = year_total)
```

You can read this code from top to bottom as follows:

1. Read in an excel file 
    - at the *path* <code class='path'>data/widgets_gadgets.xlsx</code>
    - *skip*ping the first two rows,
    - with new *col*umn *names*; **and then**
2. Gather to create a *key* column `item_year` and *value* column `number` from columns 2 to 5; **and then**
3. Separate the *col*umn `item_year` *into* 2 new columns called `item` and `year`, *sep*arate at the "_"; **and then**
4. Group by columns `item` and `year`; **and then**
5. Summarise and new column called `year_total` as the sum of the `number` column for each group and drop *groups*; **and then**
6. Mutate the table to add a new column called `total` that is the sum of the `year_total` column for each group; **and then**
6. Spread to make new columns with the *key* names in `year` and *value*s in `year_total`
