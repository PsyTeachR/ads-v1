# Basic Data Visualisation {#viz}

## Intended Learning Outcomes {#ilo-viz}

* Understand the difference between categorical and continuous data
* Create plots in layers using ggplot
* Be able to choose appropriate plots for data


```r
library(ggplot2)
library(patchwork)
library(ggthemes)
library(lubridate)
```


## Variable Types

If a spreadsheet is in a ` r glossary("tidy data")` format, each row is an <a class='glossary' target='_blank' title='All of the data about a single trial or question.' href='https://psyteachr.github.io/glossary/o#observation'>observation</a>, each column is a <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/v#variable'>variable</a>, and the information in each cell is a <a class='glossary' target='_blank' title='A single number or piece of data.' href='https://psyteachr.github.io/glossary/v#value'>value</a>. We'll learn more about how to get our data into this format in Chapter\ \@ref(tidy), but to get started we'll use built-in datasets with the right format.

For example, the table below lists pets owned by members of the psyTeachR team. Each row is an observation of one pet. There are 5 variables for each pet, their `name`, `owner`, `species`, `weight`, and `rating`.

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> name </th>
   <th style="text-align:left;"> owner </th>
   <th style="text-align:left;"> species </th>
   <th style="text-align:right;"> weight </th>
   <th style="text-align:left;"> rating </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Darwin </td>
   <td style="text-align:left;"> Lisa </td>
   <td style="text-align:left;"> ferret </td>
   <td style="text-align:right;"> 1.2 </td>
   <td style="text-align:left;"> a little evil </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Oy </td>
   <td style="text-align:left;"> Lisa </td>
   <td style="text-align:left;"> ferret </td>
   <td style="text-align:right;"> 2.9 </td>
   <td style="text-align:left;"> very good </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Khaleesi </td>
   <td style="text-align:left;"> Emily </td>
   <td style="text-align:left;"> cat </td>
   <td style="text-align:right;"> 4.5 </td>
   <td style="text-align:left;"> very good </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bernie </td>
   <td style="text-align:left;"> Phil </td>
   <td style="text-align:left;"> dog </td>
   <td style="text-align:right;"> 32.0 </td>
   <td style="text-align:left;"> very good </td>
  </tr>
</tbody>
</table>

</div>

When you're plotting data, it's important to know what type of variables you have.

### Continuous

<a class='glossary' target='_blank' title='Data that can take on any values between other existing values.' href='https://psyteachr.github.io/glossary/c#continuous'>Continuous</a> variables are properties you can measure, like weight. Continuous variables are always numbers. They may be rounded to the nearest whole number, but it should make sense to have a measurement halfway between.

### Categorical

<a class='glossary' target='_blank' title='Data that can only take certain values, such as types of pet.' href='https://psyteachr.github.io/glossary/c#categorical'>Categorical</a> variables are properties you can count, like the number of pets of each species. Categorical variables can be <a class='glossary' target='_blank' title='Categorical variables that don&#39;t have an inherent order, such as types of animal.' href='https://psyteachr.github.io/glossary/n#nominal'>nominal</a>, where the categories don't really have an order, like cats, dogs and ferrets (even though ferrets are obviously best). Sometimes people represent categorical variables with numbers that correspond to names, like 0 = "no" and 1 = "yes", but values in between don't have a clear interpretation. If you have control over how the data are recorded, it's better to use the text names for clarity, but you'll learn how to recode columns in Chapter\ \@ref(wrangle).

### Ordinal

<a class='glossary' target='_blank' title='Discrete variables that have an inherent order, such as number of legs' href='https://psyteachr.github.io/glossary/o#ordinal'>Ordinal</a> variables are a type of categorical variable with a clear order, but the distance between the categories isn't something you could exactly equate, like points on a <a class='glossary' target='_blank' title='A rating scale with a small number of discrete points in order' href='https://psyteachr.github.io/glossary/l#likert'>Likert</a> rating scale. Even if a data table uses numbers like 1-7 to represent ordinal variables, you shouldn't treat them like continuous variables.

### Dates and Times

Dates and times are a special case of variable. They can act like categorical or continuous variables, and there are special ways to plot them.


## Building Plots




### Layered Plots

Figure\ \@ref(fig:layers) displays the evolution of a simple scatterplot using this layered approach. First, the plot space is built (layer 1); the variables are specified (layer 2); the type of visualisation (known as a `geom`) that is desired for these variables is specified (layer 3) - in this case `geom_point()` is called to visualise individual data points; a second geom is added to include a line of best fit (layer 4), the axis labels are edited for readability (layer 5), and finally, a theme is applied to change the overall appearance of the plot (layer 6).

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/layers-1.png" alt="Evolution of a layered plot" width="100%" />
<p class="caption">(\#fig:layers)Evolution of a layered plot</p>
</div>

Importantly, each layer is independent and independently customisable. For example, the size, colour and position of each component can be adjusted, or one could, for example, remove the first geom (the data points) to only visualise the line of best fit, simply by removing the layer that draws the data points (Figure\ \@ref(fig:remove-layer)). The use of layers makes it easy to build up complex plots step-by-step, and to adapt or extend plots from existing code.

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/remove-layer-1.png" alt="Plot with scatterplot layer removed." width="100%" />
<p class="caption">(\#fig:remove-layer)Plot with scatterplot layer removed.</p>
</div>

### Loading Data

Let's build up a simple version of the plot above, layer by layer. First we need to get the data. We'll learn how to load data in Chapter\ \@ref(data), but you can copy the code below to create a data table object. The "column specification" tells you what each column is named and what type of data it is. A <a class='glossary' target='_blank' title='A data type representing a real decimal number' href='https://psyteachr.github.io/glossary/d#double'>double</a> is a kind of <a class='glossary' target='_blank' title='A data type representing a real decimal number or integer.' href='https://psyteachr.github.io/glossary/n#numeric'>numeric</a> value that can have decimal places.


```r
survey_data <- read_csv(file = "data/survey_data.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   caller_id = col_character(),
##   employee_id = col_character(),
##   call_start = col_datetime(format = ""),
##   wait_time = col_double(),
##   call_time = col_double(),
##   issue_category = col_character(),
##   satisfaction = col_double()
## )
```

This data is simulated data for a call centre customer satisfaction survey. The first thing you should do when you need to plot data is to get familiar with what all of the rows (observations) and columns (variables) mean. Sometimes this is obvious, and sometimes it requires help from the data provider. Here, each row represents one call to the centre.

* `caller_id` is a unique ID for each caller
* `employee_id` is a unique ID for each employee taking calls
* `call_start` is the date and time that the call arrived
* `wait_time` is the number of seconds the caller had to wait
* `call_time` is the number of seconds the call lasted after the employee picked up
* `issue_category` is whether the issue was tech, sales, returns, other
* `satisfaction` is the customer satisfaction rating on a scale from 1 (very unsatisfied) to 5 (very satisfied)

### Plot setup

Every plot starts with the `ggplot()` function and a data table. If your data are not loaded or you have a typo in your code, this will give you an error message. It's best to check your plot after each step so you can figure out where errors are more easily.


```r
ggplot(data = survey_data)
```

<img src="03-viz_files/figure-html/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

### Mapping

The next <a class='glossary' target='_blank' title='A variable that provides input to a function.' href='https://psyteachr.github.io/glossary/a#argument'>argument</a> to `ggplot()` is the `mapping`. This tells the plot which columns in the data should be represented by different "aesthetics" of the plot, such as the x-axis, y-axis, line colour, object fill, or line style.

The `mapping` argument requires an `aes()` function that can take the arguments `x` and `y`. Set those to the names of the columns you want to be plotted on those axes. Here, we want to plot the wait time on the x-axis and the call time on the y-axis.


```r
# set up the mapping
wait_vs_call <- aes(x = wait_time, 
                    y = call_time)

# set up the plot
ggplot(data = survey_data, mapping = wait_vs_call)
```

<img src="03-viz_files/figure-html/unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" />


::: {.info data-latex=""}
You will often see the two steps above (setting up the mapping and setting up the plot) combined like below. If you put arguments in the right order, you don't need to use their names, and you can put the `aes()` function directly in the second argument. Once you're very familiar with plotting, this shortcut will make sense, but we'll use the longer, clearer version to start.


```r
ggplot(survey_data, aes(x = wait_time, y = call_time))
```

:::

### Geoms

Now we can add our plot elements in layers. These are referred to as <a class='glossary' target='_blank' title='The geometric style in which data are displayed, such as boxplot, density, or histogram.' href='https://psyteachr.github.io/glossary/g#geom'>geoms</a> and their functions start with `geom_`. You **add** layers onto the base plot created by `ggplot()` with a plus (`+`). 


```r
ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point() # scatterplot
```

<img src="03-viz_files/figure-html/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />

::: {.warning data-latex=""}
Somewhat annoyingly, the plus has to be on the end of the previous line, not at the start of the next line. If you do make this mistake, you will get the following error message.


```r
g <- ggplot(data = survey_data, mapping = wait_vs_call)
  + geom_point() # scatterplot
```

```
## Error: Cannot use `+.gg()` with a single argument. Did you accidentally put + on a new line?
```
:::

### Multiple Geoms

You can add more than one geom. They display in the order you set them up. In the code below, we make two different plots and assign them to <a class='glossary' target='_blank' title='A word that identifies and stores the value of some data for later use.' href='https://psyteachr.github.io/glossary/o#object'>objects</a> that we can add together using the `plot_layout()` function from the <code class='package'>patchwork</code> package.


```r
point_first <- 
  ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point() + # scatterplot
  geom_smooth(method = lm) # line of best fit
  
line_first <-
  ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_smooth(method = lm) + # line of best fit
  geom_point() # scatterplot

# add plots together in 1 row
point_first + line_first + plot_layout(nrow = 1)
```

```
## `geom_smooth()` using formula 'y ~ x'
## `geom_smooth()` using formula 'y ~ x'
```

<img src="03-viz_files/figure-html/unnamed-chunk-9-1.png" width="100%" style="display: block; margin: auto;" />


### Styling Geoms

We should definitely put the line in front of the points, but the points are still a bit dark. If you want to change the overall style of a geom (not use it to represent different levels of a variable), you can set arguments inside the geom function. See Appendix\ \@ref(plotstyle) for more information about the ways to style plot aesthetics.



```r
ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2,
             shape = 18,
             size = 2) + 
  geom_smooth(method = lm, 
              formula = y~x, # default value; avoids annoying message
              colour = rgb(0, .5, .8),
              linetype = 3) 
```

<img src="03-viz_files/figure-html/unnamed-chunk-10-1.png" width="100%" style="display: block; margin: auto;" />


::: {.try data-latex=""}
Play around with different values for the aesthetics above. Figure out what the default values are for `shape` and `size`.
:::

### Format Axes

Now we need to make the axes look neater. There are several functions you can use to change the axis labels, but the most powerful ones are the `scale_` functions. You need to use a scale function that matches the data you're plotting on that axis. Both of the axes here are <a class='glossary' target='_blank' title='Data that can take on any values between other existing values.' href='https://psyteachr.github.io/glossary/c#continuous'>continuous</a>, so we'll use `scale_x_continuous()` and `scale_y_continuous()`.

The `name` argument changes the axis label. The `breaks` argument sets the major units and needs a <a class='glossary' target='_blank' title='A type of data structure that is basically a list of things like T/F values, numbers, or strings.' href='https://psyteachr.github.io/glossary/v#vector'>vector</a> of possible values, which can extend beyond the range of the data (e.g., `wait time` only goes up to 350, but we can specify breaks up to 600). The `seq()` function creates a sequence of numbers `from` one `to` another `by` specified steps.


```r
# set the breaks
x_breaks <- seq(from = 0, to = 600, by = 60)
y_breaks <- seq(from = 0, to = 600, by = 30)

ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2) + 
  geom_smooth(method = lm, 
              formula = y~x, 
              colour = rgb(0, .5, .8)) +
  scale_x_continuous(name = "Wait Time (seconds)", 
                     breaks = x_breaks) +
  scale_y_continuous(name = "Call time (seconds)",
                     breaks = y_breaks)
```

<img src="03-viz_files/figure-html/unnamed-chunk-11-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
Check the help for `?scale_x_continuous` to see how you would set the minor units or specify how many breaks you want instead.
:::

We can change how the axis text displays by setting the `labels` argument. Let's change this to minutes instead of seconds by dividing the labels by 60. 


```r
ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2) + 
  geom_smooth(method = lm, 
              formula = y~x, 
              colour = rgb(0, .5, .8)) +
  scale_x_continuous(name = "Wait Time (minutes)", 
                     breaks = x_breaks,
                     labels = x_breaks/60) +
  scale_y_continuous(name = "Call time (minutes)",
                     breaks = y_breaks,
                     labels = y_breaks/60)
```

<img src="03-viz_files/figure-html/unnamed-chunk-12-1.png" width="100%" style="display: block; margin: auto;" />

If you want to change the minimum and maximum values on an axis, use the `limits` argument. Many plots make more sense if the minimum and maximum values represent the range of possible values, even if those values aren't present in the data. Here, wait and call times can't be less than 0 seconds, so we'll set the minimum values to 0 and the maximum values to 10 seconds above the highest value in the data.



```r
# set the axis limits
xlim <- c(0, max(survey_data$wait_time) + 10)
ylim <- c(0, max(survey_data$call_time) + 10)

ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2) + 
  geom_smooth(method = lm, 
              formula = y~x, 
              colour = rgb(0, .5, .8)) +
  scale_x_continuous(name = "Wait Time (minutes)", 
                     breaks = x_breaks,
                     labels = x_breaks/60,
                     limits = xlim) +
  scale_y_continuous(name = "Call time (minutes)",
                     breaks = y_breaks,
                     labels = format(y_breaks/60, digits = 1),
                     limits = ylim)
```

<img src="03-viz_files/figure-html/unnamed-chunk-13-1.png" width="100%" style="display: block; margin: auto;" />

::: {.info data-latex=""}
The y-axis has increments of 30 seconds, so to make sure the whole numbers also have a decimal place (e.g., "1.0" instead of "1"), we used the `format()` function to set the number of decimal places to display.
:::

### Themes

<code class='package'>ggplot2</code> comes with several built-in themes, such as `theme_minimal()` and `theme_bw()`, but the <code class='package'><a href='https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/' target='_blank'>ggthemes</a></code> package provides even more themes that match different software, such as GoogleDocs or Stata, or publications, such as the Economist or the Wall Street Journal. Let's add the GoogleDocs theme, but change the font size to 11 with the `base_size` argument and change the font to "Times" with the `base_family` argument.


```r
ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2) + 
  geom_smooth(method = lm, 
              formula = y~x, 
              colour = rgb(0, .5, .8)) +
  scale_x_continuous(name = "Wait Time (minutes)", 
                     breaks = x_breaks,
                     labels = x_breaks/60,
                     limits = xlim) +
  scale_y_continuous(name = "Call time (minutes)",
                     breaks = y_breaks,
                     labels = format(y_breaks/60, digits = 1),
                     limits = ylim) +
  ggthemes::theme_gdocs(base_size = 11, base_family = "Times")
```

<img src="03-viz_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" />

### Theme Tweaks

If you're still not quite happy with a theme, you can customise it even further with the `themes()` function. Check the help for this function to see all of the possible options. The most common thing you'll want to do is to remove an element entirely. You do this by setting the relevant argument to `element_blank()`. Below, we're getting rid of the x-axis line and the plot background, which removes the line around the plot.


```r
ggplot(data = survey_data, mapping = wait_vs_call) +
  geom_point(colour = "dodgerblue", 
             alpha = 0.2) + 
  geom_smooth(method = lm, 
              formula = y~x, 
              colour = rgb(0, .5, .8)) +
  scale_x_continuous(name = "Wait Time (minutes)", 
                     breaks = x_breaks,
                     labels = x_breaks/60,
                     limits = xlim) +
  scale_y_continuous(name = "Call time (minutes)",
                     breaks = y_breaks,
                     labels = format(y_breaks/60, digits = 1),
                     limits = ylim) +
  ggthemes::theme_gdocs(base_size = 11, base_family = "Times") +
  theme(axis.line.x = element_blank(),
        plot.background = element_blank())
```

<img src="03-viz_files/figure-html/unnamed-chunk-15-1.png" width="100%" style="display: block; margin: auto;" />


## Appropriate Plots

The [ggplot2 cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf) is a great resource to help you find plots appropriate to your data. The examples below all use the same customer satisfaction data, but each plot communicates something different. 

We don't expect you to memorise all of the plot types or the methods for customising them, but it will be helpful to try out the code in the examples below for yourself, changing values to test your understanding.

### Counting Categories

If you want to count the number of things per category, you can use `geom_bar()`.


```r
count_issues <- aes(x = issue_category)

ggplot(data = survey_data, mapping = count_issues) +
  geom_bar()
```

<img src="03-viz_files/figure-html/unnamed-chunk-16-1.png" width="100%" style="display: block; margin: auto;" />


We'll want to customise some things about this, like the colours, order of the columns, and their labels. Inspect the code below to figure out where these things change. The functions `scale_fill_manual()` and `scale_x_discrete()` are new, but work in the same way as the other `scale_` functions.


```r
# gives each issue a different colour
count_issues <- aes(x = issue_category,
                    fill = issue_category) 

# change the deafult order and colours
new_colors <- c(tech = "goldenrod", 
                returns = "darkgreen", 
                sales = "dodgerblue3", 
                other = "purple3")
new_order <- c("tech", "returns", "sales", "other")
new_labels <- c("Technical", "Returns", "Sales", "Other")

ggplot(data = survey_data, mapping = count_issues) +
  geom_bar() +
  scale_x_discrete(
    name = "Issue Category", # change axis title
    limits = new_order, # change order
    labels = new_labels # change labels
  ) +
  scale_fill_manual(
    values = new_colors, # change colours
    guide = "none" # remove the legend
  ) +
  scale_y_continuous(
    name = "", # remove axis title
    # remove the space above and below the y-axis
    expand = expansion(add = 0), 
    limits = c(0, 350) # minimum = 0, maximum = 350
  ) +
  ggtitle("Number of issues per category") # add a title
```

<img src="03-viz_files/figure-html/unnamed-chunk-17-1.png" width="100%" style="display: block; margin: auto;" />

### Continuous Distribution

If you have a continuous variable, like the number of seconds callers have to wait, you can use `geom_histogram()` to show the distribution. 


```r
ggplot(data = survey_data, mapping = aes(x = wait_time)) +
  geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/unnamed-chunk-18-1.png" alt="Histogram of wait times." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-18)Histogram of wait times.</p>
</div>

You should always set the `binwidth` or number of `bins` to something meaningful for your data (otherwise you get that annoying message). You might need to try a few options before you find something that looks good and conveys the meaning of your plot; `binwidth = 15` seems to work well here. 

By default, the bars start *centered* on 0, so the first bar would include -7.5 to 7.5 seconds, which doesn't make much sense. We can set `boundary = 0` so that each bar represents increments of 15 seconds *starting* from 0. 

The default style of grey bars is ugly, so you can change that by setting the `fill` and `colour`. 

We can also set up a custom the x-axis called `wait_x` so we can reuse it in other plots.


```r
# set up x-axis 
wait_x <- scale_x_continuous(
  name = "Wait time (minutes)",
  breaks = seq(0, 600, 60),
  labels = seq(0, 600, 60)/60,
  limits = c(0, 360)
)

# style histogram
ggplot(data = survey_data, mapping = aes(x = wait_time)) +
  geom_histogram(boundary = 0, binwidth = 15, 
                 fill = "white", color = "black") +
  wait_x
```

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/unnamed-chunk-19-1.png" alt="Histogram with custom styles." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-19)Histogram with custom styles.</p>
</div>

### Grouped Continuous Distribution

You can set the `fill` aesthetic in the mapping to show what proportion of each bin comes from each category. By default, the categories are positioned stacked on top of each other. The function `geom_area()` gives a similar effect when `stat = "bin"`. 


```r
# set fill by issue category
wait_by_issue <- aes(x = wait_time, fill = issue_category)

# stacked histogram
histogram_stack <- ggplot(data = survey_data, mapping = wait_by_issue) +
  geom_histogram(boundary = 0, 
                 binwidth = 15, 
                 color = "black") +
  wait_x + 
  ggtitle("Stacked Histogram")

# area plot
area_plot <- ggplot(data = survey_data, mapping = wait_by_issue) +
  geom_area(stat = "bin", 
            boundary = 0, 
            binwidth = 15, 
            color = "black",
            show.legend = FALSE) +
  wait_x +
  ggtitle("Area")

histogram_stack + area_plot + 
  plot_layout(nrow = 1, guides = "collect")
```

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/unnamed-chunk-20-1.png" alt="Stacked histogram." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-20)Stacked histogram.</p>
</div>

::: {.warning data-latex=""}
Make sure to remove the `fill` argument from `geom_histogram()`, or it will overwrite the colours set in the mapping.
:::

If you want to compare more than one distribution, you can set the `position` argument of `geom_histogram()` to "dodge", but this can look confusing with several categories. You can use`geom_freqpoly()` to plot a line connecting the top of each bin. Which you choose depends on what point you are trying to make with the plot.


```r
# set both fill and colour to differ by issue category
wait_by_issue <- aes(x = wait_time, 
                     fill = issue_category, 
                     colour = issue_category)

# dodged histogram
histogram_dodge <- ggplot(data = survey_data, mapping = wait_by_issue) +
  geom_histogram(boundary = 0, 
                 binwidth = 15, 
                 position = "dodge") +
  wait_x + 
  ggtitle("Dodged Histogram")

# frequency plot
freqpoly_plot <- ggplot(data = survey_data, mapping = wait_by_issue) +
  geom_freqpoly(binwidth = 15, 
                boundary = 0,
                size = 1) +
  wait_x +
  ggtitle("Frequency")

# paste the three plots together
histogram_dodge + freqpoly_plot + 
  plot_layout(nrow = 1, guides = "collect")
```

```
## Warning: Removed 8 row(s) containing missing values (geom_path).
```

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/unnamed-chunk-21-1.png" alt="Different ways to plot the distribution of a continuous variable for multiple groups." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-21)Different ways to plot the distribution of a continuous variable for multiple groups.</p>
</div>


### Two Continuous Distributions

When you want to see how two continuous variables are related, set one as the x-axis and the other as the y-axis. Usually, if one variable causes the other, you plot the cause on the x-axis and the effect on the y-axis. Here, we want to see if longer wait times cause the calls to be longer. 


```r
wait_by_call <- aes(x = wait_time,
                    y = call_time)

# assign the base plot to a variable to use later
g <- ggplot(data = survey_data, mapping = wait_by_call)

g + geom_point()
```

<img src="03-viz_files/figure-html/unnamed-chunk-22-1.png" width="100%" style="display: block; margin: auto;" />



```r
point_plot <- g +
  geom_point(alpha = 0.2) +
  ggtitle("Point Plot")

smooth_plot <- g +
  geom_smooth(method = "loess", formula = y~x) +
  ggtitle("Smooth")

lm_plot <- g +
  geom_smooth(method = lm, formula = y~x) +
  ggtitle("Linear")

combo_plot <- g +
  geom_point(alpha = 0.2) +
  geom_smooth(method = lm, formula = y~x) +
  ggtitle("Combo")

point_plot + smooth_plot + lm_plot + combo_plot
```

<div class="figure" style="text-align: center">
<img src="03-viz_files/figure-html/unnamed-chunk-23-1.png" alt="Different ways to show the relationship between two continuous variables." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-23)Different ways to show the relationship between two continuous variables.</p>
</div>

### Dates

The `call_start` column contains both a date and a time, so use the `date()` function from <code class='package'>lubridate</code> to convert it to just a date. We'll need this to be able to transform the x-axis below.


```r
satisfaction_by_date <- aes(x = lubridate::date(call_start),
                            y = satisfaction)

# assign the base plot to a variable to use later
g <- ggplot(data = survey_data, mapping = satisfaction_by_date)

g + geom_smooth(method = lm,  formula = y~x)
```

<img src="03-viz_files/figure-html/unnamed-chunk-24-1.png" width="100%" style="display: block; margin: auto;" />

We can use `scale_x_date()` to set the `date_breaks` to be "1 month" apart. The `date_labels` use a code for different date formats, which you can see in the help for `?strptime`. For example, you can change the dates to a format like "2020/01/31" with the formatting string `"%Y/%m/%d"`.




```r
g + geom_smooth(method = lm,  formula = y~x) +
  scale_x_date(name = "",
               date_breaks = "1 month", 
               date_labels = "%b") +
  scale_y_continuous(name = "Caller Satisfaction") +
  ggtitle("2020 Caller Satisfaction")
```

<img src="03-viz_files/figure-html/unnamed-chunk-25-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
It looks like customer satisfaction declined a bit in the first half of the year, but is this change meaningful? See what the plot looks like when the y-axis spans the full range of possible satisfaction values from 1 to 5.


```r
g + geom_smooth(method = lm,  formula = y~x) +
  scale_x_date(name = "",
               date_breaks = "1 month", 
               date_labels = "%b") +
  scale_y_continuous(name = "Caller Satisfaction",
                     breaks = 1:5,
                     limits = c(1, 5)) +
  ggtitle("2020 Caller Satisfaction")
```

<img src="03-viz_files/figure-html/webex.hide-1.png" width="100%" style="display: block; margin: auto;" />

:::






## Glossary {#glossary-viz}

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
   <td style="text-align:left;"> [categorical](https://psyteachr.github.io/glossary/c.html#categorical){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Data that can only take certain values, such as types of pet. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [continuous](https://psyteachr.github.io/glossary/c.html#continuous){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Data that can take on any values between other existing values. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [double](https://psyteachr.github.io/glossary/d.html#double){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A data type representing a real decimal number </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [geom](https://psyteachr.github.io/glossary/g.html#geom){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The geometric style in which data are displayed, such as boxplot, density, or histogram. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [likert](https://psyteachr.github.io/glossary/l.html#likert){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A rating scale with a small number of discrete points in order </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [nominal](https://psyteachr.github.io/glossary/n.html#nominal){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Categorical variables that don&#39;t have an inherent order, such as types of animal. </td>
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
   <td style="text-align:left;"> [observation](https://psyteachr.github.io/glossary/o.html#observation){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> All of the data about a single trial or question. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [ordinal](https://psyteachr.github.io/glossary/o.html#ordinal){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Discrete variables that have an inherent order, such as number of legs </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [value](https://psyteachr.github.io/glossary/v.html#value){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A single number or piece of data. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [variable](https://psyteachr.github.io/glossary/v.html#variable){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A word that identifies and stores the value of some data for later use. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [vector](https://psyteachr.github.io/glossary/v.html#vector){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> A type of data structure that is basically a list of things like T/F values, numbers, or strings. </td>
  </tr>
</tbody>
</table>



## Further Resources {#resources-viz}

* [Data visualisation using R, for researchers who don't use R](https://psyteachr.github.io/introdataviz/) [@nordmann_2021]
* [Chapter 3: Data Visualisation](http://r4ds.had.co.nz/data-visualisation.html) of *R for Data Science*
* [ggplot2 cheat sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
* [ggplot2 FAQs](https://ggplot2.tidyverse.org/articles/)
* [Chapter 28: Graphics for communication](http://r4ds.had.co.nz/graphics-for-communication.html) of *R for Data Science*
* [Look at Data](http://socviz.co/look-at-data.html) from [Data Vizualization for Social Science](http://socviz.co/)
* [Hack Your Data Beautiful](https://psyteachr.github.io/hack-your-data/) workshop by University of Glasgow postgraduate students
* [Graphs](http://www.cookbook-r.com/Graphs) in *Cookbook for R*
* [ggplot2 documentation](https://ggplot2.tidyverse.org/reference/)
* [The R Graph Gallery](http://www.r-graph-gallery.com/) (this is really useful)
* [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
* [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/) by Winston Chang
* [ggplot extensions](https://www.ggplot2-exts.org/)
* [plotly](https://plot.ly/ggplot2/) for creating interactive graphs
