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

We'll use the `search_tweets()` function from <code class='package'>rtweet</code> to find the last (up to) 10K tweets from the past 6-9 days (this depends on Twitter) with the hashtag #BisexualAwarenessWeek or #BiWeek. Some of these will be duplicates, so we'll combine them with `union()`.


```r
bi_aware <- search_tweets(q = "#BisexualAwarenessWeek", 
                         n = 10000, 
                         include_rts = FALSE)

bi_week <- search_tweets(q = "#BiWeek", 
                         n = 10000, 
                         include_rts = FALSE)

# combine, excluding duplicates
bi_tweets <- union(bi_aware, bi_week)
```




Now let's create a series of summary tables and plots with these data.

### General info

What date range is represented in these data? How many tweets were there? First, run `glimpse(bi_tweets)` to find out what information is in the downloaded data. 

The `created_at` column should give us the date they were created. We can use the `min()` and `max()` functions to get the range of dates, and the `format()` function to format them for our report.


```r
n_tweets <- nrow(bi_tweets)
date_from <- min(bi_tweets$created_at) %>% format("%d %B, %Y")
date_to <- max(bi_tweets$created_at) %>% format("%d %B, %Y")
```

There are a few ways to insert those values into the text of a report. First, you can use `glue()` to create a block of text that uses the objects you just created.


```r
text <- glue("There were {n_tweets} tweets between {date_from} and {date_to}.")
```

Then you can display that text in an <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a> report with inline r like this, <code>&#096;r text&#096;</code>, which will produce the following:

> There were 2034 tweets between 17 September, 2021 and 26 September, 2021.

Or you can insert individual objects into markdown text with inline r:

There were <code>&#096;r n_tweets&#096;</code> tweets between <code>&#096;r date_from&#096;</code> and <code>&#096;r date_to&#096;</code>.

### Summary counts

How many different accounts tweeted? Who tweeted most?

You can count categories with the `count()` function. It looks like two accounts might have the same screen name, but they probably won't have the same user_id, so you can count both of those things. This will give you a new table with each combination of the counted columns and a column called `n` containing the number of observations from that group. Use `arrange(desc(n))` to sort the table by `n` in descending order.


```r
tweets_per_user <- count(bi_tweets, user_id, screen_name) %>%
  arrange(desc(n))

head(tweets_per_user)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> user_id </th>
   <th style="text-align:left;"> screen_name </th>
   <th style="text-align:right;"> n </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 282143568 </td>
   <td style="text-align:left;"> BRC_Central </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 34575609 </td>
   <td style="text-align:left;"> bisexualindex </td>
   <td style="text-align:right;"> 22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3236295640 </td>
   <td style="text-align:left;"> LarkerAnthology </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 363529473 </td>
   <td style="text-align:left;"> JuliaSerano </td>
   <td style="text-align:right;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2906537919 </td>
   <td style="text-align:left;"> BPSSexualities </td>
   <td style="text-align:right;"> 13 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1043866252224020480 </td>
   <td style="text-align:left;"> pupkasarianlan </td>
   <td style="text-align:right;"> 12 </td>
  </tr>
</tbody>
</table>

</div>

If you set a code chunk option to `results='asis'`, you can pipe the glued text to `cat()` to display it.


```r
unique_users <- nrow(tweets_per_user)
most_prolific <- slice(tweets_per_user, 1) %>% pull(screen_name)
most_prolific_n <- slice(tweets_per_user, 1) %>% pull(n)

glue("There were {unique_users} unique accounts tweeting about Bisexual Awareness Week. {most_prolific} was the most prolific tweeter, with {most_prolific_n} tweets.") %>% cat()
```

There were 1399 unique accounts tweeting about Bisexual Awareness Week. BRC_Central was the most prolific tweeter, with 25 tweets.

### Filtering

What was the most favourited tweets? Use `filter()` to keep just the rows where the value in the `favorite_count` column is equal to its maximum value. Just in case there is a tie, choose a random one with `sample_n(size = 1)`.


```r
most_fav <- bi_tweets %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1)
```

You can access the value in each column with the `$` operator. 


```r
glue("
The most favourited ({most_fav$favorite_count}) tweet was by 
[{most_fav$screen_name}]({most_fav$status_url}):
-----------------------
{most_fav$text}
![]({most_fav$media_url})
-----------------------
") %>% cat()
```

The most favourited (2911) tweet was by 
[cassieclare](https://twitter.com/cassieclare/status/1441073997744062467):
-----------------------
Matthew would like to wish all bisexual Shadowhunters a very happy #BiWeek 

He will be celebrating you all day, today and every day 💕💕💕
#CelebrateBisexualityDay

Amazing Matthew image by @WcLasq https://t.co/cb1TcdOq83
![](http://pbs.twimg.com/media/E_-3yJuXsAEGOqz.jpg)
-----------------------

### Summary Table

Let's make a table of the top ten hashtags used in conjunction with #BiVisibilityWeek, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag.

First, select just the relevant columns and expand the `hashtags` column. This is a column of lists, so you can create a row for each value using `unnest()`.


```r
tweets_with_hashtags <- bi_tweets %>%
  select(hashtags, text, favorite_count) %>%
  unnest(cols = hashtags)
```

Now, count the number of tweets for each hashtag using `count()`, then filter the top 10 values by the `n` column.


```r
top10_hashtags <- tweets_with_hashtags %>%
  count(hashtags) %>%
  slice_max(order_by = n, n = 10)
```

Next, get the top tweet for each hashtag using `filter()`. Use `group_by()` before you filter to select the most-liked tweet in each hashtag, rather than the one most-likes overall. Don't forget to `ungroup()` when you're done.


```r
top_tweet_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

Get the total number of likes per hashtag by grouping and summarising with `sum()`.


```r
likes_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags) %>%
  summarise(total_likes = sum(favorite_count)) %>%
  ungroup()
```


Finally, put everything together using `left_join()`, `select()` the columns you want to keep in the right order, and print the table.


```r
top10 <- top10_hashtags %>%
  left_join(top_tweet_per_hashtag, by = "hashtags") %>%
  left_join(likes_per_hashtag, by = "hashtags") %>%
  select(hashtags, n, total_likes, text) %>%
  print()
```

```
## # A tibble: 10 × 4
##    hashtags                  n total_likes text                                 
##    <chr>                 <int>       <int> <chr>                                
##  1 BiWeek                 1377       35291 "Matthew would like to wish all bise…
##  2 BisexualAwarenessWeek   336        7577 "As it's #BisexualAwarenessWeek, I'm…
##  3 BiVisibilityDay         282        6967 "バイセクシュアルの娘の幸せと、向き… 
##  4 bisexualawarenessweek   219        2523 "This #bisexualawarenessweek remembe…
##  5 biweek                  185        2590 "You are valid 💗💜💙 art by @sheisr…
##  6 bisexual                109        5364 "Did you know that #bisexuality is a…
##  7 LGBTQ                    78         799 "Although bisexual+ people make up t…
##  8 BiVisibilityWeek         66         613 "HI, PLEASE SPREAD THIS!\n\nI don't …
##  9 BiWeek2021               62         347 "Happy Bi Visibility Week!\n\nI see …
## 10 BiAwarenessWeek          58        2699 "As a bi women, I want to send a mes…
```

The table isn't great, aesthetically. The <code class='package'>kableExtra</code> package has functions that will improve the presentation of tables.


```r
kable(x = top10, 
      col.names = c("Hashtag", "Total Tweets", "Total Likes", "Top Tweet"),
      caption = "Stats and the top tweet for the top 10 hashtags.") %>%
  column_spec(1:4, extra_css = "vertical-align: top;") %>%
  row_spec(0, extra_css = "vertical-align: bottom;") %>%
  kable_minimal()
```

<table class=" lightable-minimal" style='font-family: "Trebuchet MS", verdana, sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:unnamed-chunk-14)Stats and the top tweet for the top 10 hashtags.</caption>
 <thead>
  <tr>
   <th style="text-align:left;vertical-align: bottom;"> Hashtag </th>
   <th style="text-align:right;vertical-align: bottom;"> Total Tweets </th>
   <th style="text-align:right;vertical-align: bottom;"> Total Likes </th>
   <th style="text-align:left;vertical-align: bottom;"> Top Tweet </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BiWeek </td>
   <td style="text-align:right;vertical-align: top;"> 1377 </td>
   <td style="text-align:right;vertical-align: top;"> 35291 </td>
   <td style="text-align:left;vertical-align: top;"> Matthew would like to wish all bisexual Shadowhunters a very happy #BiWeek 

He will be celebrating you all day, today and every day 💕💕💕
#CelebrateBisexualityDay

Amazing Matthew image by @WcLasq https://t.co/cb1TcdOq83 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BisexualAwarenessWeek </td>
   <td style="text-align:right;vertical-align: top;"> 336 </td>
   <td style="text-align:right;vertical-align: top;"> 7577 </td>
   <td style="text-align:left;vertical-align: top;"> As it's #BisexualAwarenessWeek, I'm taking a big personal step.

I am bisexual.

#comingout </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BiVisibilityDay </td>
   <td style="text-align:right;vertical-align: top;"> 282 </td>
   <td style="text-align:right;vertical-align: top;"> 6967 </td>
   <td style="text-align:left;vertical-align: top;"> バイセクシュアルの娘の幸せと、向き合おうと思った私の話　#パレットーク #Bisexualawarenessweek #BiVisibilityDay #Bivisibilityday2021 https://t.co/lYNduuXw2q </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> bisexualawarenessweek </td>
   <td style="text-align:right;vertical-align: top;"> 219 </td>
   <td style="text-align:right;vertical-align: top;"> 2523 </td>
   <td style="text-align:left;vertical-align: top;"> This #bisexualawarenessweek remember these things!

Bisexuality is not Transphobic

It is valid no matter who you've been with

You can have a preference and still be bi

It is up to the person and not you </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> biweek </td>
   <td style="text-align:right;vertical-align: top;"> 185 </td>
   <td style="text-align:right;vertical-align: top;"> 2590 </td>
   <td style="text-align:left;vertical-align: top;"> You are valid 💗💜💙 art by @sheisrecovering 🎨
If you're in crisis, we're here 24/7 to support you at: 866.488.7386 or text/chat https://t.co/hxtScqt870 📲
#bi #biweek https://t.co/Ux23L1iIpC </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> bisexual </td>
   <td style="text-align:right;vertical-align: top;"> 109 </td>
   <td style="text-align:right;vertical-align: top;"> 5364 </td>
   <td style="text-align:left;vertical-align: top;"> Did you know that #bisexuality is a distinct sexual orientation? People who identify as #bisexual are not half-straight nor half-gay – they are all bi!
#BiWeek #BiVisibility

Learn more about bisexuality:
https://t.co/0N5G1uLigF https://t.co/whUBU6GVCw </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> LGBTQ </td>
   <td style="text-align:right;vertical-align: top;"> 78 </td>
   <td style="text-align:right;vertical-align: top;"> 799 </td>
   <td style="text-align:left;vertical-align: top;"> Although bisexual+ people make up the largest contingent of the #LGBTQ community, they are the least likely to come out of the closet. A new resource guide from the @HRC aims to change that. #BiWeek #BiVisibilityDay https://t.co/qsxnHXXYV8 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BiVisibilityWeek </td>
   <td style="text-align:right;vertical-align: top;"> 66 </td>
   <td style="text-align:right;vertical-align: top;"> 613 </td>
   <td style="text-align:left;vertical-align: top;"> HI, PLEASE SPREAD THIS!

I don't know if im exactly allowed to post in these tags but the Unicode symbol for bisexual hasn't been added!

This can also double as the mspec symbol! Please spread this!

#BiPrideMonth #BiVisibilityWeek #BiWeek #bitwt https://t.co/aScEMk9cZD </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BiWeek2021 </td>
   <td style="text-align:right;vertical-align: top;"> 62 </td>
   <td style="text-align:right;vertical-align: top;"> 347 </td>
   <td style="text-align:left;vertical-align: top;"> Happy Bi Visibility Week!

I see you!

#BiWeek #BiWeek2021 https://t.co/7tvHvJHVzs </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> BiAwarenessWeek </td>
   <td style="text-align:right;vertical-align: top;"> 58 </td>
   <td style="text-align:right;vertical-align: top;"> 2699 </td>
   <td style="text-align:left;vertical-align: top;"> As a bi women, I want to send a message of solidarity this #BiAwarenessWeek.

Sadly, so many people still face biphobia and inappropriate questions and assumptions about their sexuality and identity.

So happy #BiWeek - your annual reminder we exist✊🌈 https://t.co/6IGN5XQR1C </td>
  </tr>
</tbody>
</table>

