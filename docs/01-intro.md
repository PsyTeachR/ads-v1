



# Intro to R and RStudio {#intro}

## Intended Learning Outcomes {#ilo-intro}

* Install R and RStudio
* Be able to install add-on packages
* Be able to get help for packages and functions
* Be able to create objects by writing and running code in the console

## Walkthrough video

There is a walkthrough video of this chapter available via Echo360. We recommend first trying to work through each section of the book on your own and then watching the video if you get stuck, or if you would like more information. This will feel slower than just starting with the video, but you will learn more in the long-run. 

## R and RStudio {#intro-r-rstudio}

R is a programming language that you will write code in and RStudio is an Integrated Development Environment (<a class='glossary' target='_blank' title='Integrated Development Environment: a program that serves as a text editor, file manager, and provides functions to help you read and write code. RStudio is an IDE for R.' href='https://psyteachr.github.io/glossary/i#ide'>IDE</a>) which makes working in  R easier. Think of it as knowing English and using a plain text editor like NotePad to write a book versus using a word processor like Microsoft Word. You could do it, but it would be much harder without things like spell-checking and formatting and you wouldn't be able to use some of the advanced features that Word has developed. In a similar way, you can use R without R Studio but we wouldn't recommend it. RStudio serves as a text editor, file manager, spreadsheet viewer, and more. The key thing to remember is that although you will do all of your work using RStudio for this course, you are actually using two pieces of software which means that from time-to-time, both of them may have separate updates.

## Installing R and RStudio {#intro-installing-r}

Appendix\ \@ref(installing-r) has technical details on installing R and RStudio on your computer. If you need any help installing R, please ask on Teams or attend office hours. Once you have installed R and RStudio come back to this chapter. If you already had R and/or RStudio installed, we recommend updating to the latest version before you work through this course. Appendix\ \@ref(appendix-updating-r) has more details on how to do that. Here, we'll concentrate on introducing you to RStudio's interface and getting it configured.

### RStudio {#rstudio_ide}

When you installed R, that gave your computer the ability to process the R programming language, and also installed an app called "R". We will never use that app. Instead, we will use [RStudio](http://www.rstudio.com){target="_blank"}.  RStudio is arranged with four window <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>panes</a>.

<div class="figure" style="text-align: center">
<img src="images/intro/rstudio.png" alt="The RStudio IDE" width="100%" />
<p class="caption">(\#fig:img-rstudio)The RStudio IDE</p>
</div>

By default, the upper left pane is the **source pane**, where you view, write, and edit code from files and view data tables in a spreadsheet format. When you first open RStudio, this pane won't display until we open a document or load in some data - don't worry, we'll get to that soon.

The lower left pane is the **console pane**, where you can type in commands and view output messages. You can write code in the console to test it out. The code will run and can create objects in the environment, but the code itself won't be saved. You need to write your code into a script in the source pane to save it.

The right panes have several different tabs that show you information about your code. The most used tabs in the upper right pane are the **Environment** tab and the **Help** tab. The environment tab lists some information about the <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/o#object'>objects</a> that you have defined in your code. We'll learn more about the Help tab in Section\ \@ref(function-help). 

In the lower right pane, the most used tabs are the **Files** tab for directory structure, the **Plots** tab for plots made in a script, the **Packages** tab for managing add-on packages (see Section\ \@ref(packages)), and the **Viewer** tab to display reports created by your scripts. You can change the location of panes and what tabs are shown under **`Preferences > Pane Layout`**.

### Reproducibility {#intro-reproducibility}

In this class, you will be learning how to make <a class='glossary' target='_blank' title='The extent to which the findings of a study can be repeated in some other context' href='https://psyteachr.github.io/glossary/r#reproducibility'>reproducible</a> reports. This involves writing scripts that transform data, create summaries and visualisations, and embed them in a report in a way that always gives you the same results.

When you do things reproducibly, others (and future you) can understand and check your work. You can also reuse your work more easily. For example, if you need to create a report every month with the social media analytics for your company, a reproducible report allows you to download a new month's data and create the report within seconds. It might take a little longer to set up the report in the first instance with reproducible methods, but the time it saves you in the long run is invaluable.

::: {.try data-latex=""}
Appendix\ \@ref(rstudio-settings) shows you how to change two important settings in the global Options to increase reproducibility. Your settings should have:

* Restore .RData into workspace at startup: <select class='webex-select'><option value='blank'></option><option value=''>Checked</option><option value='answer'>Not Checked</option></select>
* Save workspace to .RData on exit: <select class='webex-select'><option value='blank'></option><option value=''>Always</option><option value='answer'>Never</option><option value=''>Ask</option></select>
:::

### Themes and accessiblilty

You can customise how R Studio looks to make it work for you. Click `Tools` - `Global Options` - `Appearance`. You can change the default font, font size, and general appearance of R Studio, including using dark mode. Play around with the settings and see what you prefer - you're going to spend a lot of time with R, it might as well look nice!


## Sessions {#intro-sessions}

If you have the above settings configured correctly, when you open up RStudio and start writing code, loading packages, and creating objects, you will be doing so in a new session and your Environment tab should be completely empty. If you find that your code isn't working and you can't figure out why, it might be worth restarting your R session. This will clear the environment and detach all loaded packages - think of it like restarting your phone. There are several ways that you can restart R:

* Menu: Session > Restart R
* <span class=\"apple\">Cmd-Shift-F10</span> or <span class=\"windows\">Ctl-Shift-F10</span>
* type `.rs.restartR()` in the console

Try doing each of these now. Additionally, now would be a good time to create a notebook where you can keep a record of useful hints and tips and things to try when your code isn't working. Add "restart R session" to this notebook as your first item. 

## Packages and functions {#packages}

When you install R you will have access to a range of <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>functions</a> including options for <a class='glossary' target='_blank' title='The process of preparing data for visualisation and statistical analysis.' href='https://psyteachr.github.io/glossary/d#data-wrangling'>data wrangling</a> and statistical analysis. The functions that are included in the default installation are typically referred to as <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> and you can think of them like the default apps that come pre-loaded on your phone. 

One of the great things about R, however, is that it is **user extensible**: anyone can create a new add-on that extends its functionality. There are currently thousands of <a class='glossary' target='_blank' title='A group of R functions.' href='https://psyteachr.github.io/glossary/p#package'>packages</a> that R users have created to solve many different kinds of problems, or just simply to have fun. For example, there are packages for data visualisation, machine learning, interactive dashboards, web scraping, and playing games such as Sudoku.

Add-on packages are not distributed with base R, but have to be downloaded and installed from an archive, in the same way that you would, for instance, download and install PokemonGo on your smartphone. The main repository where packages reside is called <a class='glossary' target='_blank' title='The Comprehensive R Archive Network: a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R.' href='https://psyteachr.github.io/glossary/c#cran'>CRAN</a>, the Comprehensive R Archive Network.

There is an important distinction between **installing** a package and **loading** a package.

### Installing a package {#install-package}

<!--
<div class="small_right"><img src="images/memes/pokemon.gif" /></div>
-->

This is done using <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='op'>(</span><span class='op'>)</span></code>. This is like installing an app on your phone: you only have to do it once and the app will remain installed until you remove it. For instance, if you want to use PokemonGo on your phone, you install it once from the App Store or Play Store; you don't have to re-install it each time you want to use it. Once you launch the app, it will run in the background until you close it or restart your phone. Likewise, when you install a package, the package will be available (but not *loaded*) every time you open up R.

Install the <code class='package'>esquisse</code> package on your system. This package lets you create plots interactively and copy the code needed to make them reproducibly.


```r
# type this in the console pane
install.packages("esquisse")
```

If you don't already have packages like <code class='package'>ggplot2</code> and <code class='package'>shiny</code> installed, it will also install these **dependencies** for you. If you get a message that says something like `package ‘esquisse’ successfully unpacked and MD5 sums checked`, the installation was successful. 

::: {.dangerous data-latex=""}
Never install a package from inside a script. Only do this from the console pane.
:::

You can also install multiple packages at once. Here is the command to install all of the packages we'll be using in this class. This will take a while, so don't try this in the middle of a tutorial!


```r
install.packages(c(
  "tidyverse",      # for everything
  "rio",            # for data import
  "kableExtra",     # for nice tables
  "devtools",       # for installing extra packages
  "ggwordcloud",    # for word clouds
  "tidytext",       # for parsing text for word clouds
  "patchwork",      # for multi-part plots
  "ggthemes",       # for themed plots
  "glue",           # for text manipulation
  "flexdashboard",  # for dashboard presentations
  "treemap",        # for treemap plots
  "sf",             # for mapping geoms
  "rnaturalearth",  # for map data
  "rnatrualearthdata" # extra mapping data
))

# install waffle package 

devtools::install_github("hrbrmstr/waffle")
```

### Loading a package

This is done using <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'>package_name</span><span class='op'>)</span></code>. This is like **launching** an app on your phone: the functionality is only there where the app is launched and remains there until you close the app or restart. For example, when you run <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'><a target='_blank' href='https://github.com/tidyverse/glue'>glue</a></span><span class='op'>)</span></code> within a session, the functions in the package referred to by `glue` will be made available for your R session. The next time you start R, you will need to run <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'><a target='_blank' href='https://github.com/tidyverse/glue'>glue</a></span><span class='op'>)</span></code> again if you want to access that package.

You can load the <code class='package'>esquisse</code> package for your current R session as follows:


```r
library(esquisse)
```

You might get some red text when you load a package, this is normal. It is usually warning you that this package has functions that have the same name as other packages you've already loaded.

::: {.info data-latex=""}
You can use the convention `package::function()` to indicate in which add-on package a function resides. For instance, if you see <code><span class='fu'>readr</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://readr.tidyverse.org/reference/read_delim.html'>read_csv</a></span><span class='op'>(</span><span class='op'>)</span></code>, that refers to the function <code><span class='fu'>read_csv</span><span class='op'>(</span><span class='op'>)</span></code> in the <code class='package'>readr</code> add-on package. If the package is loaded using `library()`, you don't have to specify the package name before a function unless there is a conflict (e.g., you have two packages loaded that have a function with the same name).
:::

### Using a function

Now you can run the function <code><span class='fu'>esquisser</span><span class='op'>(</span><span class='op'>)</span></code>, which starts up an interactive plotting example.


```r
# type this in the console pane and press enter
esquisser(data = ggplot2::diamonds)
```

::: {.warning data-latex=""}
If you see the error message: `Error in esquisser(data = ggplot2::diamonds) : could not find function "esquisser"`, that just means that you forgot to load the <code class='package'>esquisse</code> package using `library(esquisse)`. Either run the code to load the package first, or preface the function with the package name like `esquisse::esquisser()` to use it without loading the package.
:::

A <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> is a name that refers to some code you can reuse. We'll start by using functions that are provided for you in packages, but you can also write your own functions. After the function name, there is a pair of parentheses, which contain zero or more <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>arguments</a>. These are options that you can set. In the example above, the `data` argument is set to `ggplot2::diamonds`, which refers to a built-in dataset `diamonds` from the <code class='package'>ggplot2</code> package.

If you type a function into the console pane, it will run as soon as you hit enter. If you put the function in a <a class='glossary' target='_blank' title='A plain-text file that contains commands in a coding language, such as R.' href='https://psyteachr.github.io/glossary/s#script'>script</a> or <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> document in the <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>source pane</a>, it won't run until you run the script, <a class='glossary' target='_blank' title='To create an HTML, PDF, or Word document from an R Markdown (Rmd) document' href='https://psyteachr.github.io/glossary/k#knit'>knit</a> the R Markdown file, or run a code <a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>chunk</a>. You'll learn more about this in Chapter\ \@ref(reports).

### Tidyverse

<code class='package'>tidyverse</code>is a meta-package that loads several packages we'll be using in almost every chapter in this book:

- <code class='package'>ggplot2</code>, for data visualisation (Chapter\ \@ref(viz))
- <code class='package'>readr</code>, for data import (Chapter\ \@ref(data))
- <code class='package'>tibble</code>, for tables (Chapter\ \@ref(data))
- <code class='package'>tidyr</code>, for data tidying (Chapter\ \@ref(tidy))
- <code class='package'>dplyr</code>, for data manipulation (Chapter\ \@ref(wrangle))
- <code class='package'>stringr</code>, for <a class='glossary' target='_blank' title='A piece of text inside of quotes.' href='https://psyteachr.github.io/glossary/s#string'>strings</a>
- <code class='package'>forcats</code>, for <a class='glossary' target='_blank' title='A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter' href='https://psyteachr.github.io/glossary/f#factor'>factors</a>
- <code class='package'>purrr</code>, for repeating things

When you install <code class='package'>tidyverse</code>, it also installs some other useful packages that you can load individually. You can get the full list using `tidyverse_packages()`, but the packages we'll be using in this book are:

- <code class='package'>googlesheets4</code>, for working with Google spreadsheets
- <code class='package'>readxl</code>, for Excel files
- <code class='package'>lubridate</code>, for working with dates
- <code class='package'>hms</code>, for working with times
- <code class='package'>rvest</code>, for web scraping

### Function Help

When you load the <code class='package'>tidyverse</code> it automatically loads all of the above packages, however, it can be helpful to know which package a function comes from if you need to Google it. If a <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> is in <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> or a loaded package, you can type `?function_name` in the console to access the help file. At the top of the help it will give you the function and package name. 

If the package isn't loaded, use `?package_name::function_name` or specify the package in the `help()` function. When you aren't sure what package the function is in, use the shortcut `??function_name`.


```r
# if the package is loaded
?esquisser
help("esquisser")

# works whether or not the package is loaded
?esquisse::esquisser
help("esquisser", package="esquisse") 

# shows a list of potentially matching functions
??esquisser
```

<div class="small_right" style="width: 50%; max-width: 400px;"><img src="images/intro/function_help.png" /></div>

Function help is always organised in the same way. For example, look at the help for `?glue::trim`. At the top, it tells you the name of the function and its package in curly brackets, then a short description of the function, followed by a longer description. The **Usage** section shows the function with all of its <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>arguments</a>. If any of those arguments have default values, they will be shown like `function(arg = default)`. The **Arguments** section lists each argument with an explanation. There may be a **Details** section after this with even more detail about the functions. The **Examples** section is last, and shows examples that you can run in your console window to see how the function works.


::: {.try data-latex=""}

* What is the first argument to the `mean` function? <select class='webex-select'><option value='blank'></option><option value=''>trim</option><option value=''>na.rm</option><option value=''>mean</option><option value='answer'>x</option></select>
* What package is `read_excel` in? <select class='webex-select'><option value='blank'></option><option value=''>readr</option><option value='answer'>readxl</option><option value=''>base</option><option value=''>stats</option></select>
:::




### Arguments

You can look up the arguments/options that a function has by using the help documentation. Some arguments are required, and some are optional. Optional arguments will often use a default (normally specified in the help documentation) if you do not enter any value.

As an example, look at the help documentation for the function `sample()` which randomly samples items from a list. 


```r
?sample
```

The help documentation for `sample()` should appear in the bottom right help panel. In the usage section, we see that `sample()` takes the following form:


```r
sample(x, size, replace = FALSE, prob = NULL)
```

In the arguments section, there are explanations for each of the arguments. `x` is the list of items we want to choose from, `size` is the number of items we want to choose, `replace` is whether or not each item may be selected more than once, and `prob` gives the probability that each item is chosen. In the details section it notes that if no values are entered for `replace` or `prob` it will use defaults of `FALSE` (each item can only be chosen once) and `NULL` (all items will have equal probability of being chosen). Because there is no default value for `x` or `size`, they must be specified otherwise the code won't run.

Let's try an example and just change the required arguments to `x` and `size` to ask R to choose 5 random letters (`letters` is a built-in <a class='glossary' target='_blank' title='A type of data structure that collects values with the same data type, like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vector</a> of the 26 lower-case Latin letters). 




```r
sample(x = letters, size = 5)
```

```
## [1] "z" "v" "y" "w" "j"
```


<div class='webex-solution'><button>Why are my letters different to your letters?</button>


`sample()` generates a random sample. Each time you run the code, you'll generate a different set of random letters (try it). The function `set.seed()` controls the random number generator - if you're using any functions that use randomness (such as `sample()`), running `set.seed()` will ensure that you get the same result (in many cases this may not be what you want to do). To get the same numbers we do, run `set.seed(1242016)` in the console, and then run `sample(x = letters, size = 5)` again.


</div>


Now we can change the default value for the `replace` argument to produce a set of letters that is allowed to have duplicates.


```r
set.seed(8675309)
sample(x = letters, size = 5, replace = TRUE)
```

```
## [1] "t" "k" "j" "k" "m"
```

This time R has still produced 5 random letters, but now this set of letters has two instances of "k". Always remember to use the help documentation to help you understand what arguments a function requires.

### Argument names

In the above examples, we have written out the argument names in our code (i.e., `x`, `size`, `replace`), however, this is not strictly necessary. The following two lines of code would both produce the same result (although each time you run `sample()` it will produce a slightly different result, because it's random, but they would still work the same):


```r
sample(x = letters, size = 5, replace = TRUE)
sample(letters, 5, TRUE)
```

Importantly, if you do not write out the argument names, R will use the default order of arguments. That is for `sample` it will assume that the first value you enter is `x`. the second value is `size` and the third value is `replace`. 

If you write out the argument names then you can write the arguments in whatever order you like:


```r
sample(size = 5, replace = TRUE, x = letters)
```

When you are first learning R, you may find it useful to write out the argument names as it can help you remember and understand what each part of the function is doing. However, as your skills progress you may find it quicker to omit the argument names and you will also see examples of code online that do not use argument names, so it is important to be able to understand which argument each bit of code is referring to (or look up the help documentation to check).

In this course, we will always write out the argument names the first time we use each function. However, in subsequent uses they may be omitted.

### Tab auto-complete

One very useful feature of R Studio is  tab auto-complete for functions (see Figure \@ref(fig:img-autocomplete)). If you write the name of the function and then press the tab key, R Studio will show you the arguments that function takes along with a brief description. If you press enter on the argument name it will fill in the name for you, just like auto-complete on your phone. This is incredibly useful when you are first learning R and you should remember to use this feature frequently. 

<div class="figure" style="text-align: center">
<img src="images/intro/autocomplete.png" alt="Tab auto-complete" width="100%" />
<p class="caption">(\#fig:img-autocomplete)Tab auto-complete</p>
</div>

## Objects

A large part of your coding will involve creating and manipulating objects. Objects contain stuff. That stuff can be numbers, words, or the result of operations and analyses. You assign content to an object using `<-`.

Run the following code in the console, but change the values of `name` and `age` to your own details and change `christmas` to a holiday or date you care about.


```r
name <- "Emily"
age <- 36
today <- Sys.Date()
christmas <- as.Date("2022-12-25")
```

You'll see that four objects now appear in the environment pane:

* `name` is <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a> (text) data. In order for R to recognise it as character data, it **must** be enclosed in double quotation marks `" "`.
* `age` is <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a> data. In order for R to recognise this as a number, it **must not** be enclosed in quotation marks.
* `today` stores the result of the function `Sys.Date()`. This function returns your computer system's date. Unlike `name` and `age`, which are hard-coded (i.e., they will always return the values you enter), the contents of the object `today` will change dynamically with the date. That is, if you run that function tomorrow, it will update the date to tomorrow's date.
* `christmas` is also a date but it's hard-coded as a very specific date. It's wrapped within the `as.Date()` function that tells R to interpret the character string you provide as date rather than text.

::: {.try data-latex=""}

To print the contents of an object, type the object's name in the console and press enter. Try printing all four objects now.

:::

Finally, a key concept to understand is that objects can interact and you can save the results of those interactions in new object. Edit and run the following code to create these new objects, and then print the contents of each new object. 


```r
decade <- age + 10
full_name <- paste(name, "Nordmann")
how_long <- christmas - today
```


## Getting help {#help}

You will feel like you need a *lot* of help when you're starting to learn. This won't really go away; it's impossible to memorise everything. The goal is to learn enough about the structure of R that you can look things up quickly. This is why we'll introduce specialised jargon in the glossary for each chapter; it's easier to google "convert <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a> to <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a> in R" than "make numbers in quotes be actual numbers not words". In addition to the function help described above, here's some additional resources you should use often.

### Package reference manuals

Start up help in a browser by entering `help.start()` in the console. Click on "Packages" under "Reference" to see a list of packages. Scroll down to the `readxl` package and click on it to see a list of the functions that are available in that package. 


### Googling

If the function help doesn't help, or you're not even sure what function you need, try Googling your question. It will take some practice to be able to use the right jargon in your search terms to get what you want. It helps to put "R" or "tidyverse" in the search text, or the name of the relevant package, like <code class='package'>ggplot2</code>. 

### Vignettes

Many packages, especially [tidyverse](https://www.tidyverse.org/packages/){target="_blank"} ones, have helpful websites with vignettes explaining how to use their functions. Some of the vignettes are also available inside R. You can access them from a package's help page or with the `vignette()` function.


```r
# opens a list of available vignettes
vignette(package = "ggplot2")

# opens a specific vignette in the Help pane
vignette("ggplot2-specs", package = "ggplot2")
```


## Glossary {#glossary-intro}

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
   <td style="text-align:left;"> [character](https://psyteachr.github.io/glossary/c.html#character){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing strings of text. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [chunk](https://psyteachr.github.io/glossary/c.html#chunk){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A section of code in an R Markdown file </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [cran](https://psyteachr.github.io/glossary/c.html#cran){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The Comprehensive R Archive Network: a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [data wrangling](https://psyteachr.github.io/glossary/d.html#data-wrangling){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The process of preparing data for visualisation and statistical analysis. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [factor](https://psyteachr.github.io/glossary/f.html#factor){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type where a specific set of values are stored with labels; An explanatory variable manipulated by the experimenter </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [function](https://psyteachr.github.io/glossary/f.html#function){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A named section of code that can be reused. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [ide](https://psyteachr.github.io/glossary/i.html#ide){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Integrated Development Environment: a program that serves as a text editor, file manager, and provides functions to help you read and write code. RStudio is an IDE for R. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [knit](https://psyteachr.github.io/glossary/k.html#knit){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> To create an HTML, PDF, or Word document from an R Markdown (Rmd) document </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [numeric](https://psyteachr.github.io/glossary/n.html#numeric){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing a real decimal number or integer. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [object](https://psyteachr.github.io/glossary/o.html#object){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A word that identifies and stores the value of some data for later use. </td>
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
   <td style="text-align:left;"> [r markdown](https://psyteachr.github.io/glossary/r.html#r-markdown){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [reproducibility](https://psyteachr.github.io/glossary/r.html#reproducibility){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The extent to which the findings of a study can be repeated in some other context </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [script](https://psyteachr.github.io/glossary/s.html#script){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A plain-text file that contains commands in a coding language, such as R. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [string](https://psyteachr.github.io/glossary/s.html#string){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A piece of text inside of quotes. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [vector](https://psyteachr.github.io/glossary/v.html#vector){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A type of data structure that collects values with the same data type, like T/F values, numbers, or strings. </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-intro}

* [RStudio IDE Cheatsheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf)
* [RStudio Cloud](https://rstudio.cloud/){target="_blank"}



