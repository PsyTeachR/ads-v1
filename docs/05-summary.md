# Data Summaries {#summary}

## Intended Learning Outcomes {#ilo-summary}

* Be able to summarise data by groups
* Be able to produce well-formatted tables

In this chapter we'll use the following packages:


```r
library(tidyverse)   # data wrangling functions
library(rtweet) # for searching tweets
library(kableExtra)  # for nice tables
library(glue) # for pasting strings
```

## Set-up

First, create a new project for the work we'll do in this chapter named <code class='path'>05-summary</code>. Second, download the data for this chapter <a href="data/ncod_tweets.rds" download>ncod_tweets.rds</a> and save it in your project data folder. Finally, open and save and new R Markdown document named `summary.Rmd`, delete the welcome text and load the required packages for this chapter.

## Social media data

In this chapter we're going to analyse social media data, specifically data from Twitter. There are two broad types of data you can obtain from Twitter; data scraped from Twitter using purpose-built packages such as <code class='package'>rtweet</code>, and data provided via [Twitter Analytics](https://analytics.twitter.com/) for any accounts for which you have access. 

For this chapter, we'll use data scraped from Twitter using <code class='package'>rtweet</code>. In order to use these functions, you need to have a Twitter account although don't worry if you don't have one, we'll also provide the data for you.

<code class='package'>rtweet</code> has a lot of flexibility, for example, you can search for tweets that contain a certain hashtag or word, tweets by a specific user, or tweets that meet certain conditions like location or whether the user is verified. 

For the dataset for this chapter, we used the `search_tweets()` function  to find the last 30K tweets with the hashtag [#NationalComingOutDay](https://en.wikipedia.org/wiki/National_Coming_Out_Day).This is mainly interesting around October 11th (the date of National Coming Out Day), so we've provided the relevant data for you that we scraped at that time. 

If you have a Twitter account, you can complete this chapter using your own data and any hashtag that interests you. When you run the `search_tweets()` function you will be asked to sign in to your Twitter account.


```r
tweets <- search_tweets(q = "#NationalComingOutDay", 
                        n = 30000, 
                        include_rts = FALSE)
```

### R objects

If you're working with live social media data, every time you run a query it's highly likely you will get a different set of data as new tweets are added. Additionally, the Twitter API places limits on how much data you can download and searches are limited to data from the last 6-9 days. Consequently, it can be useful to save the results of your initial search. `saveRDS` is a useful function that allows you to save any object in your environment to disk


```r
saveRDS(tweets, file = "data/ncod_tweets.rds")
```

To load an `.rds` file, you can use the `readRDS` function. If you don't have access to a Twitter account, or to ensure that you get the same output as the rest of this chapter, you can now load in `ncod_tweets.rds` using this function.


```r
tweets <- readRDS("data/ncod_tweets.rds")
```

## Data summaries

### Summarise

First, run `glimpse(tweets)` and click on the object in the environment to find out what information is in the downloaded data (it's a lot!). Now let's create a series of summary tables and plots with these data.

The `summarise()` function from the <code class='package'>dplyr</code> package is loaded as part of the tidyverse and creates summary statistics. Check the [Data Transformation Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf) for various summary functions. Some common ones are: `n()`, `min()`, `max()`, `sum()`, `mean()`, and `quantile()`.

This function can be used to answer questions like: How many tweets were there? What date range is represented in these data? What are the mean and median number of favourites per tweet? Let's start with a very simple example to calculate the mean, median, min, and max number of favourites (Twitter's version of a "like"):

* The first argument `summarise()` takes is the data table you wish to summarise, in this case the object `tweets`.
* `summarise()` will create a new table. The column names of this new table will be the left hand-side arguments, i.e., `mean_favs` and `median_favs`. 
* The values of these columns are the result of the summary operation on the right hand-side.


```r
favourite_summary <- summarise(tweets,
                           mean_favs = mean(favorite_count),
                           median_favs = median(favorite_count),
                           min_favs = min(favorite_count),
                           max_favs = max(favorite_count))
```

<table>
 <thead>
  <tr>
   <th style="text-align:center;"> mean_favs </th>
   <th style="text-align:center;"> median_favs </th>
   <th style="text-align:center;"> min_favs </th>
   <th style="text-align:center;"> max_favs </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 29.71732 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 22935 </td>
  </tr>
</tbody>
</table>

The mean number of favourites is substantially higher than the median and the range is huge, suggesting there are outliers. A quick histogram confirms this - most tweets have zero favourites but there are a few  with a lot of likes (so few you can't really see them on the histogram) that skew the mean.


```r
ggplot(tweets, aes(x = favorite_count)) +
  geom_histogram()
```

<img src="05-summary_files/figure-html/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" />

You can add multiple operations to a single call to `summarise()` so let's try a few different operations. The `n()` function counts the number of rows in the data. The `created_at` column gives us the date each tweet were created, so we can use the `min()` and `max()` functions to get the range of dates. 


```r
tweet_summary <- tweets %>%
  summarise(mean_favs = mean(favorite_count),
            median_favs = quantile(favorite_count, .5),
            n = n(),
            min_date = min(created_at),
            max_date = max(created_at))

glimpse(tweet_summary)
```

```
## Rows: 1
## Columns: 5
## $ mean_favs   <dbl> 29.71732
## $ median_favs <dbl> 3
## $ n           <int> 28626
## $ min_date    <dttm> 2021-10-10 00:10:02
## $ max_date    <dttm> 2021-10-12 20:12:27
```

::: {.info data-latex=""}
<a class='glossary' target='_blank' title='Cutoffs dividing the range of a distribution into continuous intervals with equal probabilities.' href='https://psyteachr.github.io/glossary/q#quantile'>Quantiles</a> are like percentiles. Use `quantile(x, .50)` to find the median (the number where 50% of values in `x` are above it and 50% are below it). This can be useful when you need a value like "90% of tweets get *X* favourites or fewer".


```r
quantile(tweets$favorite_count, 0.90)
```

```
## 90% 
##  31
```

:::




::: {.try data-latex=""}
* How would you find the largest number of retweets?
    <div class='webex-radiogroup' id='radio_UNFNZOXWFR'><label><input type="radio" autocomplete="off" name="radio_UNFNZOXWFR" value="answer"></input> <span>`tweets %>% summarise(max_retweets = max(retweets))`</span></label><label><input type="radio" autocomplete="off" name="radio_UNFNZOXWFR" value="x"></input> <span>`tweets %>% max(retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_UNFNZOXWFR" value="x"></input> <span>`tweets %>% summarise(max_retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_UNFNZOXWFR" value="x"></input> <span>`tweets %>% summarise(max = retweets)`</span></label></div>

* How would you calculate the mean `display_text_width`? 
    <div class='webex-radiogroup' id='radio_IHCSNKJJDO'><label><input type="radio" autocomplete="off" name="radio_IHCSNKJJDO" value="x"></input> <span>`group_by(display_text_width)`</span></label><label><input type="radio" autocomplete="off" name="radio_IHCSNKJJDO" value="x"></input> <span>`width(mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_IHCSNKJJDO" value="x"></input> <span>`summarise(display_text_width = mean)`</span></label><label><input type="radio" autocomplete="off" name="radio_IHCSNKJJDO" value="answer"></input> <span>`summarise(width = mean(display_text_width))`</span></label></div>

:::

### The $ operator

We need to take a couple of brief detours to introduce some additional coding conventions. First, let's clear up what that `$` notation is doing. The dollar sign allows you to select variables from an object. The left-hand side is the object, and the right-hand side is the variable. When you call a variable like this, R will print all the observations in that variable. 


```r
tweet_summary$mean_favs
```

```
## [1] 29.71732
```

If your variable has multiple observations, you can specify which ones to return using square brackets `[]` and the row number.


```r
tweets$source[1] # select one observation
tweets$display_text_width[c(20,30,40)] # select multiple with c()
```

```
## [1] "Twitter for Android"
## [1]  78 287 107
```

### Pipes

For our second detour, let's formally introduce the pipe, that weird `%>%` symbol we've used occasionally. Pipes allow you to send the output from one function straight into another function. Specifically, they send the result of the function before `%>%` to be the first argument of the function after `%>%`. It can be useful to translate the pipe as **and then**. It's easier to show than tell so let's look at an example.

We could write the above code using a pipe as follows:


```r
tweet_summary <- tweets %>% # start with the object tweets and then
  summarise(mean_favs = mean(favorite_count), #summarise it
            median_favs = median(favorite_count))
```

Notice that `summarise()` no longer needs the first argument to be the data table, it is pulled in from the pipe. The power of the pipe may not be obvious now, but it will soon prove its worth. 
### Inline coding

To insert those values into the text of a report you can use inline coding. First. we'll create another set of objects that contain the first and last date of the tweets in our dataset. `format()` formats the dates to day/month/year.


```r
date_from <- tweet_summary$min_date %>% 
  format("%d %B, %Y")
date_to <- tweet_summary$max_date %>% 
  format("%d %B, %Y")
```

Then you can insert values from these objects and the tables you created with `summarise()` using inline R (note the dollar sign notation). Knit your Markdown to see the output. 


```r
There were `r backtick("r tweet_summary$n")` tweets between `r backtick("r date_from")` and `r backtick("r date_to")`.
```
There were 28626 tweets between 10 October, 2021 and 12 October, 2021.

Ok, let's get back on track.

### Counting

How many different accounts tweeted using the hashtag? Who tweeted most?

You can count categorical data with the `count()` function. Since each row is a tweet, you can count the number of rows per each different `screen_name` to get the number of tweets per user. This will give you a new table with each combination of the counted columns and a column called `n` containing the number of observations from that group. 

`sort = TRUE` will sort the table by `n` in descending order whilst `head()` returns the first six lines of a data table and is a useful function to call when you have a very large dataset and just want to see the top values.


```r
tweets_per_user <- tweets %>%
  count(screen_name, sort = TRUE)

head(tweets_per_user)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> interest_outfit </td>
   <td style="text-align:right;"> 35 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> LeoShir2 </td>
   <td style="text-align:right;"> 33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dr_stack </td>
   <td style="text-align:right;"> 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NRArchway </td>
   <td style="text-align:right;"> 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bhavna_95 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> WipeHomophobia </td>
   <td style="text-align:right;"> 23 </td>
  </tr>
</tbody>
</table>

</div>



::: {.try data-latex=""}
* How would you count the number of tweets that are quotes or not and are retweets or not? 
    <div class='webex-radiogroup' id='radio_YLXUIYXKOH'><label><input type="radio" autocomplete="off" name="radio_YLXUIYXKOH" value="answer"></input> <span>`tweets %>% count(is_quote, is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_YLXUIYXKOH" value="x"></input> <span>`tweets %>% count(is_quote) %>% count(is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_YLXUIYXKOH" value="x"></input> <span>`tweets %>% count(c(is_quote, is_retweet))`</span></label><label><input type="radio" autocomplete="off" name="radio_YLXUIYXKOH" value="x"></input> <span>`tweets %>% select(is_quote, is_retweet) %>% count()`</span></label></div>

:::

### Inline coding 2

Let's do another example of inline coding that writes up a summary of the most prolific tweets to demonstrate a few additional functions. First, we need to create some additional objects to use with inline R:

* `nrow` simply counts the number of rows in a dataset so if you have one user/participant/customer per row, this is an easy way to do a head count.
* `slice()` selects a particular row of data, in this case the first row. Because we sorted our data, this will therefore be the user with the most tweets.
* `pull()` pulls out a single variable. 
* The combination of `slice()` and `pull()` allows you to select a single observation from a single variable.


```r
unique_users <- nrow(tweets_per_user)
most_prolific <- slice(tweets_per_user, 1) %>% 
  pull(screen_name)
most_prolific_n <- slice(tweets_per_user, 1) %>% 
  pull(n)
```

Then add the inline code to your report and knit your Markdown to see the output:


```r
There were `r unique_users` unique accounts tweeting about #NationalComingOutDay. `r `most_prolific` was the most prolific tweeter, with `r most_prolific_n` tweets.
```

There were 25189 unique accounts tweeting about #NationalComingOutDay. interest_outfit was the most prolific tweeter, with 35 tweets.

### Grouping

You can also create other summary values by group. The combination of `group_by()` and `summarise()` is incredibly powerful, and it is also a good demonstration of why pipes are so useful.

`group_by()` takes an existing data table and converts it into a grouped table where any operations that are performed on it are doing "by group".

The first line of code creates an object named `tweets_grouped`, that groups the dataset according to whether the user is a verified user. On the surface, `tweets_grouped` doesn't look any different to the original `tweets`, however, the underlying structure has changed and so when we run `summarise()`, we now get our requested summaries for each group (in this case verified or not). 


```r
tweets_grouped <- tweets %>%
  group_by(verified)

verified <- tweets_grouped %>%
  summarise(count = n(),
            mean_favs = mean(favorite_count),
            mean_retweets = mean(retweet_count)) %>%
  ungroup()

verified
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> verified </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:right;"> mean_favs </th>
   <th style="text-align:right;"> mean_retweets </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 26676 </td>
   <td style="text-align:right;"> 18.40576 </td>
   <td style="text-align:right;"> 1.825649 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 1950 </td>
   <td style="text-align:right;"> 184.45949 </td>
   <td style="text-align:right;"> 21.511282 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
Make sure you call the `ungroup()` function when you are done with grouped functions. Failing to do this can cause all sorts of mysterious problems if you use that data table later assuming it isn't grouped.
:::

Whilst the above code is functional, it adds an unnecessary object to the environment - `tweets_grouped` is taking up space and increases the risk we'll use this grouped object by mistake. Enter the pipe.

Rather than creating an intermediate object, we can use the pipe to string our code together.


```r
verified <- tweets_grouped %>% # Start with the original dataset and then;
  group_by(verified) %>% # group it and then
  summarise(count = n(), # summarise it by those groups
            mean_favs = mean(favorite_count),
            mean_retweets = mean(retweet_count)) %>%
  ungroup()
```



::: {.try data-latex=""}
* What would you change to calculate the mean favourites and retweets by `screen_name` instead of by `verified`? 
    <div class='webex-radiogroup' id='radio_YEPZSKXDGR'><label><input type="radio" autocomplete="off" name="radio_YEPZSKXDGR" value="x"></input> <span>`count(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_YEPZSKXDGR" value="answer"></input> <span>`group_by(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_YEPZSKXDGR" value="x"></input> <span>`mean(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_YEPZSKXDGR" value="x"></input> <span>`summarise(screen_name)`</span></label></div>

:::

### Multiple groupings

You can add multiple variables to `group_by()` to further break down your data. For example, the below gives us the number of likes and retweets broken down by verified status and the device the person was tweeting from. 

* Reverse the order of `verified` and `source` in `group_by()` to see how it changed the output.


```r
verified_source <- tweets %>%
  group_by(verified, source) %>%
  summarise(count = n(),
            mean_favs = mean(favorite_count),
            mean_retweets = mean(retweet_count)) %>%
  ungroup() %>%
  arrange(desc(count))
```

```
## `summarise()` has grouped output by 'verified'. You can override using the `.groups` argument.
```

```r
head(verified_source)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> verified </th>
   <th style="text-align:left;"> source </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:right;"> mean_favs </th>
   <th style="text-align:right;"> mean_retweets </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> Twitter for iPhone </td>
   <td style="text-align:right;"> 12943 </td>
   <td style="text-align:right;"> 25.40493 </td>
   <td style="text-align:right;"> 2.304643 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> Twitter for Android </td>
   <td style="text-align:right;"> 5807 </td>
   <td style="text-align:right;"> 11.90839 </td>
   <td style="text-align:right;"> 1.155846 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> Twitter Web App </td>
   <td style="text-align:right;"> 5795 </td>
   <td style="text-align:right;"> 13.54737 </td>
   <td style="text-align:right;"> 1.611217 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> Twitter for iPhone </td>
   <td style="text-align:right;"> 691 </td>
   <td style="text-align:right;"> 323.24457 </td>
   <td style="text-align:right;"> 29.010130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> Twitter Web App </td>
   <td style="text-align:right;"> 560 </td>
   <td style="text-align:right;"> 131.44643 </td>
   <td style="text-align:right;"> 21.717857 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> Twitter for iPad </td>
   <td style="text-align:right;"> 374 </td>
   <td style="text-align:right;"> 13.85027 </td>
   <td style="text-align:right;"> 2.042781 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you get the following message when using `group_by()`, please update tidyverse.

> `summarise()` ungrouping output (override with `.groups` argument)
:::

### Filter and mutate

You can also use additional functions like `filter()` or `mutate()` after `group_by`. You'll learn more about these in Chapter \ \@ref(wrangle) but briefly:

* `filter()` selects observations (rows) according to specified criteria, e.g., all values above 5, all verified users.
* `mutate()` creates new variables (columns), or overwrites existing ones.

You can combine functions like this to get detailed insights into your data. For example, what was the most favourited original and quoted tweet? 

* The variable `is_quote` tells us whether the tweet in question was an original tweet or a quote tweet. Because we want our output to treat these separately, we pass this variable to `group_by()`. 
* We want the most favourited tweets, i.e., the maximum value of `favourite_count`, so we can use `filter()` to only return rows where `favourite_count` is equal to the maximum value in the variable `favourite_count`. Note the use of `==` rather than a single `=`.
* Just in case there was a tie, choose a random one with `sample_n(size = 1)`.


```r
most_fav <- tweets %>%
  group_by(is_quote) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

### Inline coding 3

There's a huge amount of data reported for each tweet, including things like the URLs of the tweets and any media attached to  them. This means we can produce output like the below reproducibly and using inline coding.



> The most favourited 22935 original tweet was by [jackrooke](`r `orig$status_url`):

--------------------------------------------------
> it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4

![](orig$ext_media_url)

------------------------------------------------

To produce this, first we split `most_fav`, so that we have one object that contains the data from the original tweet and one object that contains the data from the quote tweet.



The inline code is then as follows:


```r
> The most favourited `r orig$favorite_count` original tweet was by [`r orig$screen_name`](`r `orig$status_url`):

--------------------------------------------------
> `r orig$text`

![](orig$ext_media_url)
--------------------------------------------------
```

This is quite complicated so let's break it down. 

* The `>` symbol changes the format to a block quote.
* The first bit of inline coding is fairly standard and is what you have used before.
* The second bit of inline coding inserts a URL. The content of the `[]` is the text that will be displayed. The content of `()` is the underlying URL. In both cases the content is being pulled from the dataset. In this case, the text is `screen_name` and `status_url` links to the tweet.
* The line of dashes creates the solid line in the knitted output.
* The image is then included using the format `![]()` which is alternative method of including images in Markdown. 




::: {.try data-latex=""}
* How would you limit the results to sources with 10 or more rows?
    <div class='webex-radiogroup' id='radio_JTXOXKBTDR'><label><input type="radio" autocomplete="off" name="radio_JTXOXKBTDR" value="x"></input> <span>`tweets %>% group_by(source) %>% select(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_JTXOXKBTDR" value="answer"></input> <span>`tweets %>% group_by(source) %>% filter(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_JTXOXKBTDR" value="x"></input> <span>`tweets %>% group_by(source) %>% select(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_JTXOXKBTDR" value="x"></input> <span>`tweets %>% group_by(source) %>% filter(count() >= 10)`</span></label></div>

:::

## Putting it together {#together-summary}

For the final step in this chapter, we will create a table of the top five hashtags used in conjunction with #NationalComingOutDay, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag.

The function `select()` is useful for just keeping the variables (columns) you need to work with, which can make working with very large datasets easier. The arguments to `select()` are simply the names of the variables and the resulting table will present them in the order you specify.  


```r
tweets_with_hashtags <- tweets %>%
  select(hashtags, text, favorite_count, media_url)
```

Look at the dataset using `View(tweets_with_hashtags)`. You'll notice that the variable `hashtags` has multiple values in each cell (i.e., when users used more than one hashtag in a single tweet). In order to work with this information, we need to separate each hashtag so that each row of data represents a single hashtag. We can do this using the function `unnest()` and adding a pipeline of code.


```r
tweets_with_hashtags <- tweets %>%
  select(hashtags, text, favorite_count, media_url)%>%
  unnest(cols = hashtags)
```

To get the top 5 hashtags we need to know how tweets used each one This code uses pipes to build up the analysis. When you encounter multi-pipe code, it can be very useful to run each line of the pipeline to see how it builds up and to check the output at each step. This code:

* Starts with the object tweets and then;
* Counts the number of tweets for each hashtag using `count()` and then;
* Filters out any blank cells using `!is.na()` (you can read this as "keep any value that isn't a missing value) and then;
* Returns the top five values using `slice_max()` and orders them by the `n` column.


```r
top5_hashtags <- tweets_with_hashtags %>%
  count(hashtags) %>%
  filter(!is.na(hashtags)) %>%  # get rid of the blank value
  slice_max(order_by = n, n = 5)

top5_hashtags
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> hashtags </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> NationalComingOutDay </td>
   <td style="text-align:right;"> 27308 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 1343 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> LGBTQ </td>
   <td style="text-align:right;"> 829 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> IndigenousPeoplesDay </td>
   <td style="text-align:right;"> 811 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ComingOutDay </td>
   <td style="text-align:right;"> 613 </td>
  </tr>
</tbody>
</table>

</div>

Two of the hashtags are the same, but with different case. We can fix this by adding in an extra line of code that uses `mutate()` to overwrite the variable `hashtag` with the same data but transformed to lower case.


```r
top5_hashtags <- tweets_with_hashtags %>%
  mutate(hashtags = tolower(hashtags)) %>%
  count(hashtags) %>%
  filter(!is.na(hashtags)) %>%  # get rid of the blank value
  slice_max(order_by = n, n = 5)

top5_hashtags
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> hashtags </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 28698 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lgbtq </td>
   <td style="text-align:right;"> 1036 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> indigenouspeoplesday </td>
   <td style="text-align:right;"> 837 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> comingoutday </td>
   <td style="text-align:right;"> 676 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> loveislove </td>
   <td style="text-align:right;"> 396 </td>
  </tr>
</tbody>
</table>

</div>

Next, get the top tweet for each hashtag using `filter()`. Use `group_by()` before you filter to select the most-liked tweet in each hashtag, rather than the one with most likes overall. As you're getting used to writing and running this kind of multi-step code, it can be very useful to take out individual lines and see how it changes the output to strengthen your understanding of what each step is doing.


```r
top_tweet_per_hashtag <- tweets_with_hashtags %>%
  mutate(hashtags = tolower(hashtags)) %>%
  group_by(hashtags) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

Get the total number of likes per hashtag by grouping and summarising with `sum()`.


```r
likes_per_hashtag <- tweets_with_hashtags %>%
  mutate(hashtags = tolower(hashtags)) %>%
  group_by(hashtags) %>%
  summarise(total_likes = sum(favorite_count)) %>%
  ungroup()
```

We can put everything together using `left_join()`. This will keep everything from the first table specified and then add on the relevant data from the second table specified. In this case, we add on the data in `top_tweet_per_hashtag` and `like_per_hashtag` but only for the tweets included in `top5_hashtags`


```r
top5 <- top5_hashtags %>%
  left_join(top_tweet_per_hashtag, by = "hashtags") %>%
  left_join(likes_per_hashtag, by = "hashtags") 
```

Before we can finish up though, there's a couple of extra steps we need to add in to account for some of the idiosyncrasies of Twitter data. 

First,  the `@` symbol is used by R Markdown for referencing (we'll show you how to do this in Chapter \ \@ref(present)). It's likely that some of the tweets will contain this symbol, so we can use mutate to find any instances of `@` and add backslashes. Backslashes create a literal version of characters that have a special meaning in R, so adding them means it will print the `@` symbol without any issues. Of course `\` also has a special meaning in R which means we also need to backslash the backslash. Isn't programming fun? We can use the same code to tidy up any ampersands (&) which sometimes display as "&amp".

Second, if there are multiple images associated with a single tweet, `media_url` will be a list, so we use `unlist()`.

Finally, we use `select()` to tidy up the table and just keep the columns we need.


```r
top5 <- top5_hashtags %>%
  left_join(top_tweet_per_hashtag, by = "hashtags") %>%
  left_join(likes_per_hashtag, by = "hashtags") %>%
  # replace @ with \@ so @ doesn't trigger referencing
  mutate(text = gsub("@", "\\\\@", text),
         text = gsub("&amp;", "&", text)) %>%
  # media_url can be a list if there is more than one image
  mutate(image = unlist(media_url)) %>%
  # put the columns you want to display in order
  select(hashtags, n, total_likes, text, image)

top5
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> hashtags </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total_likes </th>
   <th style="text-align:left;"> text </th>
   <th style="text-align:left;"> image </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 28698 </td>
   <td style="text-align:right;"> 851510 </td>
   <td style="text-align:left;"> it’s #nationalcomingoutday &lt;U+0001F389&gt; here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lgbtq </td>
   <td style="text-align:right;"> 1036 </td>
   <td style="text-align:right;"> 13691 </td>
   <td style="text-align:left;"> It takes bravery to life an authentic life. While I was not able to come out as a member of the #LGBTQ community on my own terms, if you’re ready &amp; can safely do so, then I support you! And if you’re not quite there yet, I support you exactly where you are. #NationalComingOutDay https://t.co/dr61oyhR3L </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBcJiNUXIA4LTmr.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> indigenouspeoplesday </td>
   <td style="text-align:right;"> 837 </td>
   <td style="text-align:right;"> 14073 </td>
   <td style="text-align:left;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBdQIf7UYAQjEAW.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> comingoutday </td>
   <td style="text-align:right;"> 676 </td>
   <td style="text-align:right;"> 6977 </td>
   <td style="text-align:left;"> K—I’m out. Bi &lt;U+0001F44B&gt;&lt;U+0001F3FC&gt;

#ComingOutDay #NationalComingOutDay </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> loveislove </td>
   <td style="text-align:right;"> 396 </td>
   <td style="text-align:right;"> 4033 </td>
   <td style="text-align:left;"> HAPPY NATIONAL COMING OUT DAY!! 

&lt;U+0001F3F3&gt;&lt;U+FE0F&gt;&lt;U+200D&gt;&lt;U+0001F308&gt;&lt;U+2764&gt;&lt;U+FE0F&gt;&lt;U+0001F9E1&gt;&lt;U+0001F49B&gt;&lt;U+0001F49A&gt;&lt;U+0001F499&gt;&lt;U+0001F49C&gt;&lt;U+0001F3F3&gt;&lt;U+FE0F&gt;&lt;U+200D&gt;&lt;U+0001F308&gt;

\@msmadig #OutAndProud #Queer #loveislove #NationalComingOutDay https://t.co/DVfKJsCqNQ </td>
   <td style="text-align:left;"> http://pbs.twimg.com/ext_tw_video_thumb/1447698152463626242/pu/img/pZor72nSNDPn8KiP.jpg </td>
  </tr>
</tbody>
</table>

</div>


Whilst this table now has all the information we want, it isn't great aesthetically. The <code class='package'>kableExtra</code> package has functions that will improve the presentation of tables. We're going to show you two examples of how you could format this table. The first is (relatively) simple and stays within the R programming language, the second incorporates the <a class='glossary' target='_blank' title='Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages.' href='https://psyteachr.github.io/glossary/h#html'>HTML</a>. 


```r
top5 %>%
  kable(
    caption = "Stats and the top tweet for the top five hashtags.") %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(0, angle = -45)
```

<table class=" lightable-paper lightable-striped" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:unnamed-chunk-36)Stats and the top tweet for the top five hashtags.</caption>
 <thead>
  <tr>
   <th style="text-align:left;-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);"> hashtags </th>
   <th style="text-align:right;-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);"> n </th>
   <th style="text-align:right;-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);"> total_likes </th>
   <th style="text-align:left;-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);"> text </th>
   <th style="text-align:left;-webkit-transform: rotate(-45deg); -moz-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);"> image </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 28698 </td>
   <td style="text-align:right;"> 851510 </td>
   <td style="text-align:left;"> it’s #nationalcomingoutday &lt;U+0001F389&gt; here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lgbtq </td>
   <td style="text-align:right;"> 1036 </td>
   <td style="text-align:right;"> 13691 </td>
   <td style="text-align:left;"> It takes bravery to life an authentic life. While I was not able to come out as a member of the #LGBTQ community on my own terms, if you’re ready &amp; can safely do so, then I support you! And if you’re not quite there yet, I support you exactly where you are. #NationalComingOutDay https://t.co/dr61oyhR3L </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBcJiNUXIA4LTmr.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> indigenouspeoplesday </td>
   <td style="text-align:right;"> 837 </td>
   <td style="text-align:right;"> 14073 </td>
   <td style="text-align:left;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBdQIf7UYAQjEAW.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> comingoutday </td>
   <td style="text-align:right;"> 676 </td>
   <td style="text-align:right;"> 6977 </td>
   <td style="text-align:left;"> K—I’m out. Bi &lt;U+0001F44B&gt;&lt;U+0001F3FC&gt;

#ComingOutDay #NationalComingOutDay </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> loveislove </td>
   <td style="text-align:right;"> 396 </td>
   <td style="text-align:right;"> 4033 </td>
   <td style="text-align:left;"> HAPPY NATIONAL COMING OUT DAY!! 

&lt;U+0001F3F3&gt;&lt;U+FE0F&gt;&lt;U+200D&gt;&lt;U+0001F308&gt;&lt;U+2764&gt;&lt;U+FE0F&gt;&lt;U+0001F9E1&gt;&lt;U+0001F49B&gt;&lt;U+0001F49A&gt;&lt;U+0001F499&gt;&lt;U+0001F49C&gt;&lt;U+0001F3F3&gt;&lt;U+FE0F&gt;&lt;U+200D&gt;&lt;U+0001F308&gt;

\@msmadig #OutAndProud #Queer #loveislove #NationalComingOutDay https://t.co/DVfKJsCqNQ </td>
   <td style="text-align:left;"> http://pbs.twimg.com/ext_tw_video_thumb/1447698152463626242/pu/img/pZor72nSNDPn8KiP.jpg </td>
  </tr>
</tbody>
</table>


First, we'll combine the first three columns into a single column and add some <a class='glossary' target='_blank' title='Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages.' href='https://psyteachr.github.io/glossary/h#html'>HTML</a> formatting to make the hashtag bold (`<strong>`) and insert line breaks (`<br>`). We'll also change the image column to display the image using html if there is an image.


```r
top5 %>%
  mutate(col1 = glue("<strong>#{hashtags}</strong>
                     <br>
                     tweets: {n}
                     <br>
                     likes: {total_likes}"),
         img = ifelse(!is.na(image),
                      glue("<img src='{image}' width='200px' />"),
                      "")) %>%
  select(col1, text, img) %>%
  kable(
    escape = FALSE, # allows HTML in the table
    col.names = c("Hashtag", "Top Tweet", ""),
    caption = "Stats and the top tweet for the top five hashtags.") %>%
  column_spec(1:2, extra_css = "vertical-align: top;") %>%
  row_spec(0, extra_css = "vertical-align: bottom;") %>%
  kable_paper()
```

## Glossary {#glossary-summary}

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:left;"> definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> [html](https://psyteachr.github.io/glossary/h.html#html){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> [quantile](https://psyteachr.github.io/glossary/q.html#quantile){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> Cutoffs dividing the range of a distribution into continuous intervals with equal probabilities. </td>
  </tr>
</tbody>
</table>



## Further resources {#resources-summary}

* [Data transformation cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf)
* [Chapter 5: Data Transformation ](http://r4ds.had.co.nz/transform.html) in *R for Data Science*
* [Intro to rtweet](https://docs.ropensci.org/rtweet/articles/rtweet.html)
* 