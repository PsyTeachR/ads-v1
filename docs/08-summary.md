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


Now let's create a series of summary tables and plots with these data.

### Summarising

What date range is represented in these data? How many tweets were there? First, run `glimpse(tweets)` to find out what information is in the downloaded data. 

The `created_at` column should give us the date they were created. We can use the `min()` and `max()` functions to get the range of dates. The `n()` function counts the number of rows in the data.


```r
tweet_summary <- tweets %>%
  summarise(
    n = n(),
    min_date = min(created_at),
    max_date = max(created_at)
  )

tweet_summary
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> n </th>
   <th style="text-align:left;"> min_date </th>
   <th style="text-align:left;"> max_date </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 28626 </td>
   <td style="text-align:left;"> 2021-10-10 00:10:02 </td>
   <td style="text-align:left;"> 2021-10-12 20:12:27 </td>
  </tr>
</tbody>
</table>

</div>


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
    <div class='webex-radiogroup' id='radio_ZHQPYMFWHS'><label><input type="radio" autocomplete="off" name="radio_ZHQPYMFWHS" value="x"></input> <span>`tweets %>% summarise(max_retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_ZHQPYMFWHS" value="answer"></input> <span>`tweets %>% summarise(max_retweets = max(retweets))`</span></label><label><input type="radio" autocomplete="off" name="radio_ZHQPYMFWHS" value="x"></input> <span>`tweets %>% summarise(max = retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_ZHQPYMFWHS" value="x"></input> <span>`tweets %>% max(retweets)`</span></label></div>

* How would you calculate the mean `display_text_width`? 
    <div class='webex-radiogroup' id='radio_SQXFMRBOLM'><label><input type="radio" autocomplete="off" name="radio_SQXFMRBOLM" value="answer"></input> <span>`summarise(width = mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_SQXFMRBOLM" value="x"></input> <span>`group_by(display_text_width)`</span></label><label><input type="radio" autocomplete="off" name="radio_SQXFMRBOLM" value="x"></input> <span>`width(mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_SQXFMRBOLM" value="x"></input> <span>`summarise(display_text_width = mean)`</span></label></div>

:::


### Grouping

You can also create summary values by group. The `source` column tells us where the tweet came from. How did the average number of favourites and retweets differ by source?


```r
sources <- tweets %>%
  group_by(source) %>%
  summarise(mean_favs = mean(favorite_count),
            mean_retweets = mean(retweet_count)) %>%
  arrange(desc(mean_favs))

head(sources)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> source </th>
   <th style="text-align:right;"> mean_favs </th>
   <th style="text-align:right;"> mean_retweets </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Twitter Media Studio </td>
   <td style="text-align:right;"> 388.97561 </td>
   <td style="text-align:right;"> 66.92683 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Khoros Publishing App </td>
   <td style="text-align:right;"> 139.08333 </td>
   <td style="text-align:right;"> 19.83333 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SocialFlow </td>
   <td style="text-align:right;"> 115.58824 </td>
   <td style="text-align:right;"> 25.47059 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Emplifi </td>
   <td style="text-align:right;"> 109.33333 </td>
   <td style="text-align:right;"> 9.00000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TW Blue </td>
   <td style="text-align:right;"> 90.00000 </td>
   <td style="text-align:right;"> 9.00000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sprinklr </td>
   <td style="text-align:right;"> 88.98438 </td>
   <td style="text-align:right;"> 12.60938 </td>
  </tr>
</tbody>
</table>

</div>




::: {.try data-latex=""}
* What would you change to calculate the mean favourites and retweets by `screen_name` instead of by `source`? 
    <div class='webex-radiogroup' id='radio_QILKGNDAVZ'><label><input type="radio" autocomplete="off" name="radio_QILKGNDAVZ" value="answer"></input> <span>`group_by(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_QILKGNDAVZ" value="x"></input> <span>`count(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_QILKGNDAVZ" value="x"></input> <span>`mean(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_QILKGNDAVZ" value="x"></input> <span>`summarise(screen_name)`</span></label></div>

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
    <div class='webex-radiogroup' id='radio_MHECRRYEWC'><label><input type="radio" autocomplete="off" name="radio_MHECRRYEWC" value="answer"></input> <span>`tweets %>% count(is_quote, is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_MHECRRYEWC" value="x"></input> <span>`tweets %>% count(is_quote) %>% count(is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_MHECRRYEWC" value="x"></input> <span>`tweets %>% count(c(is_quote, is_retweet))`</span></label><label><input type="radio" autocomplete="off" name="radio_MHECRRYEWC" value="x"></input> <span>`tweets %>% select(is_quote, is_retweet) %>% count()`</span></label></div>

:::

### Filtering

What was the most favourited tweet? Use `filter()` to keep just the rows where the value in the `favorite_count` column is equal to its maximum value. Just in case there was a tie, choose a random one with `sample_n(size = 1)`.


```r
most_fav <- tweets %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1)
```

Remember that you can access the value in each column with the `$` operator. 


```r
glue("
The most favourited ({most_fav$favorite_count}) tweet was by 
[{most_fav$screen_name}]({most_fav$status_url}):

--------------------------------------------------
{most_fav$text}

![]({most_fav$ext_media_url}){{width='100%'}}
--------------------------------------------------
") %>% 
  # replace @ with \@ so @ doesn't trigger referencing
  gsub("@", "\\\\@", .) %>%
  # prints results into document, not as code
  cat()
```

The most favourited (22935) tweet was by 
[jackrooke](https://twitter.com/jackrooke/status/1447541093260795904):

--------------------------------------------------
it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4

![](http://pbs.twimg.com/media/FBayvGYXsAY-5hZ.jpg){width='100%'}
--------------------------------------------------




::: {.try data-latex=""}
* How would you limit the results to sources with 10 or more rows?
    <div class='webex-radiogroup' id='radio_EPUWJAYNDU'><label><input type="radio" autocomplete="off" name="radio_EPUWJAYNDU" value="x"></input> <span>`tweets %>% group_by(source) %>% select(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_EPUWJAYNDU" value="x"></input> <span>`tweets %>% group_by(source) %>% select(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_EPUWJAYNDU" value="answer"></input> <span>`tweets %>% group_by(source) %>% filter(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_EPUWJAYNDU" value="x"></input> <span>`tweets %>% group_by(source) %>% filter(count() >= 10)`</span></label></div>

:::


## Putting it together

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
<caption>(\#tab:unnamed-chunk-20)Stats and the top tweet for the top five hashtags.</caption>
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

