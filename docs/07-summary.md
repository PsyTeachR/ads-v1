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

We'll use the `search_tweets()` function from <code class='package'>rtweet</code> to find the last (up to) 10K tweets from the past 6-9 days (this depends on Twitter) with the hashtag #NationalComingOutDay or #BiWeek.


```r
tweets <- search_tweets(q = "#NationalComingOutDay", 
                          n = 10000)
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
   <td style="text-align:right;"> 187 </td>
   <td style="text-align:left;"> 2021-09-24 14:00:02 </td>
   <td style="text-align:left;"> 2021-10-03 22:20:37 </td>
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

> There were 187 tweets between 24 September, 2021 and 03 October, 2021.

Or you can insert individual objects into markdown text with inline r:

There were <code>&#096;r tweet_summary\$n&#096;</code> tweets between <code>&#096;r date_from&#096;</code> and <code>&#096;r date_to&#096;</code>.




::: {.try data-latex=""}
* How would you find the largest number of retweets?
    <div class='webex-radiogroup' id='radio_EXUWDHMJJZ'><label><input type="radio" autocomplete="off" name="radio_EXUWDHMJJZ" value="x"></input> <span>`tweets %>% max(retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_EXUWDHMJJZ" value="x"></input> <span>`tweets %>% summarise(max_retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_EXUWDHMJJZ" value="answer"></input> <span>`tweets %>% summarise(max_retweets = max(retweets))`</span></label><label><input type="radio" autocomplete="off" name="radio_EXUWDHMJJZ" value="x"></input> <span>`tweets %>% summarise(max = retweets)`</span></label></div>

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
   <td style="text-align:left;"> Hootsuite Inc. </td>
   <td style="text-align:right;"> 2.8750000 </td>
   <td style="text-align:right;"> 1.3750 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twitter for iPad </td>
   <td style="text-align:right;"> 2.6000000 </td>
   <td style="text-align:right;"> 6.8000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twitter Web App </td>
   <td style="text-align:right;"> 1.7341772 </td>
   <td style="text-align:right;"> 870.8861 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TweetDeck </td>
   <td style="text-align:right;"> 1.2500000 </td>
   <td style="text-align:right;"> 2.2500 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sprinklr Publishing </td>
   <td style="text-align:right;"> 1.0000000 </td>
   <td style="text-align:right;"> 0.0000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twitter for iPhone </td>
   <td style="text-align:right;"> 0.9848485 </td>
   <td style="text-align:right;"> 263.3485 </td>
  </tr>
</tbody>
</table>

</div>




::: {.try data-latex=""}
* How would you calculate the mean `display_text_width`? 
    <div class='webex-radiogroup' id='radio_WUTVYVFKQQ'><label><input type="radio" autocomplete="off" name="radio_WUTVYVFKQQ" value="x"></input> <span>`group_by(display_text_width)`</span></label><label><input type="radio" autocomplete="off" name="radio_WUTVYVFKQQ" value="x"></input> <span>`width(mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_WUTVYVFKQQ" value="answer"></input> <span>`summarise(width = mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_WUTVYVFKQQ" value="x"></input> <span>`summarise(display_text_width = mean)`</span></label></div>

* What would you change to calculate the mean favourites and retweets by `screen_name` instead of by `source`? 
    <div class='webex-radiogroup' id='radio_SYCUHRSXJS'><label><input type="radio" autocomplete="off" name="radio_SYCUHRSXJS" value="x"></input> <span>`summarise(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_SYCUHRSXJS" value="x"></input> <span>`mean(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_SYCUHRSXJS" value="answer"></input> <span>`group_by(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_SYCUHRSXJS" value="x"></input> <span>`count(screen_name)`</span></label></div>

:::

### Counting

How many different accounts tweeted? Who tweeted most?

You can count categories with the `count()` function. Since each row is a tweet, you can count the number of rows per `screen_name` to get the number of tweets per user. This will give you a new table with each combination of the counted columns and a column called `n` containing the number of observations from that group. Use `arrange(desc(n))` to sort the table by `n` in descending order.


```r
tweets_per_user <- tweets %>%
  count(screen_name) %>%
  arrange(desc(n))

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
   <td style="text-align:left;"> DemetreBhunter </td>
   <td style="text-align:right;"> 33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> weRhumblehumans </td>
   <td style="text-align:right;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> cureddoc </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> doriancoreymode </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> josh7621 </td>
   <td style="text-align:right;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> chefded </td>
   <td style="text-align:right;"> 3 </td>
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

There were 132 unique accounts 
tweeting about #NationalComingOutDay. 
DemetreBhunter was the most prolific tweeter, 
with 33 tweets.




::: {.try data-latex=""}
* How would you count the number of tweets that are quotes or not and are retweets or not? 
    <div class='webex-radiogroup' id='radio_UKNNRFXDOL'><label><input type="radio" autocomplete="off" name="radio_UKNNRFXDOL" value="x"></input> <span>`tweets %>% count(c(is_quote, is_retweet))`</span></label><label><input type="radio" autocomplete="off" name="radio_UKNNRFXDOL" value="x"></input> <span>`tweets %>% count(is_quote) %>% count(is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_UKNNRFXDOL" value="answer"></input> <span>`tweets %>% count(is_quote, is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_UKNNRFXDOL" value="x"></input> <span>`tweets %>% select(is_quote, is_retweet) %>% count()`</span></label></div>

:::

### Filtering

What was the most favourited tweets? Use `filter()` to keep just the rows where the value in the `favorite_count` column is equal to its maximum value. Just in case there was a tie, choose a random one with `sample_n(size = 1)`.


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
--------------------------------------------------
") %>% 
  # replace @ with \@ so @ doesn't trigger referencing
  gsub("@", "\\\\@", .) %>%
  # prints results into document, not code
  cat()
```

The most favourited (41) tweet was by 
[FANTIPodcast](https://twitter.com/FANTIPodcast/status/1444112899547435009):

--------------------------------------------------
Celebrate #NationalComingOutDay with \@TrevellAnderson and \@JarrettHill. https://t.co/khmKBJrSJt
--------------------------------------------------



::: {.try data-latex=""}
* How would you limit the results to sources with 10 or more rows?
    <div class='webex-radiogroup' id='radio_SEONDHNYGH'><label><input type="radio" autocomplete="off" name="radio_SEONDHNYGH" value="x"></input> <span>`tweets %>% group_by(source) %>% filter(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_SEONDHNYGH" value="x"></input> <span>`tweets %>% group_by(source) %>% select(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_SEONDHNYGH" value="x"></input> <span>`tweets %>% group_by(source) %>% select(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_SEONDHNYGH" value="answer"></input> <span>`tweets %>% group_by(source) %>% filter(n() >= 10)`</span></label></div>

:::


## Putting it together

Let's make a table of the top ten hashtags used in conjunction with #BiVisibilityWeek, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag.

First, select just the relevant columns and expand the `hashtags` column. This is a column of lists, so you can create a row for each value using `unnest()`.


```r
tweets_with_hashtags <- tweets %>%
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
  # replace @ with \@ so @ doesn't trigger referencing
  mutate(text = gsub("@", "\\\\@", text)) %>%
  # put the columns you want to display in order
  select(hashtags, n, total_likes, text)

top10
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> hashtags </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:right;"> total_likes </th>
   <th style="text-align:left;"> text </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> NationalComingOutDay </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 218 </td>
   <td style="text-align:left;"> Celebrate #NationalComingOutDay with \@TrevellAnderson and \@JarrettHill. https://t.co/khmKBJrSJt </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> TONIGHT! Join a virtual screening and panel discussion about the award-winning documentary \@cureddoc hosted by the Rainbow History Project and \@urbanhealthmp  
#lgbtqhistorymonth
#CUREDdocumentary
#nationalcomingoutday https://t.co/AzNN0H6g79 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pridemonth </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:left;"> #nationalcomingoutday  for canada for #pridemonth2021 #pridemonth 🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈 justin tredeau of ultra https://t.co/yT3rUb3e60 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pridemonth2021 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;"> #nationalcomingoutday  for canada for #pridemonth2021 #pridemonth 🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈 justin tredeau of ultra https://t.co/yT3rUb3e60 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> We are thrilled to announce the panelists of our upcoming virtual discussion &quot;Coming Out: A Conversation&quot;. 

Join us at 8PM on #NationalComingOutDay for an evening of conversation &amp;amp; programming centered on identity, expression, and what it means to share yourself with the world. https://t.co/rb7eYbxryp </td>
  </tr>
  <tr>
   <td style="text-align:left;"> electionday </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> #nationalcomingoutday #pridemonth #pride2021 #pridemonth #electionday #electionday2021 #NationalVoterRegistrationDay  #voteready #vote2021 #electionday #Debates #Debates2021 #nycc2021 #nycc 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> LGBTQ </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:left;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY &quot;Proud David&quot; for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NationalVoterRegistrationDay </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> #nationalcomingoutday #pridemonth #pride2021 #pridemonth #electionday #electionday2021 #NationalVoterRegistrationDay  #voteready #vote2021 #electionday #Debates #Debates2021 #nycc2021 #nycc 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CreativeSelfSovereignty </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY &quot;Proud David&quot; for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRIDE </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:left;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY &quot;Proud David&quot; for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
</tbody>
</table>

</div>

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
<caption>(\#tab:unnamed-chunk-19)Stats and the top tweet for the top 10 hashtags.</caption>
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
   <td style="text-align:left;vertical-align: top;"> NationalComingOutDay </td>
   <td style="text-align:right;vertical-align: top;"> 119 </td>
   <td style="text-align:right;vertical-align: top;"> 218 </td>
   <td style="text-align:left;vertical-align: top;"> Celebrate #NationalComingOutDay with \@TrevellAnderson and \@JarrettHill. https://t.co/khmKBJrSJt </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> nationalcomingoutday </td>
   <td style="text-align:right;vertical-align: top;"> 40 </td>
   <td style="text-align:right;vertical-align: top;"> 25 </td>
   <td style="text-align:left;vertical-align: top;"> TONIGHT! Join a virtual screening and panel discussion about the award-winning documentary \@cureddoc hosted by the Rainbow History Project and \@urbanhealthmp  
#lgbtqhistorymonth
#CUREDdocumentary
#nationalcomingoutday https://t.co/AzNN0H6g79 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> pridemonth </td>
   <td style="text-align:right;vertical-align: top;"> 36 </td>
   <td style="text-align:right;vertical-align: top;"> 11 </td>
   <td style="text-align:left;vertical-align: top;"> #nationalcomingoutday  for canada for #pridemonth2021 #pridemonth 🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈 justin tredeau of ultra https://t.co/yT3rUb3e60 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> pridemonth2021 </td>
   <td style="text-align:right;vertical-align: top;"> 17 </td>
   <td style="text-align:right;vertical-align: top;"> 6 </td>
   <td style="text-align:left;vertical-align: top;"> #nationalcomingoutday  for canada for #pridemonth2021 #pridemonth 🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈🏳️‍🌈 justin tredeau of ultra https://t.co/yT3rUb3e60 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> NA </td>
   <td style="text-align:right;vertical-align: top;"> 16 </td>
   <td style="text-align:right;vertical-align: top;"> 0 </td>
   <td style="text-align:left;vertical-align: top;"> We are thrilled to announce the panelists of our upcoming virtual discussion "Coming Out: A Conversation". 

Join us at 8PM on #NationalComingOutDay for an evening of conversation &amp;amp; programming centered on identity, expression, and what it means to share yourself with the world. https://t.co/rb7eYbxryp </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> electionday </td>
   <td style="text-align:right;vertical-align: top;"> 15 </td>
   <td style="text-align:right;vertical-align: top;"> 2 </td>
   <td style="text-align:left;vertical-align: top;"> #nationalcomingoutday #pridemonth #pride2021 #pridemonth #electionday #electionday2021 #NationalVoterRegistrationDay  #voteready #vote2021 #electionday #Debates #Debates2021 #nycc2021 #nycc 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> LGBTQ </td>
   <td style="text-align:right;vertical-align: top;"> 15 </td>
   <td style="text-align:right;vertical-align: top;"> 35 </td>
   <td style="text-align:left;vertical-align: top;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY "Proud David" for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> NationalVoterRegistrationDay </td>
   <td style="text-align:right;vertical-align: top;"> 10 </td>
   <td style="text-align:right;vertical-align: top;"> 1 </td>
   <td style="text-align:left;vertical-align: top;"> #nationalcomingoutday #pridemonth #pride2021 #pridemonth #electionday #electionday2021 #NationalVoterRegistrationDay  #voteready #vote2021 #electionday #Debates #Debates2021 #nycc2021 #nycc 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> CreativeSelfSovereignty </td>
   <td style="text-align:right;vertical-align: top;"> 9 </td>
   <td style="text-align:right;vertical-align: top;"> 13 </td>
   <td style="text-align:left;vertical-align: top;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY "Proud David" for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> PRIDE </td>
   <td style="text-align:right;vertical-align: top;"> 9 </td>
   <td style="text-align:right;vertical-align: top;"> 13 </td>
   <td style="text-align:left;vertical-align: top;"> OCT 11 is #NationalComingOutDay. Celebrate #PRIDE and #CreativeSelfSovereignty! BUY "Proud David" for yourself or GIFT one to your #LGBTQ loved ones. #NFTCollectors can win a signed LE print I'm giving away #OCT11. So collect now: https://t.co/tJIOs7qt92 #NFTFamily #NFTCommunity </td>
  </tr>
</tbody>
</table>

