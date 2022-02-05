# Data Wrangling {#wrangle}

<div class="incomplete-chapter"></div>

## Intended Learning Outcomes {#ilo-wrangle}

* Be able to select and filter data for relevance
* Be able to create new columns and edit existing ones
* Be able to handle missing data


```r
library(tidyverse)   # data wrangling functions
```

## Wrangling functions

Most <a class='glossary' target='_blank' title='The process of preparing data for visualisation and statistical analysis.' href='https://psyteachr.github.io/glossary/d#data-wrangling'>data wrangling</a> involves the reshaping functions you learned in Chapter\ \@ref(tidy) and these six functions: `select`, `filter`, `arrange`, `mutate`, `summarise`, and `group_by`. You'll remember the last two from Chapter\ \@ref(summary), so we'll only cover them briefly.



We'll use a small example table with the sales and expenses for two years from four regions over two products.


```r
budget <- read_csv("data/budget.csv", show_col_types = FALSE)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"12029","4":"9383","5":"10722","6":"9003"},{"1":"North","2":"gadgets","3":"5673","4":"5027","5":"5987","6":"6065"},{"1":"South","2":"widgets","3":"11023","4":"8450","5":"10904","6":"10572"},{"1":"South","2":"gadgets","3":"6972","4":"4005","5":"4340","6":"5150"},{"1":"East","2":"widgets","3":"9172","4":"9849","5":"9099","6":"9558"},{"1":"East","2":"gadgets","3":"4527","4":"4596","5":"5044","6":"6986"},{"1":"West","2":"widgets","3":"10533","4":"10690","5":"10683","6":"9585"},{"1":"West","2":"gadgets","3":"6154","4":"5376","5":"5383","6":"4814"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Select

Select columns by name or number.

You can select each column individually, separated by commas (e.g., `region, sales_2019`). You can also select all columns from one to another by separating them with a colon (e.g., `sales_2019:expenses_2020`).


```r
budget2020 <- budget %>% select(region, sales_2020, expenses_2020)
names(budget2020)
```

```
## [1] "region"        "sales_2020"    "expenses_2020"
```

You can select columns by number, which can be useful when the column names are long or complicated. You even rename them by setting `new_name = old_col`. 


```r
regions <- budget %>% select(`Sales Region` = 1, 3:6)
names(regions)
```

```
## [1] "Sales Region"  "sales_2019"    "sales_2020"    "expenses_2019"
## [5] "expenses_2020"
```

You can use a minus symbol to un-select columns, leaving all of the other columns. If you want to exclude a span of columns, put parentheses around the span first, e.g., `-(sales_2019:expenses_2020)`, not `-sales_2019:expenses_2020`.


```r
sales <- budget %>% select(-(expenses_2019:expenses_2020))
names(sales)
```

```
## [1] "region"     "product"    "sales_2019" "sales_2020"
```

You can select columns based on criteria about the column names.

| function | definition |
|----------|------------|
| `starts_with()` | select columns that start with a character string|
| `ends_with()` | elect columns that end with a character string |
| `contains()` | select columns that contain a character string |
| `num_range()` | select columns with a name that matches the pattern `prefix` |

::: {.info data-latex=""}
Use `width` to set the number of digits with leading
zeros. For example, `num_range('var_', 8:10, width=2)` selects columns `var_08`, `var_09`, and `var_10`.
:::




::: {.try data-latex=""}
What are the resulting columns for these four examples?

* `budget %>% select(starts_with("sales"))`
    <select class='webex-select'><option value='blank'></option><option value='x'>expenses_2019, expenses_2020</option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020</option><option value='x'>sales_2020, expenses_2020</option><option value='answer'>sales_2019, sales_2020</option></select> 
* `budget %>% select(ends_with("2020"))`
    <select class='webex-select'><option value='blank'></option><option value='x'>expenses_2019, expenses_2020</option><option value='answer'>sales_2020, expenses_2020</option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020</option><option value='x'>sales_2019, sales_2020</option></select>
* `budget %>% select(contains("_"))`
    <select class='webex-select'><option value='blank'></option><option value='answer'>sales_2019, sales_2020, expenses_2019, expenses_2020</option><option value='x'>expenses_2019, expenses_2020</option><option value='x'>sales_2020, expenses_2020</option><option value='x'>sales_2019, sales_2020</option></select>
* `budget %>% select(num_range("expenses_", 2019:2020))`
    <select class='webex-select'><option value='blank'></option><option value='x'>sales_2019, sales_2020</option><option value='x'>sales_2019, sales_2020, expenses_2019, expenses_2020</option><option value='x'>sales_2020, expenses_2020</option><option value='answer'>expenses_2019, expenses_2020</option></select>
:::



### Filter

Select rows by matching column criteria.


```r
# select all rows from the North region
budget %>% filter(region == "North")
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"12029","4":"9383","5":"10722","6":"9003"},{"1":"North","2":"gadgets","3":"5673","4":"5027","5":"5987","6":"6065"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

::: {.warning data-latex=""}
Remember to use `==` and not `=` to check if two things are equivalent. A single `=` assigns the right-hand value to the left-hand variable.
:::

You can select on multiple criteria by separating them with commas.


```r
budget %>% filter(
  region == "North",
  product == "widgets"
)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"12029","4":"9383","5":"10722","6":"9003"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

You can use the symbols `&`, `|`, and `!` to mean "and", "or", and "not". You can also use other operators to make equations. The equation is checked for each row, and if the result is FALSE, the row is removed.


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

# everything but the North
not_north <- budget %>%
  filter(region != "North")

# 2020 profit greater than 1000
profit_1000 <- budget %>%
  filter(sales_2020 - expenses_2020 > 1000)
```

The <a class='glossary' target='_blank' title='A binary operator (%in%) that returns a logical vector indicating if there is a match or not for its left operand.' href='https://psyteachr.github.io/glossary/m#match-operator'>match operator</a> (`%in%`) is useful here for testing if a column value is in a list.


```r
budget %>%
  filter(region %in% c("North", "South"),
         product == "widgets")
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"12029","4":"9383","5":"10722","6":"9003"},{"1":"South","2":"widgets","3":"11023","4":"8450","5":"10904","6":"10572"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Arrange

Sort your dataset using `arrange()`. You will find yourself needing to sort data in R much less than you do in Excel, since you don't need to have rows next to each other in order to, for example, calculate group means. But `arrange()` can be useful when preparing data for display in tables. Reverse the order using `desc()`.


```r
budget %>%
  arrange(product, desc(region))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"West","2":"gadgets","3":"6154","4":"5376","5":"5383","6":"4814"},{"1":"South","2":"gadgets","3":"6972","4":"4005","5":"4340","6":"5150"},{"1":"North","2":"gadgets","3":"5673","4":"5027","5":"5987","6":"6065"},{"1":"East","2":"gadgets","3":"4527","4":"4596","5":"5044","6":"6986"},{"1":"West","2":"widgets","3":"10533","4":"10690","5":"10683","6":"9585"},{"1":"South","2":"widgets","3":"11023","4":"8450","5":"10904","6":"10572"},{"1":"North","2":"widgets","3":"12029","4":"9383","5":"10722","6":"9003"},{"1":"East","2":"widgets","3":"9172","4":"9849","5":"9099","6":"9558"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


::: {.try data-latex=""}
If you want to sort categories in a specific order, turn the column into a <a class='glossary' target='_blank' title='A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter' href='https://psyteachr.github.io/glossary/f#factor'>factor</a> and set the `levels` in the desired order.


```r
budget %>%
  mutate(region = factor(region, levels = c("North", "South", "East", "West"))) %>%
  filter(product == "gadgets") %>%
  arrange(region)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["fct"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["sales_2019"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["sales_2020"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses_2019"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["expenses_2020"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"gadgets","3":"5673","4":"5027","5":"5987","6":"6065"},{"1":"South","2":"gadgets","3":"6972","4":"4005","5":"4340","6":"5150"},{"1":"East","2":"gadgets","3":"4527","4":"4596","5":"5044","6":"6986"},{"1":"West","2":"gadgets","3":"6154","4":"5376","5":"5383","6":"4814"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

:::

### Mutate

Add new columns or change existing ones. Refer to other columns by their names (unquoted). You can add more than one column in the same mutate function, just separate the columns with a comma. Once you make a new column, you can use it in further column definitions (e.g., `profit` below).


```r
budget2 <- budget %>%
  mutate(
    sales = sales_2019 + sales_2020,
    expenses = expenses_2019 + expenses_2020,
    profit = sales - expenses,
    region = paste(region, "Office")
  )
```


::: {.warning data-latex=""}
You can overwrite a column by giving a new column the same name as the old column (see `region`) above. Make sure that you mean to do this and that you aren't trying to use the old column value after you redefine it.
:::


### Summarise {#dplyr-summarise}

You were introduced to the `summarise()` function in Chapter\ @\ref({#summary-summarise}). This applies summary functions to an entire table (or groups, as you'll see in the next section).

Let's say we want to determine the mean sales and expenses, plus the minimum and maximum profit, for any region, product and year. First, we need to reshape the data like we learned in Chapter\ \@ref(tidy), so that there is a column for year and one column each for sales and expenses, instead of separate columns for each year.


```r
budget3 <- budget %>%
  pivot_longer(cols = sales_2019:expenses_2020,
               names_to = c("type", "year"),
               names_sep = "_",
               values_to = "value") %>%
  pivot_wider(names_from = type,
              values_from = value)

head(budget3) # check the format
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["year"],"name":[3],"type":["chr"],"align":["left"]},{"label":["sales"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"2019","4":"12029","5":"10722"},{"1":"North","2":"widgets","3":"2020","4":"9383","5":"9003"},{"1":"North","2":"gadgets","3":"2019","4":"5673","5":"5987"},{"1":"North","2":"gadgets","3":"2020","4":"5027","5":"6065"},{"1":"South","2":"widgets","3":"2019","4":"11023","5":"10904"},{"1":"South","2":"widgets","3":"2020","4":"8450","5":"10572"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Now we can create summary statistics for the table.


```r
budget3 %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales)
  )
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["mean_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["mean_expenses"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["min_profit"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["max_profit"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"7716.188","2":"7743.438","3":"-2632","4":"2390"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Group By {#dplyr-groupby}

You were introduced to the `group_by()` function in Chapter\ \@ref(grouping). For example, you can break down the summary statistics above by year and product.


```r
year_prod <- budget3 %>%
  group_by(year, product) %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales),
    .groups = "drop"
  )

year_prod
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["year"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["mean_sales"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["mean_expenses"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["min_profit"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["max_profit"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"2019","2":"gadgets","3":"5831.50","4":"5188.50","5":"-2632","6":"517"},{"1":"2019","2":"widgets","3":"10689.25","4":"10352.00","5":"-1307","6":"150"},{"1":"2020","2":"gadgets","3":"4751.00","4":"5753.75","5":"-562","6":"2390"},{"1":"2020","2":"widgets","3":"9593.00","4":"9679.50","5":"-1105","6":"2122"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

::: {.try data-latex=""}
How would you find out the maximum sales for each region?

<div class='webex-radiogroup' id='radio_JWHMVTEWPN'><label><input type="radio" autocomplete="off" name="radio_JWHMVTEWPN" value="answer"></input> <span><pre>budget3 %>%
  group_by(region) %>%
  summarise(max_sales = max(sales)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_JWHMVTEWPN" value="x"></input> <span><pre>budget3 %>%
  group_by(region) %>%
  summarise(max_sales = max(region)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_JWHMVTEWPN" value="x"></input> <span><pre>budget3 %>%
  group_by(sales) %>%
  summarise(max_sales = max(sales)</pre></span></label><label><input type="radio" autocomplete="off" name="radio_JWHMVTEWPN" value="x"></input> <span><pre>budget3 %>%
  group_by(sales) %>%
  summarise(max_sales = max(region)</pre></span></label></div>

:::

## Complications

### Rounding

Let's say we want to round all the values to the nearest pound. The pattern below uses the `across()` function to apply the `round()` function to the columns from `mean_sales` to `max_profit`.


```r
year_prod %>%
  mutate(across(.cols = mean_sales:max_profit, 
                .fns = round))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["year"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["mean_sales"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["mean_expenses"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["min_profit"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["max_profit"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"2019","2":"gadgets","3":"5832","4":"5188","5":"-2632","6":"517"},{"1":"2019","2":"widgets","3":"10689","4":"10352","5":"-1307","6":"150"},{"1":"2020","2":"gadgets","3":"4751","4":"5754","5":"-562","6":"2390"},{"1":"2020","2":"widgets","3":"9593","4":"9680","5":"-1105","6":"2122"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

If you compare this table to the one in Section\ \@ref(dplyr-groupby), you'll see that the 2019 gadgets mean sales rounded up from 5831.5 to 5832, while the mean expenses rounded from 5188.5 to 5188. What's going on!?

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

What if the North region hasn't returned their sales data for 2020 yet?


```r
# set sales values to NA for North 2020 rows
budget_missing <- budget3 %>%
  mutate(sales = ifelse(region == "North" & year == 2020, NA, sales))

# check
filter(budget_missing, region == "North")
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["year"],"name":[3],"type":["chr"],"align":["left"]},{"label":["sales"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["expenses"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"North","2":"widgets","3":"2019","4":"12029","5":"10722"},{"1":"North","2":"widgets","3":"2020","4":"NA","5":"9003"},{"1":"North","2":"gadgets","3":"2019","4":"5673","5":"5987"},{"1":"North","2":"gadgets","3":"2020","4":"NA","5":"6065"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Now, if we try to calculate the mean sales and profits, we get missing values for any summary value that used one of the North 2020 sales values.


```r
budget_missing %>%
  group_by(year, product) %>%
  summarise(
    mean_sales = mean(sales),
    mean_expenses = mean(expenses),
    min_profit = min(expenses - sales),
    max_profit = max(expenses - sales),
    .groups = "drop"
  )
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["year"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["mean_sales"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["mean_expenses"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["min_profit"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["max_profit"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"2019","2":"gadgets","3":"5831.50","4":"5188.50","5":"-2632","6":"517"},{"1":"2019","2":"widgets","3":"10689.25","4":"10352.00","5":"-1307","6":"150"},{"1":"2020","2":"gadgets","3":"NA","4":"5753.75","5":"NA","6":"NA"},{"1":"2020","2":"widgets","3":"NA","4":"9679.50","5":"NA","6":"NA"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

This is because `NA` basically means "I don't know", and the sum of 100 and "I don't know" is "I don't know", not 100. However, when you're calculating means, you often want to just ignore missing values. Set `na.rm = TRUE` in the summary function to remove missing values before calculating.


```r
budget_missing %>%
  group_by(year, product) %>%
  summarise(
    mean_sales = mean(sales, na.rm = TRUE),
    mean_expenses = mean(expenses, na.rm = TRUE),
    min_profit = min(expenses - sales, na.rm = TRUE),
    max_profit = max(expenses - sales, na.rm = TRUE),
    .groups = "drop"
  )
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["year"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["mean_sales"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["mean_expenses"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["min_profit"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["max_profit"],"name":[6],"type":["dbl"],"align":["right"]}],"data":[{"1":"2019","2":"gadgets","3":"5831.50","4":"5188.50","5":"-2632","6":"517"},{"1":"2019","2":"widgets","3":"10689.25","4":"10352.00","5":"-1307","6":"150"},{"1":"2020","2":"gadgets","3":"4659.00","4":"5753.75","5":"-562","6":"2390"},{"1":"2020","2":"widgets","3":"9663.00","4":"9679.50","5":"-1105","6":"2122"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

If you want to find out how many missing or non-missing values there are in a column, use the `is.na()` function to get a <a class='glossary' target='_blank' title='A data type representing TRUE or FALSE values.' href='https://psyteachr.github.io/glossary/l#logical'>logical</a> vector of whether or not each value is missing, and use `sum()` to count how many values are TRUE or `mean()` to calculate the proportion of TRUE values.


```r
budget_missing %>%
  group_by(year, product) %>%
  summarise(
    n_valid = sum(!is.na(sales)),
    n_missing = sum(is.na(sales)),
    prop_missing = mean(is.na(sales)),
    .groups = "drop"
  )
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["year"],"name":[1],"type":["chr"],"align":["left"]},{"label":["product"],"name":[2],"type":["chr"],"align":["left"]},{"label":["n_valid"],"name":[3],"type":["int"],"align":["right"]},{"label":["n_missing"],"name":[4],"type":["int"],"align":["right"]},{"label":["prop_missing"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"2019","2":"gadgets","3":"4","4":"0","5":"0.00"},{"1":"2019","2":"widgets","3":"4","4":"0","5":"0.00"},{"1":"2020","2":"gadgets","3":"3","4":"1","5":"0.25"},{"1":"2020","2":"widgets","3":"3","4":"1","5":"0.25"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


## Putting it together {#together-wrangle}

Load some demo data we first used in Chapter\ \@ref(data). Use `glimpse()` or another method to get familiar with the data set.


```r
# from https://www.kaggle.com/kyanyoga/sample-sales-data
sales <- read_csv("data/sales_data_sample.csv",
                  show_col_types = FALSE)
```


Double check that the `SALES` column does equal the `QUANTITYORDERED` column times the `PRICEEACH`. You can select just the columns you need and rename them when selecting to make the code more readable.


```r
sales_check <- sales %>%
  select(SALES, n = QUANTITYORDERED, price = PRICEEACH) %>%
  mutate(total = n * price)
```

Make a table of any rows where the value of `total` doesn't equal `SALES`.


```r
errors <- sales_check %>%
  filter(SALES != total)

head(errors)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["SALES"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["n"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["price"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["total"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"2765.90","2":"34","3":"81.35","4":"2765.90"},{"1":"3884.34","2":"41","3":"94.74","4":"3884.34"},{"1":"3746.70","2":"45","3":"83.26","4":"3746.70"},{"1":"5205.27","2":"49","3":"100.00","4":"4900.00"},{"1":"3479.76","2":"36","3":"96.66","4":"3479.76"},{"1":"5512.32","2":"48","3":"100.00","4":"4800.00"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

If you check the `errors` table, you'll see that 1697 of the original 2823 rows have "errors", even though many of the values in the `SALES` and `sales_check` columns look identical. You can fix this by rounding the value of `total` to 2 decimal places.

::: {.info data-latex=""}
This is due to the way values with decimal places are represented by a computer. You use base 10 to count, and have to represent some numbers with a repeating decimal, like 1/3 is .0333 repeating, while a computer uses binary to count, and has to represent different numbers using repeats. This can lead to very small differences when you divide or multiply some numbers.


```r
options(scipen = 20) # avoids scientific notation
x = (1/49 * 49)
x # prints as 1
1-x # but is actually very slightly smaller
```

```
## [1] 1
## [1] 0.0000000000000001110223
```

:::



```r
errors <- sales_check %>%
  filter(SALES != round(total, 2))
```

There are still 1304 errors! Lets look at the 10 smallest. We can do this by calculating the difference, arranging from smallest to largest, and filtering for the first 10 rows. 


```r
errors %>%
  mutate(diff = SALES - total) %>%
  arrange(diff) %>%
  filter(row_number() <= 10)
```

Alternatively, we can use a `slice` function.


```r
errors %>%
  mutate(diff = SALES - total) %>%
  slice_min(order_by = diff, n = 10)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["SALES"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["n"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["price"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["total"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["diff"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"2600.26","2":"26","3":"100","4":"2600","5":"0.26"},{"1":"3602.16","2":"36","3":"100","4":"3600","5":"2.16"},{"1":"2504.75","2":"25","3":"100","4":"2500","5":"4.75"},{"1":"4607.36","2":"46","3":"100","4":"4600","5":"7.36"},{"1":"3711.10","2":"37","3":"100","4":"3700","5":"11.10"},{"1":"3912.09","2":"39","3":"100","4":"3900","5":"12.09"},{"1":"2612.48","2":"26","3":"100","4":"2600","5":"12.48"},{"1":"4613.80","2":"46","3":"100","4":"4600","5":"13.80"},{"1":"4814.40","2":"48","3":"100","4":"4800","5":"14.40"},{"1":"2915.66","2":"29","3":"100","4":"2900","5":"15.66"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

If we plot the data, it looks like all of the errors are in one direction.


```r
ggplot(errors, aes(x = SALES, y = total)) + 
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0) +
  coord_cartesian(xlim = c(0, 15000), ylim = c(0, 8000))
```

<img src="08-wrangle_files/figure-html/unnamed-chunk-25-1.png" width="100%" style="display: block; margin: auto;" />

Let's have a look at the data separately for products with a price of exactly 100 versus other products.


```r
sales_check %>%
  mutate(price100 = price == 100) %>%
  ggplot(aes(x = SALES, y = total, color = price100)) + 
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0) +
  coord_cartesian(xlim = c(0, 15000), ylim = c(0, 8000))
```

<img src="08-wrangle_files/figure-html/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />

It looks like that's the problem with this dataset: the `PRICEEACH` column doesn't go above 100. Let's fix that by dividing the total sale price by the quantity ordered.


```r
fixed_sales <- sales %>%
  mutate(PRICEEACH = round(SALES / QUANTITYORDERED, 2))
```

Now we can re-run the code from before to find any errors. We're adding in the `ORDERNUMBER` for the next step.


```r
sales_check <- fixed_sales %>%
  select(ORDERNUMBER, 
         SALES, 
         n = QUANTITYORDERED, 
         price = PRICEEACH) %>%
  mutate(total = n * price)

errors <- sales_check %>%
  filter(SALES != round(total, 2))

errors
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["ORDERNUMBER"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["SALES"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["n"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["price"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["total"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"10304","2":"10172.7","3":"47","4":"216.44","5":"10172.68"},{"1":"10312","2":"11623.7","3":"48","4":"242.16","5":"11623.68"},{"1":"10405","2":"11739.7","3":"76","4":"154.47","5":"11739.72"},{"1":"10375","2":"10039.6","3":"43","4":"233.48","5":"10039.64"},{"1":"10388","2":"10066.6","3":"46","4":"218.84","5":"10066.64"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

There are 5 instances where the quantity ordered doesn't divide into the total price in a way that produces prices that round to the nearest cent. These might require further investigation, but let's just set the value of `SALES` to missing for the orders in the `errors` tables.


```r
fixed_sales <- fixed_sales %>%
  mutate(SALES = ifelse(
    test = ORDERNUMBER %in% errors$ORDERNUMBER,
    yes = NA,
    no = SALES)
  )
```


Now that you've fixed (most of) the problems with the dataset, see if you can figure out how to make the table below. It should take you 5 steps.

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["PRODUCTLINE"],"name":[1],"type":["chr"],"align":["left"]},{"label":["2003"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["2004"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["2005"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"Planes","2":"272258","3":"502672","4":"159051"},{"1":"Ships","2":"244821","3":"341438","4":"128178"},{"1":"Trains","2":"72802","3":"116524","4":"36917"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>



<div class='webex-solution'><button>Solution</button>

```r
fixed_sales %>%
  filter(PRODUCTLINE %in% c("Planes", "Ships", "Trains")) %>%
  group_by(YEAR_ID, PRODUCTLINE) %>%
  summarise(total = sum(SALES, na.rm = TRUE),
            .groups = "drop") %>%
  mutate(total = round(total)) %>%
  pivot_wider(names_from = YEAR_ID,
              values_from = total)
```


</div>

## Exercises

### Mutate

Load some data about the [population of the Scottish counties](https://psyteachr.github.io/ads-v1/data/scottish_population.csv). 


```r
scotpop <- read_csv("data/scottish_population.csv",
                    show_col_types = FALSE)
```

Transform the population value to the nearest thousands (e.g., 3433 would be "3K"), order from most to least populous, put the columns in the order `population` (in K) then `county`, and show only the counties with populations greater than 200K. 

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["population"],"name":[1],"type":["chr"],"align":["left"]},{"label":["county"],"name":[2],"type":["chr"],"align":["left"]}],"data":[{"1":"593K","2":"Glasgow"},{"1":"486K","2":"Edinburgh"},{"1":"365K","2":"Fife"},{"1":"326K","2":"North Lanarkshire"},{"1":"312K","2":"South Lanarkshire"},{"1":"246K","2":"Aberdeenshire"},{"1":"222K","2":"Highland"},{"1":"217K","2":"Aberdeen"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

::: {.try data-latex=""}
There are several different ways you could make the table above. Some functions could be in a different order and some couldn't. See where you can move the `filter()` and `arrange()` functions.
:::


<div class='webex-solution'><button>Solution</button>

```r
scotpop %>%
  arrange(desc(population)) %>%
  filter(population > 200000) %>%
  mutate(kpop = round(population/1000) %>% paste0("K")) %>%
  select(population = kpop, 
         county = name)
```


</div>

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


