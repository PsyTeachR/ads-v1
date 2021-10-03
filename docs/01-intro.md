# Intro to R and RStudio {#intro}

## Intended Learning Outcomes {#ilo-intro}

* Install R and RStudio
* Be able to install add-on packages
* Be able to get help for packages and functions

## Installing R and RStudio {#intro-installing-r}

Appendix\ \@ref(installing-r) has technical details on installing R and RStudio on your computer. Here, we'll concentrate on introducing you to RStudio's interface and getting it configured.

### RStudio {#rstudio_ide}

When you installed R, that gave your computer the ability to process the R programming language, and also installed an app called "R". We will never use that app. Instead, we will use [RStudio](http://www.rstudio.com){target="_blank"}, which is an Integrated Development Environment (<a class='glossary' target='_blank' title='Integrated Development Environment: a program that serves as a text editor, file manager, and provides functions to help you read and write code. RStudio is an IDE for R.' href='https://psyteachr.github.io/glossary/i#ide'>IDE</a>): a program that serves as a text editor, file manager, spreadsheet viewer, and more. RStudio is arranged with four window <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>panes</a>.

<div class="figure" style="text-align: center">
<img src="images/intro/rstudio.png" alt="The RStudio IDE" width="100%" />
<p class="caption">(\#fig:img-rstudio)The RStudio IDE</p>
</div>

By default, the upper left pane is the **source pane**, where you view and edit source code from files and view data tables in a spreadsheet format. 

The lower left pane is the **console pane**, where you can type in commands and view output messages. 

The right panes have several different tabs that show you information about your code. The most common tabs in the upper right pane are the **Environment** tab and the **Help** tab. The environment tab lists some information about of the <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/o#object'>objects</a> that you have defined in your code. We'll learn more about the Help tab in Section\ \@ref(function-help). 

In the lower right pane, the most used tabs are the **Files** tab for directory structure, the **Plots** tab for plots made in a script, the **Packages** tab for managing add-on packages (see Section\ \@ref(packages)), and the **Viewer*** tab to display reports created by your scripts. You can change the location of panes and what tabs are shown under **`Preferences > Pane Layout`**.

### Reproducibility {#intro-reproducibility}

In this class, you will be learning how to make <a class='glossary' target='_blank' title='The extent to which the findings of a study can be repeated in some other context' href='https://psyteachr.github.io/glossary/r#reproducibility'>reproducible</a> reports. This involves writing scripts that transform data, create summaries and visualisations, and embed them in a report in a way that always gives you the same results.

When you do things reproducibly, others (and future you) can understand and check your work. You can also reuse your work more easily. For example, if you need to create a report every month with the social media analytics for your company, a reproducible report allows you to download a new month's data and create the report within seconds. It might take a little longer to set up the report in the first instance with reproducible methods, but the time it saves you in the long run is invaluable.

::: {.try data-latex=""}
Appendix\ \@ref(rstudio-settings) shows you how to change two important settings in the global Options to increase reproducibility. Your settings should have:

* Restore .RData into workspace at startup: <select class='webex-select'><option value='blank'></option><option value=''>Checked</option><option value='answer'>Not Checked</option></select>
* Save workspace to .RData on exit: <select class='webex-select'><option value='blank'></option><option value=''>Always</option><option value='answer'>Never</option><option value=''>Ask</option></select>
:::

When you open up RStudio or restart R, your Environment tab should be completely empty. If it is not, check the options above.

* How do you restart R? (there may be more than one right answer) <div class='webex-radiogroup' id='radio_ZNVHPILHMW'><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="x"></input> <span>Quit RStudio</span></label><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="answer"></input> <span>Menu: Session > Restart R</span></label><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="x"></input> <span>Click on the broom icon in the Environment tab</span></label><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="answer"></input> <span><span class="apple">Cmd-Shift-F10</span> or <span class="windows">Ctl-Shift-F10</span></span></label><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="answer"></input> <span>type `.rs.restartR()` in the console</span></label><label><input type="radio" autocomplete="off" name="radio_ZNVHPILHMW" value="x"></input> <span>type `q()` in the console</span></label></div>

## Add-on packages {#packages}

One of the great things about R is that it is **user extensible**: anyone can create a new add-on that extends its functionality. There are currently thousands of <a class='glossary' target='_blank' title='A group of R functions.' href='https://psyteachr.github.io/glossary/p#package'>packages</a> that R users have created to solve many different kinds of problems, or just simply to have fun. For example, there are packages for data visualisation, machine learning, interactive dashboards, web scraping, and playing games such as Sudoku.

Add-on packages are not distributed with <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a>, but have to be downloaded and installed from an archive, in the same way that you would, for instance, download and install PokemonGo on your smartphone. The main repository where packages reside is called <a class='glossary' target='_blank' title='The Comprehensive R Archive Network: a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R.' href='https://psyteachr.github.io/glossary/c#cran'>CRAN</a>, the Comprehensive R Archive Network.

There is an important distinction between **installing** a package and **loading** a package.

### Installing a package {#install-package}

<div class="small_right"><img src="images/memes/pokemon.gif" /></div>

This is done using <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='op'>(</span><span class='op'>)</span></code>. This is like installing an app on your phone: you only have to do it once and the app will remain installed until you remove it. For instance, if you want to use PokemonGo on your phone, you install it once from the App Store or Play Store; you don't have to re-install it each time you want to use it. Once you launch the app, it will run in the background until you close it or restart your phone. Likewise, when you install a package, the package will be available (but not *loaded*) every time you open up R.

Install the <code class='package'>esquisse</code> package on your system. This package lets you create plots interactively and copy the code needed to make them reproducibly.


```r
# type this in the console pane
install.packages("esquisse")
```

If you don't already have packages like <code class='package'>ggplot2</code> and <code class='package'>shiny</code> installed, it will also install these **dependencies** for you. If you don't get an error message at the end, the installation was successful. 

::: {.dangerous data-latex=""}
Never install a package from inside a script. Only do this from the console pane.
:::

You can also install multiple packages at once. Here is the command to install all of the packages we'll be using in this class. This will take a while, so don't try this in the middle of a tutorial!


```r
install.packages(
  "tidyverse",      # for everything
  "rio",            # for data import
  "kableExtra",     # for nice tables
  "ggwordcloud",    # for word clouds
  "tidytext",       # for parsing text for word clouds
  "patchwork",      # for multi-part plots
  "ggthemes",       # for themed plots
  "glue",           # for text manipulation
  "flexdashboard"   # for dashboard presentations
)
```

### Loading a package

This is done using <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'>package_name</span><span class='op'>)</span></code>. This is like **launching** an app on your phone: the functionality is only there where the app is launched and remains there until you close the app or restart. For example, when you run <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'><a target='_blank' href='https://github.com/tidyverse/glue'>glue</a></span><span class='op'>)</span></code> within a session, the functions in the package referred to by `glue` will be made available for your R session. The next time you start R, you will need to run <code><span class='kw'><a target='_blank' href='https://rdrr.io/r/base/library.html'>library</a></span><span class='op'>(</span><span class='va'><a target='_blank' href='https://github.com/tidyverse/glue'>glue</a></span><span class='op'>)</span></code> again if you want to access that package.

You can load the <code class='package'>esquisse</code> package for your current R session as follows:


```r
library(esquisse)
```

You might get some red text when you load a package, this is normal. It is usually warning you that this package has functions that have the same name as other packages you've already loaded.

::: {.info data-latex=""}
You can use the convention `package::function()` to indicate in which add-on package a function resides. For instance, if you see <code><span class='fu'>readr</span><span class='fu'>::</span><span class='fu'><a target='_blank' href='https://rdrr.io/pkg/readr/man/read_delim.html'>read_csv</a></span><span class='op'>(</span><span class='op'>)</span></code>, that refers to the function <code><span class='fu'>read_csv</span><span class='op'>(</span><span class='op'>)</span></code> in the <code class='package'>readr</code> add-on package. If the package is loaded using `library()`, you don't have to specify the package name before a function unless there is a conflict (e.g., you have two packages loaded that have a function with the same name).
:::

### Using a function

Now you can run the function <code><span class='fu'>esquisser</span><span class='op'>(</span><span class='op'>)</span></code>, which starts up an interactive plotting example.


```r
# type this in the console pane
esquisser(data = ggplot2::diamonds)
```

::: {.warning data-latex=""}
If you see the error message: `Error in esquisser(data = ggplot2::diamonds) : could not find function "esquisser"`, that just means that you forgot to load the <code class='package'>esquisse</code> package using `library(esquisse)`. Either run the code to load the package first, or preface the function with the package name like `esquisse::esquisser()` to use it without loading the package.
:::

A <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> is a name that refers to some code you can reuse. We'll start by using functions that are provided for you in packages, but you can also write your own functions. After the function name, there is a pair of parentheses, which contain zero or more <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>arguments</a>. These are options that you can set. In the example above, the `data` argument is set to `ggplot2::diamonds`, which refers to the built-in dataset `diamonds` from the <code class='package'>ggplot2</code> package.

If you type a function into the console pane, it will run as soon as you hit enter. If you put the function in a <a class='glossary' target='_blank' title='A plain-text file that contains commands in a coding language, such as R.' href='https://psyteachr.github.io/glossary/s#script'>script</a> or <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> document in the <a class='glossary' target='_blank' title='RStudio is arranged with four window "panes".' href='https://psyteachr.github.io/glossary/p#panes'>source pane</a>, it won't run until you run the script, <a class='glossary' target='_blank' title='To create an HTML, PDF, or Word document from an R Markdown (Rmd) document' href='https://psyteachr.github.io/glossary/k#knit'>knit</a> the R Markdown file, or run a code <a class='glossary' target='_blank' title='A section of code in an R Markdown file' href='https://psyteachr.github.io/glossary/c#chunk'>chunk</a>. You'll learn more about this in Chapter\ \@ref(reports).


### Tidyverse

<code class='package'>tidyverse</code>is a meta-package that loads several packages we'll be using in almost every report:

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


## Getting help {#help}

You will feel like you need a *lot* of help when you're starting to learn. This won't really go away; it's impossible to memorise everything. The goal is to learn enough about the structure of R that you can look things up quickly. This is why we'll introduce specialised jargon in the glossary for each chapter; it's easier to google "convert <a class='glossary' target='_blank' title='A data type representing strings of text.' href='https://psyteachr.github.io/glossary/c#character'>character</a> to <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a> in R" than "make numbers in quotes be actual numbers not words".

Start up help in a browser by entering `help.start()` in the console. Click on "Packages" under "Reference" to see a list of packages. Scroll down to the `readxl` package and click on it to see a list of the functions that are available in that package. 

### Function Help

If a <a class='glossary' target='_blank' title='A named section of code that can be reused.' href='https://psyteachr.github.io/glossary/f#function'>function</a> is in <a class='glossary' target='_blank' title='The set of R functions that come with a basic installation of R, before you add external packages' href='https://psyteachr.github.io/glossary/b#base-r'>base R</a> or a loaded package, you can type `?function_name` in the console to access the help file. If the package isn't loaded, use `?package_name::function_name` or specify the package in the `help()` function. When you aren't sure what package the function is in, use the shortcut `??function_name`.


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
</tbody>
</table>



## Further Resources {#resources-intro}

* [RStudio IDE Cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/rstudio-ide.pdf)
* [RStudio Cloud](https://rstudio.cloud/){target="_blank"}



