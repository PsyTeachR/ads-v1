# Data Import and Relations {#data}

## Intended Learning Outcomes {#ilo-data}

* Be able to import data from a range of sources
* Be able to identify and handle common problems with data import
* Be able to match related data from multiple tables


```r
library(tidyverse) # includes readr
library(rio)       # for almost any data import/export
library(haven)     # for SPSS, Stata,and SAS files
library(readxl)    # for Excel files
```

## Data Import

For this lesson, please download a [directory of data files used in this class](data/data.zip).

### Built-in data {#builtin}

R comes with built-in datasets. Some packages, like <code class='package'>tidyr</code>, also contain data. The <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/data.html'>data</a></span><span class='op'>(</span><span class='op'>)</span></code> function lists the datasets available in a <a class='glossary' target='_blank' title='A group of R functions.' href='https://psyteachr.github.io/glossary/p#package'>package</a>.


```r
# lists datasets in tidyr
data(package = "tidyr")
```

Type the name of a dataset into the <a class='glossary' target='_blank' title='The pane in RStudio where you can type in commands and view output messages.' href='https://psyteachr.github.io/glossary/c#console'>console</a> to see the data. Type `?table1` into the console to see the dataset description.


```r
?table1
```

You can also use the <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/data.html'>data</a></span><span class='op'>(</span><span class='op'>)</span></code> function to load a dataset into your <a class='glossary' target='_blank' title='The interactive workspace where your script runs' href='https://psyteachr.github.io/glossary/g#global-environment'>global environment</a>.


```r
# loads table1 into the environment
data("table1")
```


### Importing data {#import_data}




Built-in data are nice for examples, but you're probably more interested in your own data. There are many different types of files that you might work with when doing data analysis. These different file types are usually distinguished by the three letter <a class='glossary' target='_blank' title='The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd).' href='https://psyteachr.github.io/glossary/e#extension'>extension</a> following a period at the end of the file name. 

#### rio::import()  

The <code class='package'>rio</code> package has very straightforward functions for reading and saving data: <code><span class='fu'>rio</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://rdrr.io/pkg/rio/man/import.html'>import</a></span><span class='op'>(</span><span class='op'>)</span></code> and <code><span class='fu'>rio</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://rdrr.io/pkg/rio/man/export.html'>export</a></span><span class='op'>(</span><span class='op'>)</span></code>.


```r
demo_tsv  <- import("data/demo.tsv") # tab-separated values
demo_csv  <- import("data/demo.csv") # comma-separated values
demo_xls  <- import("data/demo.xlsx") # Excel format
demo_sav  <- import("data/demo.sav") # SPSS format
```


#### File type specific import functions 

However, it is also useful to know the specific functions that are used to import different file types because they tend to have more features to deal with complicated cases, such as when you need to skip rows, rename columns, or choose which Excel sheet to use.


```r
demo_tsv  <- readr::read_tsv("data/demo.tsv")
demo_csv  <- readr::read_csv("data/demo.csv")
demo_xls <- readxl::read_excel("data/demo.xlsx")
demo_sav  <- haven::read_sav("data/demo.sav")
```

The <code class='package'>readr</code> functions display a message when you import data explaining what <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a> each column is.


```r
demo <- readr::read_csv("data/demo.csv")
```

```
## Rows: 6 Columns: 5
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (2): character, date
## dbl (2): integer, double
## lgl (1): logical
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

If it makes a mistake, such as reading the "date" column as a <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a>, you can manually set the column data types. Just copy the "Column specification" that was printed when you first imported the data, and make any changes you need.


```r
ct <- cols(
  character = col_character(),
  integer = col_double(),
  double = col_double(),
  logical = col_logical(),
  date = col_date(format = "%d-%b-%y")
)

demo  <- readr::read_csv("data/demo.csv", col_types = ct)
```

::: {.info data-latex=""}
For dates, you might need to set the format. See `?strptime` for a list of the codes used to represent different date formats. Above, <code><span class='st'>"%d-%b-%y"</span></code> means that the dates are formatted like `{day number}-{month abbreviation}-{2-digit year}`. 
:::


#### Google Sheets  

If you keep data in Google Sheets, you can access it directly from R using <code class='package'><a href='https://googlesheets4.tidyverse.org/' target='_blank'>googlesheets4</a></code>.


```r
library(googlesheets4)

gs4_deauth() # skip authorisation for public data

url <- "https://docs.google.com/spreadsheets/d/1yhAPP0hk6fNssL9UdpJ7m_vx00VY5PQKHspx6DNQNSY/"

demo_goo  <- googlesheets4::read_sheet(url)
```





### Looking at data

Now that you've loaded some data, look the upper right hand window of RStudio, under the Environment tab. You will see the objects listed, along with their number of observations (rows) and variables (columns). This is your first check that everything went OK.

Always, always, always, look at your data once you've created or loaded a table. Also look at it after each step that transforms your table. There are three main ways to look at your table: <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/View.html'>View</a></span><span class='op'>(</span><span class='op'>)</span></code>, <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/base/print.html'>print</a></span><span class='op'>(</span><span class='op'>)</span></code>, <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://pillar.r-lib.org/reference/glimpse.html'>glimpse</a></span><span class='op'>(</span><span class='op'>)</span></code>. 

#### View() 

A familiar way to look at the table is given by <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/View.html'>View</a></span><span class='op'>(</span><span class='op'>)</span></code> (uppercase 'V'). This command can be useful in the console, but don't ever put this one in a script because it will create an annoying pop-up window when the user runs it. Or you can click on an objects in the  <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>environment pane</a> to open it up in a viewer that looks a bit like Excel. You can close the tab when you're done looking at it; it won't remove the object.

#### print() 

The <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/base/print.html'>print</a></span><span class='op'>(</span><span class='op'>)</span></code> method can be run explicitly, but is more commonly called by just typing the variable name on the blank line. The default is not to print the entire table, but just the first 10 rows. 

Let's look at the `demo_tsv` table that we loaded above. Depending on how wide your screen is, you might need to click on an arrow at the right of the table to see the last column. 


```r
demo_tsv
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> character </th>
   <th style="text-align:right;"> integer </th>
   <th style="text-align:right;"> double </th>
   <th style="text-align:left;"> logical </th>
   <th style="text-align:left;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> A </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 26-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> B </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 25-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 3.5 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 24-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> D </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 4.5 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 23-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> E </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 5.5 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> 22-Sep-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 6.5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 21-Sep-21 </td>
  </tr>
</tbody>
</table>

</div>

#### glimpse() 

The function <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://pillar.r-lib.org/reference/glimpse.html'>glimpse</a></span><span class='op'>(</span><span class='op'>)</span></code> gives a sideways version of the table. This is useful if the table is very wide and you can't see all of the columns. It also tells you the <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a> of each column in angled brackets after each column name. You can learn about data types in Appendix\ \@ref(data-types).


```r
glimpse(demo_xls)
```

```
## Rows: 6
## Columns: 5
## $ character <chr> "A", "B", "C", "D", "E", "F"
## $ integer   <dbl> 1, 2, 3, 4, 5, 6
## $ double    <dbl> 1.5, 2.5, 3.5, 4.5, 5.5, 6.5
## $ logical   <lgl> TRUE, TRUE, FALSE, FALSE, NA, TRUE
## $ date      <chr> "26-Sep-21", "25-Sep-21", "24-Sep-21", "23-Sep-21", "22-Sep-…
```

#### summary() {#summary-function}

You can get a quick summary of a dataset with the <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/base/summary.html'>summary</a></span><span class='op'>(</span><span class='op'>)</span></code> function.


```r
summary(demo_sav)
```

```
##   character            integer         double        logical   
##  Length:6           Min.   :1.00   Min.   :1.50   Min.   :0.0  
##  Class :character   1st Qu.:2.25   1st Qu.:2.75   1st Qu.:0.0  
##  Mode  :character   Median :3.50   Median :4.00   Median :1.0  
##                     Mean   :3.50   Mean   :4.00   Mean   :0.6  
##                     3rd Qu.:4.75   3rd Qu.:5.25   3rd Qu.:1.0  
##                     Max.   :6.00   Max.   :6.50   Max.   :1.0  
##                                                   NA's   :1    
##      date          
##  Length:6          
##  Class :character  
##  Mode  :character  
##                    
##                    
##                    
## 
```

### Creating data 

If we are creating a small data table from scratch, we can use the <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://tibble.tidyverse.org/reference/tibble.html'>tibble</a></span><span class='op'>(</span><span class='op'>)</span></code> function, and type the data right in. The `tibble` package is part of the <a class='glossary' target='_blank' title='A set of R packages that help you create and work with tidy data' href='https://psyteachr.github.io/glossary/t#tidyverse'>tidyverse</a> package that we loaded at the start of this chapter. 

Let's create a small table with the names of three Avatar characters and their bending type. The <code><span class='fu'>tibble</span><span class='op'>(</span><span class='op'>)</span></code> function takes <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>arguments</a> with the names that you want your columns to have. The values are <a class='glossary' target='_blank' title='A type of data structure that collects values with the same data type, like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vectors</a> that list the column values in order.

If you don't know the value for one of the cells, you can enter `NA`, which we have to do for Sokka because he doesn't have any bending ability. If all the values in the column are the same, you can just enter one value and it will be copied for each row.


```r
avatar <- tibble(
  name = c("Katara", "Toph", "Sokka"),
  bends = c("water", "earth", NA),
  friendly = TRUE
)

# print it
avatar
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> bends </th>
   <th style="text-align:left;"> friendly </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Katara </td>
   <td style="text-align:left;"> water </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Toph </td>
   <td style="text-align:left;"> earth </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sokka </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> TRUE </td>
  </tr>
</tbody>
</table>

</div>

You can also use the <code><span class='fu'>tibble</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://tibble.tidyverse.org/reference/tribble.html'>tribble</a></span><span class='op'>(</span><span class='op'>)</span></code> function to create a table by row, rather than by column. You start by listing the column names, each preceded by a tilde (`~`), then you list the values for each column, row by row, separated by commas (don't forget a comma at the end of each row).


```r
avatar_by_row <- tribble(
  ~name,    ~bends,  ~friendly,
  "Katara", "water", TRUE,
  "Toph",   "earth", TRUE,
  "Sokka",  NA,      TRUE
)
```

::: {.info data-latex=""}
You don't have to line up the columns in a tribble like we did above, but it can make it easier to spot errors.
:::

### Writing data

If you have data that you want to save to a CSV file, use <code><span class='fu'>rio</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://rdrr.io/pkg/rio/man/export.html'>export</a></span><span class='op'>(</span><span class='op'>)</span></code>, as follows.


```r
export(avatar, "data/avatar.csv")
```

This will save the data in CSV format to your working directory.

Writing to Google Sheets is a little trickier. Even if a Google Sheet is publicly editable, you can't add data to it without authorising your account. 

You can authorise interactively using the following code (and your own email), which will prompt you to authorise "Tidyverse API Packages" the first time you do this.


```r
gs4_auth(email = "debruine@gmail.com")
sheet_id <- gs4_create("demo-file", sheets = demo)

new_data <- tibble(
  character = "Z",
  integer = 0L,
  double = 0.5,
  logical = FALSE,
  date = "01-Jan-00"
)

sheet_append(sheet_id, new_data)
demo <- read_sheet(sheet_id)
```


::: {.try data-latex=""}
* Create a new table called `family` with the first name, last name, and age of your family members. 
* Save it to a CSV file called "family.csv". 
* Clear the object from your environment by restarting R or with the code `remove(family)`.
* Load the data back in and view it.


<div class='webex-solution'><button>Solution</button>

```r
# create the table
family <- tribble(
  ~first_name, ~last_name, ~age,
  "Lisa", "DeBruine", 45,
  "Robbie", "Jones", 14
)

# save the data to CSV
export(family, "data/family.csv")

# remove the object from the environment
remove(family)

# load the data
family <- import("data/family.csv")
```


</div>
:::

We'll be working with <a class='glossary' target='_blank' title='Data in a rectangular table format, where each row has an entry for each column.' href='https://psyteachr.github.io/glossary/t#tabular-data'>tabular data</a> a lot in this class, but tabular data is made up of <a class='glossary' target='_blank' title='A type of data structure that collects values with the same data type, like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vectors</a>, which groups together data with the same basic <a class='glossary' target='_blank' title='The kind of data represented by an object.' href='https://psyteachr.github.io/glossary/d#data-type'>data type</a>. Appendix\ \@ref(data-types) explains some of this terminology to help you understand the functions we'll be learning to process and analyse data.


### Troubleshooting

What if you import some data and it guesses the wrong column type? The most common reason is that a numeric column has some non-numbers in it somewhere. Maybe someone wrote a note in an otherwise numeric column. Columns have to be all one data type, so if there are any characters, the whole column is converted to character strings, and numbers like <code><span class='fl'>1.2</span></code> get represented as <code><span class='st'>"1.2"</span></code>, which will cause very weird errors like `"100" < "9" == TRUE`. You can catch this by using <code><span class='fu'>glimpse</span><span class='op'>(</span><span class='op'>)</span></code> to check your data.

The data directory you downloaded contains a file called "mess.csv". Let's try loading this dataset.


```r
mess <- import("data/mess.csv")
```

```
## Warning in (function (input = "", file = NULL, text = NULL, cmd = NULL, :
## Stopped early on line 5. Expected 7 fields but found 0. Consider fill=TRUE
## and comment.char=. First discarded non-empty line: <<junk,missing,0.72,b,1,2 -
## 3,2020-01-2>>
```

When importing goes wrong, it's often easier to fix it using the  specific importing function for that file type. This is because the problems tend to be specific to the file format and you can look up the help for these functions more easily. For CSV files, the import function is <code><span class='fu'>readr</span><span class='fu'>::</span><span class='va'><a target='_blank' href='https://readr.tidyverse.org/reference/read_delim.html'>read_csv</a></span></code>.


```r
mess <- read_csv("data/mess.csv")
```

```
## Rows: 27 Columns: 1
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): This is my messy dataset
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


You'll get a warning with many parsing errors and `mess` is just a single row. View the file `data/mess.csv` by clicking on it in the File pane, and choosing "View File". Here are the first 10 lines. What went wrong?

```
This is my messy dataset

junk,order,score,letter,good,min_max,date
junk,1,-1,a,1,1 - 2,2020-01-1

junk,missing,0.72,b,1,2 - 3,2020-01-2

junk,3,-0.62,c,FALSE,3 - 4,2020-01-3

junk,4,2.03,d,T,4 - 5,2020-01-4
```

First, the file starts with a note: "This is my messy dataset". We want to skip the first two lines. You can do this with the argument `skip` in `read_csv()`.


```r
mess <- read_csv("data/mess.csv", skip = 2)
```

```
## Rows: 26 Columns: 7
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (6): junk, order, letter, good, min_max, date
## dbl (1): score
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
mess
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> junk </th>
   <th style="text-align:left;"> order </th>
   <th style="text-align:right;"> score </th>
   <th style="text-align:left;"> letter </th>
   <th style="text-align:left;"> good </th>
   <th style="text-align:left;"> min_max </th>
   <th style="text-align:left;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:right;"> -1.00 </td>
   <td style="text-align:left;"> a </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 1 - 2 </td>
   <td style="text-align:left;"> 2020-01-1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> missing </td>
   <td style="text-align:right;"> 0.72 </td>
   <td style="text-align:left;"> b </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 2 - 3 </td>
   <td style="text-align:left;"> 2020-01-2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:right;"> -0.62 </td>
   <td style="text-align:left;"> c </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 3 - 4 </td>
   <td style="text-align:left;"> 2020-01-3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:right;"> 2.03 </td>
   <td style="text-align:left;"> d </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 4 - 5 </td>
   <td style="text-align:left;"> 2020-01-4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> e </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 5 - 6 </td>
   <td style="text-align:left;"> 2020-01-5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:right;"> 0.99 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 6 - 7 </td>
   <td style="text-align:left;"> 2020-01-6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:right;"> 0.03 </td>
   <td style="text-align:left;"> g </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 7 - 8 </td>
   <td style="text-align:left;"> 2020-01-7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:right;"> 0.67 </td>
   <td style="text-align:left;"> h </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 8 - 9 </td>
   <td style="text-align:left;"> 2020-01-8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:right;"> 0.57 </td>
   <td style="text-align:left;"> i </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 9 - 10 </td>
   <td style="text-align:left;"> 2020-01-9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:right;"> 0.90 </td>
   <td style="text-align:left;"> j </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 10 - 11 </td>
   <td style="text-align:left;"> 2020-01-10 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:right;"> -1.55 </td>
   <td style="text-align:left;"> k </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 11 - 12 </td>
   <td style="text-align:left;"> 2020-01-11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> l </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 12 - 13 </td>
   <td style="text-align:left;"> 2020-01-12 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:right;"> 0.15 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 13 - 14 </td>
   <td style="text-align:left;"> 2020-01-13 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:right;"> -0.66 </td>
   <td style="text-align:left;"> n </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 14 - 15 </td>
   <td style="text-align:left;"> 2020-01-14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:right;"> -0.99 </td>
   <td style="text-align:left;"> o </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 15 - 16 </td>
   <td style="text-align:left;"> 2020-01-15 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:right;"> 1.97 </td>
   <td style="text-align:left;"> p </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 16 - 17 </td>
   <td style="text-align:left;"> 2020-01-16 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:right;"> -0.44 </td>
   <td style="text-align:left;"> q </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 17 - 18 </td>
   <td style="text-align:left;"> 2020-01-17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:right;"> -0.90 </td>
   <td style="text-align:left;"> r </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 18 - 19 </td>
   <td style="text-align:left;"> 2020-01-18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:right;"> -0.15 </td>
   <td style="text-align:left;"> s </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 19 - 20 </td>
   <td style="text-align:left;"> 2020-01-19 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:right;"> -0.83 </td>
   <td style="text-align:left;"> t </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 20 - 21 </td>
   <td style="text-align:left;"> 2020-01-20 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:right;"> 1.99 </td>
   <td style="text-align:left;"> u </td>
   <td style="text-align:left;"> T </td>
   <td style="text-align:left;"> 21 - 22 </td>
   <td style="text-align:left;"> 2020-01-21 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:right;"> 0.04 </td>
   <td style="text-align:left;"> v </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 22 - 23 </td>
   <td style="text-align:left;"> 2020-01-22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:right;"> -0.40 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> 23 - 24 </td>
   <td style="text-align:left;"> 2020-01-23 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:right;"> -0.47 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 24 - 25 </td>
   <td style="text-align:left;"> 2020-01-24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:right;"> -0.41 </td>
   <td style="text-align:left;"> y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 25 - 26 </td>
   <td style="text-align:left;"> 2020-01-25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> junk </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:left;"> z </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 26 - 27 </td>
   <td style="text-align:left;"> 2020-01-26 </td>
  </tr>
</tbody>
</table>

</div>

OK, that's a little better, but this table is still a serious mess in several ways:

* `junk` is a column that we don't need
* `order` should be an integer column
* `good` should be a logical column
* `good` uses all kinds of different ways to record TRUE and FALSE values
* `min_max` contains two pieces of numeric information, but is a character column
* `date` should be a date column

We'll learn how to deal with this mess in Chapters\ \@ref(tidy) and \@ref(wrangle), but we can fix a few things by setting the `col_types` argument in <code><span class='fu'>read_csv</span><span class='op'>(</span><span class='op'>)</span></code> to specify the column types for our two columns that were guessed wrong and skip the "junk" column. The argument `col_types` takes a list where the name of each item in the list is a column name and the value is from the table below. You can use the function, like <code><span class='fu'>col_double</span><span class='op'>(</span><span class='op'>)</span></code> or the abbreviation, like <code><span class='st'>"l"</span></code>. Omitted column names are guessed.

| function | |abbreviation | type |
|:---------|:--------------|:-----|
| col_logical()   | l | logical values |
| col_integer()   | i | integer values |
| col_double()    | d | numeric values |
| col_character() | c | strings |
| col_factor(levels, ordered) | f | a fixed set of values |
| col_date(format = "")     | D | with the locale's date_format |
| col_time(format = "")     | t | with the locale's time_format |
| col_datetime(format = "") | T | ISO8601 date time |
| col_number()    | n | numbers containing the grouping_mark |
| col_skip()      | _, - | don't import this column |
| col_guess()     | ? | parse using the "best" type based on the input |


```r
# omitted values are guessed
# ?col_date for format options
ct <- list(
  junk = "-", # skip this column
  order = "i",
  good = "l",
  date = col_date(format = "%Y-%m-%d")
)

tidier <- read_csv("data/mess.csv", 
                   skip = 2,
                   col_types = ct)
```

You will get a message about "1 parsing failure" when you run this. Warnings look scary at first, but always start by reading the message. The table tells you what row (`2`) and column (`order`) the error was found in, what kind of data was expected (`integer`), and what the actual value was (<code><span class='st'>"missing"</span></code>). If you specifically tell <code><span class='fu'>read_csv</span><span class='op'>(</span><span class='op'>)</span></code> to import a column as an integer, any characters in the column will produce a warning like this and then be recorded as `NA`. You can manually set what the missing values were recorded as with the `na` argument.


```r
tidiest <- read_csv("data/mess.csv", 
                   skip = 2,
                   na = "missing",
                   col_types = ct)
```


Now `order` is an integer where "missing" is now `NA`, `good` is a logical value, where <code><span class='fl'>0</span></code> and <code><span class='cn'>F</span></code> are converted to <code><span class='cn'>FALSE</span></code> and <code><span class='fl'>1</span></code> and <code><span class='cn'>T</span></code> are converted to <code><span class='cn'>TRUE</span></code>, and `date` is a date type (adding leading zeros to the day). We'll learn in later chapters how to fix other problems, such as the `min_max` column containing two different types of data.


```r
tidiest
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> order </th>
   <th style="text-align:left;"> score </th>
   <th style="text-align:left;"> letter </th>
   <th style="text-align:left;"> good </th>
   <th style="text-align:left;"> min_max </th>
   <th style="text-align:left;"> date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> -1 </td>
   <td style="text-align:left;"> a </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 1 - 2 </td>
   <td style="text-align:left;"> 2020-01-01 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> 0.72 </td>
   <td style="text-align:left;"> b </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 2 - 3 </td>
   <td style="text-align:left;"> 2020-01-02 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> -0.62 </td>
   <td style="text-align:left;"> c </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 3 - 4 </td>
   <td style="text-align:left;"> 2020-01-03 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> 2.03 </td>
   <td style="text-align:left;"> d </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 4 - 5 </td>
   <td style="text-align:left;"> 2020-01-04 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> e </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 5 - 6 </td>
   <td style="text-align:left;"> 2020-01-05 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> 0.99 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 6 - 7 </td>
   <td style="text-align:left;"> 2020-01-06 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> 0.03 </td>
   <td style="text-align:left;"> g </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 7 - 8 </td>
   <td style="text-align:left;"> 2020-01-07 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> 0.67 </td>
   <td style="text-align:left;"> h </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 8 - 9 </td>
   <td style="text-align:left;"> 2020-01-08 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> 0.57 </td>
   <td style="text-align:left;"> i </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 9 - 10 </td>
   <td style="text-align:left;"> 2020-01-09 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> 0.9 </td>
   <td style="text-align:left;"> j </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 10 - 11 </td>
   <td style="text-align:left;"> 2020-01-10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> -1.55 </td>
   <td style="text-align:left;"> k </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 11 - 12 </td>
   <td style="text-align:left;"> 2020-01-11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> l </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 12 - 13 </td>
   <td style="text-align:left;"> 2020-01-12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> 0.15 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 13 - 14 </td>
   <td style="text-align:left;"> 2020-01-13 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:left;"> -0.66 </td>
   <td style="text-align:left;"> n </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 14 - 15 </td>
   <td style="text-align:left;"> 2020-01-14 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:left;"> -0.99 </td>
   <td style="text-align:left;"> o </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 15 - 16 </td>
   <td style="text-align:left;"> 2020-01-15 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> 1.97 </td>
   <td style="text-align:left;"> p </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 16 - 17 </td>
   <td style="text-align:left;"> 2020-01-16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:left;"> -0.44 </td>
   <td style="text-align:left;"> q </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 17 - 18 </td>
   <td style="text-align:left;"> 2020-01-17 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> -0.9 </td>
   <td style="text-align:left;"> r </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 18 - 19 </td>
   <td style="text-align:left;"> 2020-01-18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> -0.15 </td>
   <td style="text-align:left;"> s </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 19 - 20 </td>
   <td style="text-align:left;"> 2020-01-19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> -0.83 </td>
   <td style="text-align:left;"> t </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 20 - 21 </td>
   <td style="text-align:left;"> 2020-01-20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> 1.99 </td>
   <td style="text-align:left;"> u </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 21 - 22 </td>
   <td style="text-align:left;"> 2020-01-21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> 0.04 </td>
   <td style="text-align:left;"> v </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 22 - 23 </td>
   <td style="text-align:left;"> 2020-01-22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> -0.4 </td>
   <td style="text-align:left;"> w </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 23 - 24 </td>
   <td style="text-align:left;"> 2020-01-23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:left;"> -0.47 </td>
   <td style="text-align:left;"> x </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 24 - 25 </td>
   <td style="text-align:left;"> 2020-01-24 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> -0.41 </td>
   <td style="text-align:left;"> y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> 25 - 26 </td>
   <td style="text-align:left;"> 2020-01-25 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;"> 0.68 </td>
   <td style="text-align:left;"> z </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> 26 - 27 </td>
   <td style="text-align:left;"> 2020-01-26 </td>
  </tr>
</tbody>
</table>

</div>

## Data Relations

First, we'll create two small data tables. 

`customer` has id, gender and age for customers 1-5. Age and gender are missing for customer 3.


```r
customers <- tibble(
  id = 1:5,
  gender = c("m", "m", NA, "nb", "f"),
  age = c(19, 22, NA, 19, 18)
)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>



`orders` has customer id and the number of items ordered. Some customers have no orders, some have more than one order, and some are not in the customer table.


```r
orders <- tibble(
  id = c(2, 3, 4, 4, 5, 5, 6, 6, 7),
  items = c(10, 18, 21, 23, 9, 11, 11, 12, 3)
)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>




### Mutating Joins

<a class='glossary' target='_blank' title='Joins that act like the dplyr::mutate() function in that they add new columns to one table based on values in another table.' href='https://psyteachr.github.io/glossary/m#mutating-joins'>Mutating joins</a> act like the <code><span class='fu'>dplyr</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span><span class='op'>(</span><span class='op'>)</span></code> function in that they add new columns to one table based on values in another table.  

All the mutating joins have this basic syntax:

`****_join(x, y, by = NULL, suffix = c(".x", ".y")`

* `x` = the first (left) table
* `y` = the second (right) table
* `by` = what columns to match on. If you leave this blank, it will match on all columns with the same names in the two tables.
* `suffix` = if columns have the same name in the two tables, but you aren't joining by them, they get a suffix to make them unambiguous. This defaults to ".x" and ".y", but you can change it to something more meaningful.

::: {.info data-latex=""}
You can leave out the `by` argument if you're matching on all of the columns with the same name, but it's good practice to always specify it so your code is robust to changes in the loaded data.
:::

#### left_join() {#left_join}

<div class="join"><img src="images/joins/left_join.png" /></div>

A `left_join` keeps all the data from the first (left) table and joins anything that matches from the second (right) table. If the right table has more than one match for a row in the right table, there will be more than one row in the joined table (see ids 4 and 5).


```r
left_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>

<div class="join"><img src="images/joins/left_join_rev.png" /></div>

The order of tables is swapped here, so the result is all rows from the `orders` table joined to any matching rows from the `customers` table.


```r
left_join(orders, customers, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> items </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

</div>

#### right_join() {#right_join}

<div class="join"><img src="images/joins/right_join.png" /></div>

A `right_join` keeps all the data from the second (right) table and joins anything that matches from the first (left) table. 


```r
right_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>

::: {.info data-latex=""}
This table has the same information as `left_join(orders, customers, by = "id")`, but the columns are in a different order (left table, then right table).
:::

#### inner_join() {#inner_join}

<div class="join"><img src="images/joins/inner_join.png" /></div>

An `inner_join` returns all the rows that have a match in the other table.


```r
inner_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>


#### full_join() {#full_join}

<div class="join"><img src="images/joins/full_join.png" /></div>

A `full_join` lets you join up rows in two tables while keeping all of the information from both tables. If a row doesn't have a match in the other table, the other table's column values are set to `NA`.


```r
full_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>


### Filtering Joins

<a class='glossary' target='_blank' title='Joins that act like the dplyr::filter() function in that they remove rows from the data in one table based on the values in another table.' href='https://psyteachr.github.io/glossary/f#filtering-joins'>Filtering joins</a> act like the `filter()` function in that they remove rows from the data in one table based on the values in another table. The result of a filtering join will only contain rows from the left table and have the same number or fewer rows than the left table. 

#### semi_join() {#semi_join}

<div class="join"><img src="images/joins/semi_join.png" /></div>

A `semi_join` returns all rows from the left table where there are matching values in the right table, keeping just columns from the left table.


```r
semi_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>

::: {.info data-latex=""}
Unlike an inner join, a semi join will never duplicate the rows in the left table if there is more than one matching row in the right table.
:::

<div class="join"><img src="images/joins/semi_join_rev.png" /></div>

Order matters in a semi join.


```r
semi_join(orders, customers, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 21 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
</tbody>
</table>

</div>

#### anti_join() {#anti_join}

<div class="join"><img src="images/joins/anti_join.png" /></div>

An `anti_join` return all rows from the left table where there are *not* matching values in the right table, keeping just columns from the left table.


```r
anti_join(customers, orders, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

<div class="join"><img src="images/joins/anti_join_rev.png" /></div>

Order matters in an anti join.


```r
anti_join(orders, customers, by = "id")
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> items </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
</tbody>
</table>

</div>

### Binding Joins

<a class='glossary' target='_blank' title='Joins that bind one table to another by adding their rows or columns together.' href='https://psyteachr.github.io/glossary/b#binding-joins'>Binding joins</a> bind one table to another by adding their rows or columns together.

#### bind_rows() {#bind_rows}

You can combine the rows of two tables with `bind_rows`.

Here we'll add customer data for customers 6-9 and bind that to the original customer table.


```r
new_customers <- tibble(
  id = 6:9,
  gender = c("nb", "m", "f", "f"),
  age = c(19, 16, 20, 19)
)

bind_rows(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

The columns just have to have the same names, they don't have to be in the same order. Any columns that differ between the two tables will just have `NA` values for entries from the other table.

If a row is duplicated between the two tables (like id 5 below), the row will also be duplicated in the resulting table. If your tables have the exact same columns, you can use `union()` (see below) to avoid duplicates.


```r
new_customers <- tibble(
  id = 5:9,
  age = c(18, 19, 16, 20, 19),
  gender = c("f", "nb", "m", "f", "f"),
  new = c(1,2,3,4,5)
)

bind_rows(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:right;"> new </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>

</div>

#### bind_cols() {#bind_cols}

You can merge two tables with the same number of rows using `bind_cols`. This is only useful if the two tables have their rows in the exact same order. The only advantage over a left join is when the tables don't have any IDs to join by and you have to rely solely on their order.


```r
new_info <- tibble(
  colour = c("red", "orange", "yellow", "green", "blue")
)

bind_cols(customers, new_info)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> colour </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> red </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:left;"> orange </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:left;"> yellow </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> green </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:left;"> blue </td>
  </tr>
</tbody>
</table>

</div>

### Set Operations

<a class='glossary' target='_blank' title='Functions that compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff).' href='https://psyteachr.github.io/glossary/s#set-operations'>Set operations</a> compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff).

#### intersect() {#intersect}

`intersect()` returns all rows in two tables that match exactly. The columns don't have to be in the same order.


```r
new_customers <- tibble(
  id = seq(4, 9),
  age = c(19, 18, 19, 16, 20, 19),
  gender = c("f", "f", "m", "m", "f", "f")
)

intersect(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has an `intersect()` function. The error message can be confusing and looks something like this:


```r
base::intersect(customers, new_customers)
```

```
## Error: Must subset rows with a valid subscript vector.
## ℹ Logical subscripts must match the size of the indexed input.
## x Input has size 6 but subscript `!duplicated(x, fromLast = fromLast, ...)` has size 0.
```
:::

#### union() {#union}

`union()` returns all the rows from both tables, removing duplicate rows.


```r
union(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 16 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>


::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has a `union()` function. You usually won't get an error message, but the output won't be what you expect.


```r
base::union(customers, new_customers)
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "m"  "m"  NA   "nb" "f" 
## 
## [[3]]
## [1] 19 22 NA 19 18
## 
## [[4]]
## [1] 4 5 6 7 8 9
## 
## [[5]]
## [1] 19 18 19 16 20 19
## 
## [[6]]
## [1] "f" "f" "m" "m" "f" "f"
```
:::

#### setdiff() {#setdiff}

`setdiff` returns rows that are in the first table, but not in the second table.


```r
setdiff(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
</tbody>
</table>

</div>

Order matters for `setdiff`.


```r
setdiff(new_customers, customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> f </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> m </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:left;"> m </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:left;"> f </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:left;"> f </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you've forgotten to load dplyr or the tidyverse, <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> also has a `setdiff()` function. You usually won't get an error message, but the output might not be what you expect because the base R `setdiff()` expects columns to be in the same order, so id 5 here registers as different between the two tables.


```r
base::setdiff(customers, new_customers)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> id </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:right;"> age </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> m </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:left;"> nb </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:left;"> f </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
</tbody>
</table>

</div>
:::


## Glossary {#glossary-data}

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [argument](https://psyteachr.github.io/glossary/a.html#argument){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A variable that provides input to a function. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [base r](https://psyteachr.github.io/glossary/b.html#base-r){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The set of R functions that come with a basic installation of R, before you add external packages </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [binding joins](https://psyteachr.github.io/glossary/b.html#binding-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that bind one table to another by adding their rows or columns together. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [character](https://psyteachr.github.io/glossary/c.html#character){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing strings of text. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [console](https://psyteachr.github.io/glossary/c.html#console){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The pane in RStudio where you can type in commands and view output messages. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [data type](https://psyteachr.github.io/glossary/d.html#data-type){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The kind of data represented by an object. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [extension](https://psyteachr.github.io/glossary/e.html#extension){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The end part of a file name that tells you what type of file it is (e.g., .R or .Rmd). </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [filtering joins](https://psyteachr.github.io/glossary/f.html#filtering-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that act like the dplyr::filter() function in that they remove rows from the data in one table based on the values in another table. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [global environment](https://psyteachr.github.io/glossary/g.html#global-environment){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The interactive workspace where your script runs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [mutating joins](https://psyteachr.github.io/glossary/m.html#mutating-joins){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Joins that act like the dplyr::mutate() function in that they add new columns to one table based on values in another table. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [package](https://psyteachr.github.io/glossary/p.html#package){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A group of R functions. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [panes](https://psyteachr.github.io/glossary/p.html#panes){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> RStudio is arranged with four window "panes". </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [set operations](https://psyteachr.github.io/glossary/s.html#set-operations){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Functions that compare two tables and return rows that match (intersect), are in either table (union), or are in one table but not the other (setdiff). </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [tabular data](https://psyteachr.github.io/glossary/t.html#tabular-data){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Data in a rectangular table format, where each row has an entry for each column. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [tidyverse](https://psyteachr.github.io/glossary/t.html#tidyverse){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A set of R packages that help you create and work with tidy data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [vector](https://psyteachr.github.io/glossary/v.html#vector){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A type of data structure that collects values with the same data type, like T/F values, numbers, or strings. </td>
  </tr>
</tbody>
</table>



## Further resources {#resources-data}

* [Data import cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-import.pdf)
* [Data transformation heatsheet](https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf)
* [Chapter 11: Data Import](http://r4ds.had.co.nz/data-import.html) in *R for Data Science*
* [Chapter 13: Relational Data](http://r4ds.had.co.nz/relational-data.html) in *R for Data Science*

## Exercises {#exercises-data}












