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

We'll use the `search_tweets()` function from <code class='package'>rtweet</code> to find the last (up to) 10K tweets from the past 6-9 days (this depends on Twitter) with the hashtag #NationalComingOutDay.


```r
tweets <- search_tweets(q = "#NationalComingOutDay", 
                        n = 10000, 
                        include_rts = FALSE)
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
   <td style="text-align:right;"> 9988 </td>
   <td style="text-align:left;"> 2021-10-11 21:36:57 </td>
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

> There were 9988 tweets between 11 October, 2021 and 12 October, 2021.

Or you can insert individual objects into markdown text with inline r:

There were <code>&#096;r tweet_summary\$n&#096;</code> tweets between <code>&#096;r date_from&#096;</code> and <code>&#096;r date_to&#096;</code>.




::: {.try data-latex=""}
* How would you find the largest number of retweets?
    <div class='webex-radiogroup' id='radio_ILVTGTQNDQ'><label><input type="radio" autocomplete="off" name="radio_ILVTGTQNDQ" value="answer"></input> <span>`tweets %>% summarise(max_retweets = max(retweets))`</span></label><label><input type="radio" autocomplete="off" name="radio_ILVTGTQNDQ" value="x"></input> <span>`tweets %>% max(retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_ILVTGTQNDQ" value="x"></input> <span>`tweets %>% summarise(max = retweets)`</span></label><label><input type="radio" autocomplete="off" name="radio_ILVTGTQNDQ" value="x"></input> <span>`tweets %>% summarise(max_retweets)`</span></label></div>

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
   <td style="text-align:left;"> Khoros Publishing App </td>
   <td style="text-align:right;"> 787.00000 </td>
   <td style="text-align:right;"> 109.000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SocialFlow </td>
   <td style="text-align:right;"> 229.00000 </td>
   <td style="text-align:right;"> 38.250000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TweetDeck </td>
   <td style="text-align:right;"> 58.06897 </td>
   <td style="text-align:right;"> 6.793103 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twitter Media Studio </td>
   <td style="text-align:right;"> 49.60000 </td>
   <td style="text-align:right;"> 8.600000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SocialNewsDesk </td>
   <td style="text-align:right;"> 46.00000 </td>
   <td style="text-align:right;"> 12.000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twitter for iPad </td>
   <td style="text-align:right;"> 33.58333 </td>
   <td style="text-align:right;"> 2.715278 </td>
  </tr>
</tbody>
</table>

</div>




::: {.try data-latex=""}
* How would you calculate the mean `display_text_width`? 
    <div class='webex-radiogroup' id='radio_SDGYLOSCTM'><label><input type="radio" autocomplete="off" name="radio_SDGYLOSCTM" value="x"></input> <span>`width(mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_SDGYLOSCTM" value="x"></input> <span>`group_by(display_text_width)`</span></label><label><input type="radio" autocomplete="off" name="radio_SDGYLOSCTM" value="answer"></input> <span>`summarise(width = mean(display_text_width))`</span></label><label><input type="radio" autocomplete="off" name="radio_SDGYLOSCTM" value="x"></input> <span>`summarise(display_text_width = mean)`</span></label></div>

* What would you change to calculate the mean favourites and retweets by `screen_name` instead of by `source`? 
    <div class='webex-radiogroup' id='radio_FPEIVYZBKV'><label><input type="radio" autocomplete="off" name="radio_FPEIVYZBKV" value="x"></input> <span>`summarise(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_FPEIVYZBKV" value="answer"></input> <span>`group_by(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_FPEIVYZBKV" value="x"></input> <span>`mean(screen_name)`</span></label><label><input type="radio" autocomplete="off" name="radio_FPEIVYZBKV" value="x"></input> <span>`count(screen_name)`</span></label></div>

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
   <td style="text-align:left;"> LeoShir2 </td>
   <td style="text-align:right;"> 33 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dr_stack </td>
   <td style="text-align:right;"> 32 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> bhavna_95 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> KatieZakrzewsk1 </td>
   <td style="text-align:right;"> 20 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> JacDArcher </td>
   <td style="text-align:right;"> 14 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ManoharKrSingh6 </td>
   <td style="text-align:right;"> 13 </td>
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

There were 9178 unique accounts 
tweeting about #NationalComingOutDay. 
LeoShir2 was the most prolific tweeter, 
with 33 tweets.




::: {.try data-latex=""}
* How would you count the number of tweets that are quotes or not and are retweets or not? 
    <div class='webex-radiogroup' id='radio_XGRCQSRZMV'><label><input type="radio" autocomplete="off" name="radio_XGRCQSRZMV" value="x"></input> <span>`tweets %>% count(c(is_quote, is_retweet))`</span></label><label><input type="radio" autocomplete="off" name="radio_XGRCQSRZMV" value="x"></input> <span>`tweets %>% select(is_quote, is_retweet) %>% count()`</span></label><label><input type="radio" autocomplete="off" name="radio_XGRCQSRZMV" value="answer"></input> <span>`tweets %>% count(is_quote, is_retweet)`</span></label><label><input type="radio" autocomplete="off" name="radio_XGRCQSRZMV" value="x"></input> <span>`tweets %>% count(is_quote) %>% count(is_retweet)`</span></label></div>

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

![]({most_fav$ext_media_url}){{width='100%'}}
--------------------------------------------------
") %>% 
  # replace @ with \@ so @ doesn't trigger referencing
  gsub("@", "\\\\@", .) %>%
  # prints results into document, not as code
  cat()
```

The most favourited (22769) tweet was by 
[AustinOnTwitter](https://twitter.com/AustinOnTwitter/status/1447700087988101120):

--------------------------------------------------
Happy #NationalComingOutDay 🏳️‍🌈

It’s been a year and half since I came out &amp; am so happy that I did. There was a time when I thought I’d NEVER tell ANYBODY but here I am blasting my homosexuality on twitter

Come out on your own time, don’t feel pressured by anybody! ❤️

![](NA){width='100%'}
--------------------------------------------------



::: {.try data-latex=""}
* How would you limit the results to sources with 10 or more rows?
    <div class='webex-radiogroup' id='radio_VTCDEZJTID'><label><input type="radio" autocomplete="off" name="radio_VTCDEZJTID" value="answer"></input> <span>`tweets %>% group_by(source) %>% filter(n() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_VTCDEZJTID" value="x"></input> <span>`tweets %>% group_by(source) %>% select(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_VTCDEZJTID" value="x"></input> <span>`tweets %>% group_by(source) %>% filter(count() >= 10)`</span></label><label><input type="radio" autocomplete="off" name="radio_VTCDEZJTID" value="x"></input> <span>`tweets %>% group_by(source) %>% select(n() >= 10)`</span></label></div>

:::


## Putting it together

Let's make a table of the top ten hashtags used in conjunction with #NationalComingOutDay, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag.

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
  filter(!is.na(hashtags)) %>%  # get rid of the blank value
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
   <td style="text-align:right;"> 9571 </td>
   <td style="text-align:right;"> 210793 </td>
   <td style="text-align:left;"> Happy #NationalComingOutDay 🏳️‍🌈

It’s been a year and half since I came out &amp;amp; am so happy that I did. There was a time when I thought I’d NEVER tell ANYBODY but here I am blasting my homosexuality on twitter

Come out on your own time, don’t feel pressured by anybody! ❤️ </td>
  </tr>
  <tr>
   <td style="text-align:left;"> nationalcomingoutday </td>
   <td style="text-align:right;"> 426 </td>
   <td style="text-align:right;"> 13394 </td>
   <td style="text-align:left;"> come out, come out, wherever you are ✨🌈 #nationalcomingoutday https://t.co/obQhslJNOf </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ComingOutDay </td>
   <td style="text-align:right;"> 247 </td>
   <td style="text-align:right;"> 1039 </td>
   <td style="text-align:left;"> Ladies and Gentlemen? Literally.

I'm officially coming out as Bisexual, support or not!

Thanks for the courage 💙✨

#ComingOutDay #NationalComingOutDay https://t.co/IKXTqU5kTg </td>
  </tr>
  <tr>
   <td style="text-align:left;"> LGBTQ </td>
   <td style="text-align:right;"> 233 </td>
   <td style="text-align:right;"> 1959 </td>
   <td style="text-align:left;"> Thank you, Madam \@VP, for joining us! Proud to serve alongside so many dedicated #LGBTQ+ colleagues in the most pro-equality administration in American history! To anyone thinking about coming out, please know that it does get better. #NationalComingOutDay 🇺🇸🏳️‍🌈🏳️‍⚧️ https://t.co/PMvrn4O5Rc </td>
  </tr>
  <tr>
   <td style="text-align:left;"> IndigenousPeoplesDay </td>
   <td style="text-align:right;"> 209 </td>
   <td style="text-align:right;"> 8517 </td>
   <td style="text-align:left;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ViratKohli </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 192 </td>
   <td style="text-align:left;"> #tuesdaymotivations #Durgashtami #DurgaPuja2021
#ENHYPEN
#ViratKohli #NationalComingOutDay
Can Durga Ji forgive Sins?
 To know more, Get free book &quot;Gyan Ganga&quot;.
Send is your Name, Address &amp;amp; Content Number.
\@NeerajDasi1 \@Being__kajal https://t.co/VSQ4kbQnpF </td>
  </tr>
  <tr>
   <td style="text-align:left;"> viratkholi </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:left;"> السلام علیکم ورحمتہ اللہ وبرکاتہ 🌷
#goodmorning #Asslamu_Alaikum
#viratkholi #captaincy
#24hoursinpolicecustody
#NationalComingOutDay
 #صباح_Iلخير
#السلام_عليكم #عمان_عظيمة_بشعبها
#شاهين #الهند_تقتل_المسلمين
#السلطان_هيثم_بن_طارق
#Mossad #Congratulationsbibi
#ayeshaakramexposed https://t.co/YC5aWicIg1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> LGBTQIA </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 3995 </td>
   <td style="text-align:left;"> #NationalComingOutDay I am a 44 year old, Black, Jewish, openly #gay man. I have been out since I was 16 years old. I came out in my high school newspaper. This path has not been easy but know this...I am here. To all my #LGBTQIA family, lets celebrate each other today. https://t.co/UfD1819rPC </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RCBvsKKR </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:left;"> Actually, that's a common misconception. Clownfish are no funnier than any other fish.

#Viral #TrendingNow #Altcoins #BANGYEDAM #BiggBoss15 #Dhoni #ENHYPEN2ndComeback_DDAY #HAECHAN #Iran #JayBhanushali #konka #KundaliBhagya #NationalComingOutDay #OnMyBlock #Qatar2022 #RCBvsKKR https://t.co/1pCpEy0ZtL </td>
  </tr>
  <tr>
   <td style="text-align:left;"> konka </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:left;"> Actually, that's a common misconception. Clownfish are no funnier than any other fish.

#Viral #TrendingNow #Altcoins #BANGYEDAM #BiggBoss15 #Dhoni #ENHYPEN2ndComeback_DDAY #HAECHAN #Iran #JayBhanushali #konka #KundaliBhagya #NationalComingOutDay #OnMyBlock #Qatar2022 #RCBvsKKR https://t.co/1pCpEy0ZtL </td>
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
   <td style="text-align:right;vertical-align: top;"> 9571 </td>
   <td style="text-align:right;vertical-align: top;"> 210793 </td>
   <td style="text-align:left;vertical-align: top;"> Happy #NationalComingOutDay 🏳️‍🌈

It’s been a year and half since I came out &amp;amp; am so happy that I did. There was a time when I thought I’d NEVER tell ANYBODY but here I am blasting my homosexuality on twitter

Come out on your own time, don’t feel pressured by anybody! ❤️ </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> nationalcomingoutday </td>
   <td style="text-align:right;vertical-align: top;"> 426 </td>
   <td style="text-align:right;vertical-align: top;"> 13394 </td>
   <td style="text-align:left;vertical-align: top;"> come out, come out, wherever you are ✨🌈 #nationalcomingoutday https://t.co/obQhslJNOf </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> ComingOutDay </td>
   <td style="text-align:right;vertical-align: top;"> 247 </td>
   <td style="text-align:right;vertical-align: top;"> 1039 </td>
   <td style="text-align:left;vertical-align: top;"> Ladies and Gentlemen? Literally.

I'm officially coming out as Bisexual, support or not!

Thanks for the courage 💙✨

#ComingOutDay #NationalComingOutDay https://t.co/IKXTqU5kTg </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> LGBTQ </td>
   <td style="text-align:right;vertical-align: top;"> 233 </td>
   <td style="text-align:right;vertical-align: top;"> 1959 </td>
   <td style="text-align:left;vertical-align: top;"> Thank you, Madam \@VP, for joining us! Proud to serve alongside so many dedicated #LGBTQ+ colleagues in the most pro-equality administration in American history! To anyone thinking about coming out, please know that it does get better. #NationalComingOutDay 🇺🇸🏳️‍🌈🏳️‍⚧️ https://t.co/PMvrn4O5Rc </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> IndigenousPeoplesDay </td>
   <td style="text-align:right;vertical-align: top;"> 209 </td>
   <td style="text-align:right;vertical-align: top;"> 8517 </td>
   <td style="text-align:left;vertical-align: top;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> ViratKohli </td>
   <td style="text-align:right;vertical-align: top;"> 122 </td>
   <td style="text-align:right;vertical-align: top;"> 192 </td>
   <td style="text-align:left;vertical-align: top;"> #tuesdaymotivations #Durgashtami #DurgaPuja2021
#ENHYPEN
#ViratKohli #NationalComingOutDay
Can Durga Ji forgive Sins?
 To know more, Get free book "Gyan Ganga".
Send is your Name, Address &amp;amp; Content Number.
\@NeerajDasi1 \@Being__kajal https://t.co/VSQ4kbQnpF </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> viratkholi </td>
   <td style="text-align:right;vertical-align: top;"> 102 </td>
   <td style="text-align:right;vertical-align: top;"> 79 </td>
   <td style="text-align:left;vertical-align: top;"> السلام علیکم ورحمتہ اللہ وبرکاتہ 🌷
#goodmorning #Asslamu_Alaikum
#viratkholi #captaincy
#24hoursinpolicecustody
#NationalComingOutDay
 #صباح_Iلخير
#السلام_عليكم #عمان_عظيمة_بشعبها
#شاهين #الهند_تقتل_المسلمين
#السلطان_هيثم_بن_طارق
#Mossad #Congratulationsbibi
#ayeshaakramexposed https://t.co/YC5aWicIg1 </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> LGBTQIA </td>
   <td style="text-align:right;vertical-align: top;"> 98 </td>
   <td style="text-align:right;vertical-align: top;"> 3995 </td>
   <td style="text-align:left;vertical-align: top;"> #NationalComingOutDay I am a 44 year old, Black, Jewish, openly #gay man. I have been out since I was 16 years old. I came out in my high school newspaper. This path has not been easy but know this...I am here. To all my #LGBTQIA family, lets celebrate each other today. https://t.co/UfD1819rPC </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> RCBvsKKR </td>
   <td style="text-align:right;vertical-align: top;"> 95 </td>
   <td style="text-align:right;vertical-align: top;"> 64 </td>
   <td style="text-align:left;vertical-align: top;"> Actually, that's a common misconception. Clownfish are no funnier than any other fish.

#Viral #TrendingNow #Altcoins #BANGYEDAM #BiggBoss15 #Dhoni #ENHYPEN2ndComeback_DDAY #HAECHAN #Iran #JayBhanushali #konka #KundaliBhagya #NationalComingOutDay #OnMyBlock #Qatar2022 #RCBvsKKR https://t.co/1pCpEy0ZtL </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: top;"> konka </td>
   <td style="text-align:right;vertical-align: top;"> 91 </td>
   <td style="text-align:right;vertical-align: top;"> 68 </td>
   <td style="text-align:left;vertical-align: top;"> Actually, that's a common misconception. Clownfish are no funnier than any other fish.

#Viral #TrendingNow #Altcoins #BANGYEDAM #BiggBoss15 #Dhoni #ENHYPEN2ndComeback_DDAY #HAECHAN #Iran #JayBhanushali #konka #KundaliBhagya #NationalComingOutDay #OnMyBlock #Qatar2022 #RCBvsKKR https://t.co/1pCpEy0ZtL </td>
  </tr>
</tbody>
</table>

