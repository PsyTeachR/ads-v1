# Twitter Hashtags

In this appendix, we will create a table of the top five hashtags used in conjunction with #NationalComingOutDay, the total number of tweets in each hashtag, the total number of likes, and the top tweet for each hashtag. 


```r
library(tidyverse)   # data wrangling functions
library(rtweet)      # for searching tweets
library(glue)        # for pasting strings
library(kableExtra)  # for nice tables
```


The example below uses the data from Chapter\ \@ref(summary) (<a href="data/ncod_tweets.rds" download>which you can download</a>), but we encourage you to try a hashtag that interests you.


```r
# load tweets
tweets <- search_tweets(q = "#NationalComingOutDay", 
                        n = 30000, 
                        include_rts = FALSE)

# save them to a file so you can skip this step in the future
saveRDS(tweets, file = "data/ncod_tweets.rds")
```


```r
# load tweets from the file
tweets <- readRDS("data/ncod_tweets.rds")
```

## Select relevant data

The function `select()` is useful for just keeping the variables (columns) you need to work with, which can make working with very large datasets easier. The arguments to `select()` are simply the names of the variables and the resulting table will present them in the order you specify.  


```r
tweets_with_hashtags <- tweets %>%
  select(hashtags, text, favorite_count, media_url)
```


## Unnest columns

Look at the dataset using `View(tweets_with_hashtags)` or clicking on it in the Environment tab. You'll notice that the variable `hashtags` has multiple values in each cell (i.e., when users used more than one hashtag in a single tweet). In order to work with this information, we need to separate each hashtag so that each row of data represents a single hashtag. We can do this using the function `unnest()` and adding a pipeline of code.


```r
tweets_with_hashtags <- tweets %>%
  select(hashtags, text, favorite_count, media_url) %>%
  unnest(cols = hashtags)
```

::: {.try data-latex=""}
Look at `tweets_with_hashtags` to see how it is different from the table `tweets`. WHy does it have more rows?
:::


## Top 5 hashtags

To get the top 5 hashtags we need to know how tweets used each one. This code uses pipes to build up the analysis. When you encounter multi-pipe code, it can be very useful to run each line of the pipeline to see how it builds up and to check the output at each step. This code:

* Starts with the object `tweets_with_hashtags` and then;
* Counts the number of tweets for each hashtag using `count()` and then;
* Filters out any blank cells using `!is.na()` (you can read this as "keep any row value where it is not true (`!`) that `hashtags` is missing") and then;
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

Two of the hashtags are the same, but with different case. We can fix this by adding in an extra line of code that uses `mutate()` to overwrite the variable `hashtag` with the same data but transformed to lower case using `tolower()`. Since we're going to use the table `tweets_with_hashtags` a few more times, let's change that table first rather than having to fix this every time we use the table.


```r
tweets_with_hashtags <- tweets_with_hashtags %>%
  mutate(hashtags = tolower(hashtags))

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

## Top tweet per hashtag

Next, get the top tweet for each hashtag using `filter()`. Use `group_by()` before you filter to select the most-liked tweet in each hashtag, rather than the one with most likes overall. As you're getting used to writing and running this kind of multi-step code, it can be very useful to take out individual lines and see how it changes the output to strengthen your understanding of what each step is doing.


```r
top_tweet_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags) %>%
  filter(favorite_count == max(favorite_count)) %>%
  sample_n(size = 1) %>%
  ungroup()
```

::: {.try data-latex=""}
The function `slice_max()` accomplishes the same thing as the `filter()` and `sample_n()` functions above. Look at the help for this function and see if you can figure out how to use it.


<div class='webex-solution'><button>Solution</button>

```r
top_tweet_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags) %>%
  slice_max(
    order_by = favorite_count, 
    n = 1, # select the 1 top value
    with_ties = FALSE # don't include ties
  ) %>%
  ungroup()
```


</div>

:::

## Total likes per hashtag

Get the total number of likes per hashtag by grouping and summarising with `sum()`.


```r
likes_per_hashtag <- tweets_with_hashtags %>%
  group_by(hashtags) %>%
  summarise(total_likes = sum(favorite_count)) %>%
  ungroup()
```

## Put it together

We can put everything together using `left_join()` (see Chapter\ \@ref(left_join)). This will keep everything from the first table specified and then add on the relevant data from the second table specified. In this case, we add on the data in `top_tweet_per_hashtag` and `like_per_hashtag` but only for the tweets included in `top5_hashtags`


```r
top5 <- top5_hashtags %>%
  left_join(top_tweet_per_hashtag, by = "hashtags") %>%
  left_join(likes_per_hashtag, by = "hashtags") 
```

## Twitter data idiosyncrasies

Before we can finish up though, there's a couple of extra steps we need to add in to account for some of the idiosyncrasies of Twitter data. 

First,  the `@` symbol is used by R Markdown for referencing (see Chapter \ \@ref(references)). It's likely that some of the tweets will contain this symbol, so we can use mutate to find any instances of `@` and <a class='glossary' target='_blank' title='Include special characters like " inside of a string by prefacing them with a backslash.' href='https://psyteachr.github.io/glossary/e#escape'>escape</a> them using backslashes. Backslashes create a <a class='glossary' target='_blank' title='The actual character being typed, not the special meaning it has to code.' href='https://psyteachr.github.io/glossary/l#literal'>literal</a> version of characters that have a special meaning in R, so adding them means it will print the `@` symbol without trying to create a reference. Of course `\` also has a special meaning in R, which means we also need to backslash the backslash. Isn't programming fun? We can use the same code to tidy up any ampersands (&), which sometimes display as "&amp;".

Second, if there are multiple images associated with a single tweet, `media_url` will be a list, so we use `unlist()`. This might not be necessary for a different set of tweets; use `glimpse()` to check the data types.

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
   <td style="text-align:left;"> it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
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

## Make it prettier

Whilst this table now has all the information we want, it isn't great aesthetically. The <code class='package'>kableExtra</code> package has functions that will improve the presentation of tables. We're going to show you two examples of how you could format this table. 

The first is (relatively) simple and stays within the R programming language using functionality from <code class='package'>kableExtra</code>. The main aesthetic feature of the table is the incorporation of the pride flag colours for each row. Each row is set to a different colour of the pride flag and the text is set to be black and bold to improve the contrast. We've also removed the `image` column, as it just contains a URL.


```r
# the hex codes of the pride flag colours, obtained from https://www.schemecolor.com/lgbt-flag-colors.php

# the last two characters (80) make the colours semi-transparent.
# omitting them or setting to FF make them 100% opaque

pride_colours <- c("#FF001880", 
                   "#FFA52C80", 
                   "#FFFF4180", 
                   "#00801880", 
                   "#0000F980", 
                   "#86007D80")

top5 %>%
  select(-image) %>%
  kable(col.names = c("Hashtags", "No. tweets", "Likes", "Tweet"),
        caption = "Stats and the top tweet for the top five hashtags.",
        
        ) %>%
  kable_paper() %>%
  row_spec(row = 0:5, bold = T, color = "black") %>%
  row_spec(row = 0, font_size = 18,
           background = pride_colours[1]) %>%
  row_spec(row = 1, background = pride_colours[2])%>%
  row_spec(row = 2, background = pride_colours[3])%>%
  row_spec(row = 3, background = pride_colours[4])%>%
  row_spec(row = 4, background = pride_colours[5])%>%
  row_spec(row = 5, background = pride_colours[6])
```

<table class=" lightable-paper" style='font-family: "Arial Narrow", arial, helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
<caption>(\#tab:unnamed-chunk-12)Stats and the top tweet for the top five hashtags.</caption>
 <thead>
  <tr>
   <th style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 0, 24, 0.5) !important;font-size: 18px;"> Hashtags </th>
   <th style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 0, 24, 0.5) !important;font-size: 18px;"> No. tweets </th>
   <th style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 0, 24, 0.5) !important;font-size: 18px;"> Likes </th>
   <th style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 0, 24, 0.5) !important;font-size: 18px;"> Tweet </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 165, 44, 0.5) !important;"> nationalcomingoutday </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 165, 44, 0.5) !important;"> 28698 </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 165, 44, 0.5) !important;"> 851510 </td>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 165, 44, 0.5) !important;"> it’s #nationalcomingoutday 🎉 here’s a pic of how I came out back in 2003 xx https://t.co/spBmHhF6p4 </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 255, 65, 0.5) !important;"> lgbtq </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 255, 65, 0.5) !important;"> 1036 </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(255, 255, 65, 0.5) !important;"> 13691 </td>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(255, 255, 65, 0.5) !important;"> It takes bravery to life an authentic life. While I was not able to come out as a member of the #LGBTQ community on my own terms, if you’re ready &amp; can safely do so, then I support you! And if you’re not quite there yet, I support you exactly where you are. #NationalComingOutDay https://t.co/dr61oyhR3L </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(0, 128, 24, 0.5) !important;"> indigenouspeoplesday </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(0, 128, 24, 0.5) !important;"> 837 </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(0, 128, 24, 0.5) !important;"> 14073 </td>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(0, 128, 24, 0.5) !important;"> To all my Two Spirit brothers and sisters — I see you — I celebrate you. #NationalComingOutDay #IndigenousPeoplesDay https://t.co/KsZ5F3gBKO </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(0, 0, 249, 0.5) !important;"> comingoutday </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(0, 0, 249, 0.5) !important;"> 676 </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(0, 0, 249, 0.5) !important;"> 6977 </td>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(0, 0, 249, 0.5) !important;"> K—I’m out. Bi 👋🏼

#ComingOutDay #NationalComingOutDay </td>
  </tr>
  <tr>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(134, 0, 125, 0.5) !important;"> loveislove </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(134, 0, 125, 0.5) !important;"> 396 </td>
   <td style="text-align:right;font-weight: bold;color: black !important;background-color: rgba(134, 0, 125, 0.5) !important;"> 4033 </td>
   <td style="text-align:left;font-weight: bold;color: black !important;background-color: rgba(134, 0, 125, 0.5) !important;"> HAPPY NATIONAL COMING OUT DAY!! 

🏳️‍🌈❤️🧡💛💚💙💜🏳️‍🌈

\@msmadig #OutAndProud #Queer #loveislove #NationalComingOutDay https://t.co/DVfKJsCqNQ </td>
  </tr>
</tbody>
</table>

## Customise with HTML

An alternative approach incorporates <a class='glossary' target='_blank' title='Hyper-Text Markup Language: A system for semantically tagging structure and information on web pages.' href='https://psyteachr.github.io/glossary/h#html'>HTML</a> and also uses the package <code class='package'>glue</code> to combine information from multiple columns. 

First, we use `mutate()` to create a new column `col1` that combines the first three columns into a single column and adds some formatting to make the hashtag bold (`<strong>`) and insert line breaks (`<br>`). We'll also change the image column to display the image using html if there is an image.

If you're not familiar with HTML, don't worry if you don't understand the below code; the point is to show you the full extent of the flexibility available.


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
<caption>(\#tab:unnamed-chunk-13)Stats and the top tweet for the top five hashtags.</caption>
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
