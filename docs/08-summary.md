# Data Summaries {#summary}

## Intended Learning Outcomes {#ilo-summary}

* Summarise data by groups
* Produce well-formatted tables


```r
library(tidyverse)   # data wrangling functions
library(rtweet) # for searching tweets
library(kableExtra)  # for nice tables
library(glue) # for pasting strings
```


## Summary functions

We'll use the `search_tweets()` function from <code class='package'>rtweet</code> to find the last (up to) 30K tweets from the past 6-9 days (this depends on Twitter) with the hashtag #NationalComingOutDay.


```r
tweets <- search_tweets(q = "#NationalComingOutDay", 
                        n = 30000, 
                        include_rts = FALSE)
# saveRDS(tweets, file = "data/ncod_tweets.rds")
```

This is mainly interesting around October 11th, so we've provided the relevant data for you that we scraped then, although you can follow along with any hashtag that interests you. 


```r
tweets <- readRDS("data/ncod_tweets.rds")
```

First, run `glimpse(tweets)` to find out what information is in the downloaded data. Now let's create a series of summary tables and plots with these data.

### Summarise

The `summarise()` function creates summary statistics for the data table. Check the [Data Transformation Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf) for various summary functions. Some common ones are: `n()`, `min()`, `max()`, `sum()`, `mean()`, and `quantile()`.

This function can be used to answer questions like: How many tweets were there? What date range is represented in these data? What are the mean and median number of favourites per tweet?

The `n()` function counts the number of rows in the data. The `created_at` column gives us the date each tweet were created, so we can use the `min()` and `max()` functions to get the range of dates. The `favorite_count` column gives us the number of times each tweet was favourited.


```r
tweet_summary <- tweets %>%
  summarise(
    n = n(),
    min_date = min(created_at),
    max_date = max(created_at),
    avg_favs = mean(favorite_count),
    median_favs = quantile(favorite_count, .5)
  )

glimpse(tweet_summary)
```

```
## Rows: 1
## Columns: 5
## $ n           <int> 28626
## $ min_date    <dttm> 2021-10-10 00:10:02
## $ max_date    <dttm> 2021-10-12 20:12:27
## $ avg_favs    <dbl> 29.71732
## $ median_favs <dbl> 3
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

There are a few ways to insert those values into the text of a report. First, you can use `glue()` to create a block of text that uses the objects you just created. Use the `format()` function to format the dates for our report.


```r
date_from <- tweet_summary$min_date %>% format("%d %B, %Y")
date_to <- tweet_summary$max_date %>% format("%d %B, %Y")

text <- glue("There were {tweet_summary$n} tweets between {date_from} and {date_to}.")
```

Then you can display that text in an <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> report with inline r like this, <code>&#096;r text&#096;</code>, which will produce the following:

> There were 28626 tweets between 10 October, 2021 and 12 October, 2021.

Or you can insert individual objects into markdown text with inline r:

There were <code>&#096;r tweet_summary\$n&#096;</code> tweets between <code>&#096;r date_from&#096;</code> and <code>&#096;r date_to&#096;</code>.




::: {.try data-latex=""}
* How would you find the largest number of retweets?
    <div class='webex-radiogroup' id='radio_BVAWFNJRVB'><label><input type="radio" autocomplete="off" name="radio_BVAWFNJRVB" value="x"></input> <span>`tweets %>% summarise(max = retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_BVAWFNJRVB" value="x"></input> <span>`tweets %>% max(retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_BVAWFNJRVB" value="x"></input> <span>`tweets %>% summarise(max_retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_BVAWFNJRVB" value="answer"></input> <span>`tweets %>% summarise(max_retweets = max(retweets))`</span></label></div>

* How would you calculate the mean `display_text_width`? 
    <div class='webex-radiogroup' id='radio_JCHDOGUYGJ'><label><input type="radio" autocomplete="off" name="radio_JCHDOGUYGJ" value="x"></input> <span>`width(mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_JCHDOGUYGJ" value="x"></input> <span>`summarise(display_text_width = mean)`</span></label><label><input type="radio" autocomplete="off" name="radio_JCHDOGUYGJ" value="x"></input> <span>`group_by(display_text_width)`</span></label><label><input type="radio" autocomplete="off" name="radio_JCHDOGUYGJ" value="answer"></input> <span>`summarise(width = mean(display_text_width))`</span></label></div>

:::

### Counting

How many different accounts tweeted? Who tweeted most?

You can count categories with the `count()` function. Since each row is a tweet, you can count the number of rows per `screen_name` to get the number of tweets per user. This will give you a new table with each combination of the counted columns and a column called `n` containing the number of observations from that group. Set `sort = TRUE` to sort the table by `n` in descending order.


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

If you set a code chunk option to `results='asis'`, you can pipe the glued text to `cat()` to display it.


```r
unique_users <- nrow(tweets_per_user)
most_prolific <- slice(tweets_per_user, 1) %>% pull(screen_name)
most_prolific_n <- slice(tweets_per_user, 1) %>% pull(n)

glue("There were {unique_users} unique accounts 
     tweeting about #NationalComingOutDay. 
     {most_prolific} was the most prolific tweeter, 
     with {most_prolific_n} tweets.") %>% cat()
```

There were 25189 unique accounts 
tweeting about #NationalComingOutDay. 
interest_outfit was the most prolific tweeter, 
with 35 tweets.




::: {.try data-latex=""}
* How would you count the number of tweets that are quotes or not and are retweets or not? 
    <div class='webex-radiogroup' id='radio_XGEGHKSSNF'><label><input type="radio" autocomplete="off" name="radio_XGEGHKSSNF" value="answer"></input> <span>`tweets %>% count(is_quote, is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_XGEGHKSSNF" value="x"></input> <span>`tweets %>% count(c(is_quote, is_retweet))`</span></label><label><input type="radio" autocomplete="off" name="radio_XGEGHKSSNF" value="x"></input> <span>`tweets %>% count(is_quote) %>% count(is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_XGEGHKSSNF" value="x"></input> <span>`tweets %>% select(is_quote, is_retweet) %>% count()`</span></label></div>

:::

### Grouping

You can also create other summary values by group. 

The `lang` column tells us what language the tweet was in. How did the average number of favourites and retweets differ by language?


```r
lang <- tweets %>%
  group_by(lang) %>%
  summarise(count = n(),
            mean_favs = mean(favorite_count),
            mean_retweets = mean(retweet_count)) %>%
  ungroup() %>%
  arrange(desc(mean_favs))

head(lang)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> lang </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:right;"> mean_favs </th>
   <th style="text-align:right;"> mean_retweets </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> cs </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 244.60000 </td>
   <td style="text-align:right;"> 7.2000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tr </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 40.60000 </td>
   <td style="text-align:right;"> 0.2000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> en </td>
   <td style="text-align:right;"> 25896 </td>
   <td style="text-align:right;"> 31.41169 </td>
   <td style="text-align:right;"> 3.3210534 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> th </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 23.63636 </td>
   <td style="text-align:right;"> 31.6363636 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tl </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 23.53191 </td>
   <td style="text-align:right;"> 0.9148936 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ja </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 23.34524 </td>
   <td style="text-align:right;"> 2.2857143 </td>
  </tr>
</tbody>
</table>

</div>

::: {.warning data-latex=""}
If you get the following message, please update tidyverse.

> `summarise()` ungrouping output (override with `.groups` argument)
:::





::: {.try data-latex=""}
* What would you change to calculate the mean favourites and retweets by `screen_name` instead of by `source`? 
    <div class='webex-radiogroup' id='radio_PMWYZOUGQN'><label><input type="radio" autocomplete="off" name="radio_PMWYZOUGQN" value="x"></input> <span>`summarise(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_PMWYZOUGQN" value="answer"></input> <span>`group_by(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_PMWYZOUGQN" value="x"></input> <span>`mean(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_PMWYZOUGQN" value="x"></input> <span>`count(screen_name)`</span></label></div>

:::

You can use functions like `filter()` or `mutate()` after `group_by`. 



### Filtering

What was the most favourited original and quoted tweet? Group by `is_quote` and use `filter()` to keep just the rows where the value in the `favorite_count` column is equal to its maximum value. Just in case there was a tie, choose a random one with `sample_n(size = 1)`.


```r
most_fav <- tweets %>%
  group_by(is_quote) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

::: {.warning data-latex=""}
Make sure you call the `ungroup()` function when you are done with grouped functions. Failing to do this can cause all sorts of mysterious problems if you use that data table later assuming it isn't grouped.
:::

Remember that you can access the value in each column with the `$` operator. 


```r
orig <- filter(most_fav, !is_quote)

glue("
The most favourited ({orig$favorite_count}) original tweet was by 
[{orig$screen_name}]({orig$status_url}):

--------------------------------------------------
{orig$text}

![]({orig$ext_media_url}){{width='100%'}}
--------------------------------------------------
") %>% 
  # prints results into document, not as code
  cat()
```

The most favourited (22935) original tweet was by 
[jackrooke](https://twitter.com/jackrooke/status/1447541093260795904):

--------------------------------------------------
it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4

![](http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg){width='100%'}
--------------------------------------------------


```r
quote <- filter(most_fav, is_quote)

glue("
The most favourited ({quote$favorite_count}) quote tweet was by 
[{quote$screen_name}]({quote$status_url}):

--------------------------------------------------
{quote$text}
--------------------------------------------------
") %>% 
  # prints results into document, not as code
  cat()
```

The most favourited (1012) quote tweet was by 
[albinokid](https://twitter.com/albinokid/status/1447605078140010502):

--------------------------------------------------
I’ve been a comic book geek since pretty much the time I could first read. This news about Superman makes my queer heart glad, knowing the positive impact it will have on so many young folks today &amp; in the future. Happy #NationalComingOutDay https://t.co/G2rEegwOYX
--------------------------------------------------




::: {.try data-latex=""}
* How would you limit the results to sources with 10 or more rows?
    <div class='webex-radiogroup' id='radio_OEJYDVQOFN'><label><input type="radio" autocomplete="off" name="radio_OEJYDVQOFN" value="x"></input> <span>`tweets %>% group_by(source) %>% select(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_OEJYDVQOFN" value="x"></input> <span>`tweets %>% group_by(source) %>% select(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_OEJYDVQOFN" value="x"></input> <span>`tweets %>% group_by(source) %>% filter(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_OEJYDVQOFN" value="answer"></input> <span>`tweets %>% group_by(source) %>% filter(n() >= 10)`</span></label></div>

:::


## Putting it together {#together-summary}

Let's make a table of the top five hashtags used in conjunction with #NationalComingOutDay, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag.

First, select just the relevant columns and expand the `hashtags` column. This is a column of lists, so you can create a row for each value using `unnest()`.


```r
tweets_with_hashtags <- tweets %>%
  select(hashtags, text, favorite_count, media_url) %>%
  unnest(cols = hashtags)
```

Now, count the number of tweets for each hashtag using `count()`, then get the top five values using `slice_max()` and ordering by the `n` column.


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

Two of the hashtags are the same, but with different case. We can fix this by grouping by the lowercase version of the hashtag instead, using the `tolower()` function.


```r
top5_hashtags <- tweets_with_hashtags %>%
  count(hashtags = tolower(hashtags)) %>%
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


Next, get the top tweet for each hashtag using `filter()`. Use `group_by()` before you filter to select the most-liked tweet in each hashtag, rather than the one with most likes overall. Don't forget to group by the lowercase version and `ungroup()` when you're done.


```r
top_tweet_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags = tolower(hashtags)) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

Get the total number of likes per hashtag by grouping and summarising with `sum()`.


```r
likes_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags = tolower(hashtags)) %>%
  summarise(total_likes = sum(favorite_count)) %>%
  ungroup()
```


Finally, put everything together using `left_join()`, `select()` the columns you want to keep in the right order, and print the table.


```r
top5 <- top5_hashtags %>%
  left_join(top_tweet_per_hashtag, by = "hashtags") %>%
  left_join(likes_per_hashtag, by = "hashtags") %>%
  # replace @ with \@ so @ doesn't trigger referencing
  mutate(text = gsub("@", "\\\\@", text)) %>%
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
   <td style="text-align:left;"> it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
   <td style="text-align:left;"> http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lgbtq </td>
   <td style="text-align:right;"> 1036 </td>
   <td style="text-align:right;"> 13691 </td>
   <td style="text-align:left;"> It takes bravery to life an authentic life. While I was not able to come out as a member of the #LGBTQ community on my own terms, if you’re ready &amp;amp; can safely do so, then I support you! And if you’re not quite there yet, I support you exactly where you are. #NationalComingOutDay https://t.co/dr61oyhR3L </td>
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
   <td style="text-align:left;"> K—I’m out. Bi 👋🏼

#ComingOutDay #NationalComingOutDay </td>
   <td style="text-align:left;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> loveislove </td>
   <td style="text-align:right;"> 396 </td>
   <td style="text-align:right;"> 4033 </td>
   <td style="text-align:left;"> HAPPY NATIONAL COMING OUT DAY!! 

🏳️‍🌈❤️🧡💛💚💙💜🏳️‍🌈

\@msmadig #OutAndProud #Queer #loveislove #NationalComingOutDay https://t.co/DVfKJsCqNQ </td>
   <td style="text-align:left;"> http://pbs.twimg.com/ext_tw_video_thumb/1447698152463626242/pu/img/pZor72nSNDPn8KiP.jpg </td>
  </tr>
</tbody>
</table>

</div>

The table isn't great, aesthetically. The <code class='package'>kableExtra</code> package has functions that will improve the presentation of tables. First, we'll combine the first three columns into a single column and add some <a class='glossary' target='_blank' title='Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages.' href='https://psyteachr.github.io/glossary/h#html'>HTML</a> formatting to make the hashtag bold (`<strong>`) and insert line breaks (`<br>`). We'll also change the image column to display the image using html if there is an image.


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

<table class=" lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:unnamed-chunk-22)Stats and the top tweet for the top five hashtags.</caption>
 <thead>
  <tr>
   <th style="text-align:left;vertical-align: bottom;"> Hashtag </th>
   <th style="text-align:left;vertical-align: bottom;"> Top Tweet </th>
   <th style="text-align:left;vertical-align: bottom;">  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: top;"> <strong>#nationalcomingoutday</strong>
<br>
tweets: 28698
<br>
likes: 851510 </td>
   <td style="text-align:left;vertical-align: top;"> it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
   <td style="text-align:left;"> <img src="http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg" width="200px"> </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> <strong>#lgbtq</strong>
<br>
tweets: 1036
<br>
likes: 13691 </td>
   <td style="text-align:left;vertical-align: top;"> It takes bravery to life an authentic life. While I was not able to come out as a member of the #LGBTQ community on my own terms, if you’re ready &amp; can safely do so, then I support you! And if you’re not quite there yet, I support you exactly where you are. #NationalComingOutDay https://t.co/dr61oyhR3L </td>
   <td style="text-align:left;"> <img src="http://pbs.twimg.com/media/FBcJiNUXIA4LTmr.jpg" width="200px"> </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> <strong>#indigenouspeoplesday</strong>
<br>
tweets: 837
<br>
likes: 14073 </td>
   <td style="text-align:left;vertical-align: top;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
   <td style="text-align:left;"> <img src="http://pbs.twimg.com/media/FBdQIf7UYAQjEAW.jpg" width="200px"> </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> <strong>#comingoutday</strong>
<br>
tweets: 676
<br>
likes: 6977 </td>
   <td style="text-align:left;vertical-align: top;"> K—I’m out. Bi 👋🏼

#ComingOutDay #NationalComingOutDay </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> <strong>#loveislove</strong>
<br>
tweets: 396
<br>
likes: 4033 </td>
   <td style="text-align:left;vertical-align: top;"> HAPPY NATIONAL COMING OUT DAY!! 

🏳️‍🌈❤️🧡💛💚💙💜🏳️‍🌈

\@msmadig #OutAndProud #Queer #loveislove #NationalComingOutDay https://t.co/DVfKJsCqNQ </td>
   <td style="text-align:left;"> <img src="http://pbs.twimg.com/ext_tw_video_thumb/1447698152463626242/pu/img/pZor72nSNDPn8KiP.jpg" width="200px"> </td>
  </tr>
</tbody>
</table>

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
  <tr>
   <td style="text-align:left;"> [r markdown](https://psyteachr.github.io/glossary/r.html#r-markdown){class="glossary" target="_blank"} </td>
   <td style="text-align:left;"> The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code. </td>
  </tr>
</tbody>
</table>



## Further resources {#resources-summary}

* [Data transformation cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-transformation.pdf)
* [Chapter 5: Data Transformation ](http://r4ds.had.co.nz/transform.html) in *R for Data Science*
