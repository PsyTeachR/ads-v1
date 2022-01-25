# Spotify Data

This appendix was inspired by [Michael Mullarkey's tutorial](https://mcmullarkey.github.io/mcm-blog/posts/2022-01-07-spotify-api-r/){target="_blank"}, which you can follow to make beautiful dot plots out of your own Spotify data. This tutorial doesn't require you to use Spotify; just to create a developer account so you can access their data API with <code class='package'><a href='https://www.rcharlie.com/spotifyr/' target='_blank'>spotifyr</a></code>.


```r
library(usethis)    # to set system environment variables
```

```
## Warning: package 'usethis' was built under R version 4.1.2
```

```r
library(spotifyr)   # to access Spotify
```

```
## Warning: package 'spotifyr' was built under R version 4.1.2
```

```r
library(tidyverse)  # for data wrangling
library(DT)         # for interactive tables
```

```
## Warning: package 'DT' was built under R version 4.1.2
```

The package [spotifyr](https://www.rcharlie.com/spotifyr){target="_blank"} has instructions for setting up a developer account with Spotify and setting up an "app" so you can get authorisation codes.

Once you've set up the app, you can copy the client ID and secret to your R environment file. The easiest way to do this is with `edit_r_environ()` from <code class='package'>usethis</code>. Setting scope to "user" makes this available to any R project on your computer, while setting it to "project" makes it only available to this project.


```r
usethis::edit_r_environ(scope = "user")
```

Add the following text to your environment file (don't delete anything already there), replacing the zeros with your personal ID and secret. Save and close the file and restart R. 

```
SPOTIFY_CLIENT_ID="0000000000000000000000000000"
SPOTIFY_CLIENT_SECRET="0000000000000000000000000000"
```

Double check that it worked by typing the following into the console. Don't put it in your script unless you mean to share this confidential info.  You should see your values, not "", if it worked.


```r
# run in the console, don't save in a script
Sys.getenv("SPOTIFY_CLIENT_ID")
Sys.getenv("SPOTIFY_CLIENT_SECRET")
```

Now you're ready to get data from Spotify. There are several types of data that you can download. 




## By Artist

Choose your favourite artist and download their discography. Set `include_groups` to one or more of "album", "single", "appears_on", and "compilation".


```r
gaga <- get_artist_audio_features(
  artist = 'Lady Gaga',
  include_groups = "album"
)
```

Let's explore the data you get back. Use `glimpse()` to see what columns are available and what type of data they have. It looks like there is a row for each of this artist's tracks.

Let's answer a few simple questions first. 

### Tracks per Album

How many tracks are on each album? Some tracks have more than one entry in the table, so first select just the `album_name` and `track_name` columns and use `distinct()` to get rid of duplicates. Then `count()` the tracks per album. We're using `DT::datatable()` to make the table interactive. Try sorting the table by number of tracks. 


```r
gaga %>%
  select(album_name, track_name) %>%
  distinct() %>%
  count(album_name) %>%
  datatable(colnames = c("Albumn Name", "Number of Tracks"))
```

```{=html}
<div id="htmlwidget-9b51d3a83d100eac0f0c" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9b51d3a83d100eac0f0c">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"],["A Star Is Born Soundtrack","A Star Is Born Soundtrack (Without Dialogue)","ARTPOP","Born This Way","Born This Way - The Remix","Born This Way (International Special Edition Version)","Born This Way (International Standard Version)","Born This Way (Japan Special Edition Version)","Born This Way (Japan Standard Version)","Born This Way (Special Edition)","BORN THIS WAY THE TENTH ANNIVERSARY","Cheek To Cheek","Cheek To Cheek (Deluxe)","Chromatica","Dawn Of Chromatica","Joanne","Joanne (Deluxe)","Love For Sale (Deluxe)","The Fame","The Fame Monster","The Fame Monster (Deluxe Edition)","The Fame Monster (France FNAC Version)","The Fame Monster (France Virgin Version)","The Fame Monster (International Deluxe)","The Fame Monster (UK Deluxe)"],[36,19,17,14,16,23,15,24,16,22,15,11,17,16,14,14,14,12,15,8,23,25,25,24,24]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Albumn Name<\/th>\n      <th>Number of Tracks<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":2},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

::: {.try data-latex=""}
Use `count()` to explore the columns `key_name`, `mode_name`, and any other non-numeric columns. 
:::

### Tempo

What sort of tempo is Lady Gaga's music? First, let's look at a very basic plot to get an overview.


```r
ggplot(gaga, aes(tempo)) +
  geom_histogram(binwidth = 1)
```

<img src="appendix-j-spotify_files/figure-html/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" />

What's going on with the tracks with a tempo of 0?


```r
gaga %>% 
  filter(tempo == 0) %>%
  select(album_name, track_name)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> album_name </th>
   <th style="text-align:left;"> track_name </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> First Stop, Arizona - Dialogue </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> How Do You Hear It? - Dialogue </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> SNL - Dialogue </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> First Stop, Arizona - Dialogue </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> How Do You Hear It? - Dialogue </td>
  </tr>
  <tr>
   <td style="text-align:left;"> A Star Is Born Soundtrack </td>
   <td style="text-align:left;"> SNL - Dialogue </td>
  </tr>
</tbody>
</table>

</div>

Looks like it's all dialogue, so we should omit these. Let's also check how variable the tempo is for multiple instances of the same track. A quick way to do this is to group by album and track, then check the <a class='glossary' target='_blank' title='A descriptive statistic that measures how spread out data are relative to the mean.' href='https://psyteachr.github.io/glossary/s#standard-deviation'>standard deviation</a> of the tempo. If it's 0, this means that all of the values are identical. The bigger it is, the more the values vary. If you have a lot of data with a <a class='glossary' target='_blank' title='A symmetric distribution of data where values near the centre are most probable.' href='https://psyteachr.github.io/glossary/n#normal-distribution'>normal distribution</a> (like a bell curve), then about 68% of the data are within one SD of the mean, and about 95% are within 2 SDs.

If we filter to tracks with SD greater than 0 (so any variation at all), we see that most tracks have a little variation. However, if we filter to tracks with an SD greater than 1, we see a few songs with slightly different tempo, and a few with wildly different tempo. 


```r
gaga %>%
  # omit tracks with "Dialogue" in the name
  filter(!str_detect(track_name, "Dialogue")) %>%
  # check for varying tempos for same track
  group_by(album_name, track_name) %>%
  filter(sd(tempo) > 1) %>%
  ungroup() %>%
  select(album_name, track_name, tempo) %>%
  arrange(album_name, track_name)
```

<div class="kable-table">

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> album_name </th>
   <th style="text-align:left;"> track_name </th>
   <th style="text-align:right;"> tempo </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> BORN THIS WAY THE TENTH ANNIVERSARY </td>
   <td style="text-align:left;"> The Edge Of Glory </td>
   <td style="text-align:right;"> 127.957 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BORN THIS WAY THE TENTH ANNIVERSARY </td>
   <td style="text-align:left;"> The Edge Of Glory </td>
   <td style="text-align:right;"> 124.004 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BORN THIS WAY THE TENTH ANNIVERSARY </td>
   <td style="text-align:left;"> Yoü And I </td>
   <td style="text-align:right;"> 127.073 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BORN THIS WAY THE TENTH ANNIVERSARY </td>
   <td style="text-align:left;"> Yoü And I </td>
   <td style="text-align:right;"> 124.428 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cheek To Cheek </td>
   <td style="text-align:left;"> Sophisticated Lady </td>
   <td style="text-align:right;"> 75.221 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cheek To Cheek </td>
   <td style="text-align:left;"> Sophisticated Lady </td>
   <td style="text-align:right;"> 138.475 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Joanne </td>
   <td style="text-align:left;"> Come To Mama </td>
   <td style="text-align:right;"> 179.911 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Joanne </td>
   <td style="text-align:left;"> Come To Mama </td>
   <td style="text-align:right;"> 179.911 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Joanne </td>
   <td style="text-align:left;"> Come To Mama </td>
   <td style="text-align:right;"> 119.962 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Joanne (Deluxe) </td>
   <td style="text-align:left;"> Come To Mama </td>
   <td style="text-align:right;"> 179.911 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Joanne (Deluxe) </td>
   <td style="text-align:left;"> Come To Mama </td>
   <td style="text-align:right;"> 119.962 </td>
  </tr>
</tbody>
</table>

</div>

You can deal with these in any way you choose. Filter out some versions of the songs or listen to them to see which value you agree with and change the others. Here, we'll deal with it by averaging the values for each track. This will also remove the tiny differences in the majority of duplicate tracks. Now we're ready to plot.


```r
gaga %>%
  filter(tempo > 0) %>%
  group_by(album_name, track_name) %>%
  summarise(tempo = round(mean(tempo)),
            .groups = "drop") %>%
  ungroup() %>%
  ggplot(aes(x = tempo, fill = ..x..)) +
  geom_histogram(binwidth = 4, show.legend = FALSE) +
  scale_fill_gradient(low = "#521F64", high = "#E8889C") +
  labs(x = "Beats per minute",
       y = "Number of tracks",
       title = "Tempo of Lady Gaga Tracks")
```

<img src="appendix-j-spotify_files/figure-html/unnamed-chunk-9-1.png" width="100%" style="display: block; margin: auto;" />

::: {.try data-latex=""}
Can you see how we made the gradient fill for the histograms? Since the x-value of each bar depends on the binwidth, you have to use the code `..x..` in the mapping (not `tempo`) to make the fill correspond to each bar's value. 
:::

This looks OK, but maybe we want a more striking plot. Let's make a custom plot style and assign it to `gaga_style` in case we want to use it again. Then add it to the shortcut function, `last_plot()` to avoid having to retype the code for the last plot we created.


```r
# define style
gaga_style <- theme(
  plot.background = element_rect(fill = "black"),
  text = element_text(color = "white", size = 11),
  panel.background = element_rect(fill = "black"),
  panel.grid.major.x = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.major.y = element_line(colour = "white", size = 0.2),
  panel.grid.minor.y = element_line(colour = "white", size = 0.2),
  axis.text = element_text(color = "white"),
  plot.title = element_text(hjust = 0.5)
)

## add it to the last plot created
last_plot() + gaga_style
```

<img src="appendix-j-spotify_files/figure-html/unnamed-chunk-10-1.png" width="100%" style="display: block; margin: auto;" />


## By Playlist

You need to know the "uri" of a public playlist to access data on it. You can get this by copying the link to the playlist and selecting the 22 characters between "https://open.spotify.com/playlist/" and "?si=...". Let's have a look at the Eurovision 2021 playlist.


```r
eurovision2021 <- get_playlist_audio_features(
  playlist_uris = "37i9dQZF1DWVCKO3xAlT1Q"
)
```

Use `glimpse()` and `count()` to explore the structure of this table.

### Track ratings

Each track has several ratings: danceability, energy, speechiness, acousticness, instrumentalness, liveness, and valence. I'm not sure how these are determined (almost certainly by an algorithm). Let's select the track names and these columns to have a look.


```r
eurovision2021 %>%
  select(track.name, danceability, energy, speechiness:valence) %>%
  datatable()
```

```{=html}
<div id="htmlwidget-51eec364dcc906cc4c1b" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-51eec364dcc906cc4c1b">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39"],["ZITTI E BUONI","Je me casse - Eurovision Official Entry","El Diablo","Voilà","Discoteque","Voices","10 Years","Adrenalina","Set Me Free","Tout l'univers","Last Dance","Embers","Mata Hari","SHUM","RUSSIAN WOMAN","Sugar","Loco Loco","growing up is getting old - Eurovision Version","The Wrong Place","Voy a quedarme","Fallen Angel","Dark Side","Karma","Birth Of A New Age","I Don't Feel Hate","Love Is On My Side","Tick-Tock","Technicolour","Maps","Amnesia","The lucky one","Omaga","The Ride","Øve Os På Hinanden","The Moon Is Rising - Original","Amen","Amen","You","Here I Stand"],[0.62,0.767,0.66,0.447,0.826,0.503,0.798,0.665,0.752,0.534,0.533,0.678,0.706,0.527,0.89,0.694,0.655,0.413,0.491,0.517,0.542,0.571,0.515,0.718,0.827,0.285,0.765,0.665,0.543,0.582,0.403,0.717,0.69,0.678,0.656,0.448,0.442,0.497,0.322],[0.944,0.871,0.664,0.337,0.799,0.759,0.621,0.886,0.664,0.365,0.91,0.819,0.675,0.737,0.701,0.76,0.747,0.193,0.728,0.72,0.647,0.955,0.627,0.718,0.837,0.419,0.758,0.567,0.833,0.693,0.639,0.872,0.771,0.867,0.628,0.397,0.384,0.367,0.195],[0.0863,0.1,0.134,0.0631,0.0594,0.0423,0.0391,0.082,0.0775,0.033,0.0435,0.0577,0.0386,0.0642,0.194,0.0464,0.0841,0.0296,0.0428,0.0488,0.0277,0.105,0.0448,0.0609,0.214,0.0286,0.0352,0.0338,0.0416,0.135,0.0739,0.033,0.0262,0.0268,0.144,0.0478,0.0397,0.0245,0.0365],[0.0014,0.153,0.00395,0.773,0.0477,0.00237,0.0141,0.00319,0.28,0.81,0.0213,0.00283,0.0128,0.05,0.204,0.00495,0.294,0.796,0.0479,0.214,0.071,0.00254,0.00371,0.479,0.19,0.338,0.0503,0.0656,0.0212,0.125,0.0386,0.109,0.403,0.0128,0.0387,0.476,0.0102,0.238,0.512],[0,1.27e-06,0,0,0.00206,1.06e-06,0.000148,1.22e-06,0,2.52e-06,0,2.67e-06,0.000355,7.85e-05,0,0.00566,0,1.09e-06,1.38e-06,0,0,1.55e-06,0,8.8e-06,9.72e-06,3.26e-06,0.00068,0,0,1.38e-06,0,0.00156,0,3.19e-05,0,0.000272,6.51e-05,0.0432,0],[0.733,0.277,0.832,0.298,0.125,0.13,0.0926,0.387,0.102,0.158,0.0699,0.112,0.263,0.105,0.0741,0.134,0.243,0.095,0.16,0.0839,0.108,0.274,0.127,0.234,0.0346,0.197,0.343,0.269,0.36,0.158,0.0918,0.344,0.25,0.344,0.142,0.149,0.0831,0.189,0.318],[0.592,0.79,0.621,0.603,0.628,0.396,0.443,0.529,0.468,0.237,0.393,0.722,0.463,0.499,0.652,0.511,0.594,0.312,0.246,0.355,0.281,0.437,0.192,0.539,0.752,0.244,0.76,0.274,0.547,0.245,0.409,0.886,0.926,0.961,0.331,0.206,0.0843,0.12,0.133]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>track.name<\/th>\n      <th>danceability<\/th>\n      <th>energy<\/th>\n      <th>speechiness<\/th>\n      <th>acousticness<\/th>\n      <th>instrumentalness<\/th>\n      <th>liveness<\/th>\n      <th>valence<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

What was the general mood of Eurovision songs in 2021? Let's use plots to assess. First, we need to get the data into long format to make it easier to plot multiple attributes.


```r
playlist_attributes <- eurovision2021 %>%
  select(track.name, danceability, energy, speechiness:valence) %>%
  pivot_longer(cols = danceability:valence,
               names_to = "attribute",
               values_to = "rating")
```

When we plot everything on the same plot, instrumentalness has such a consistently low value that all the other attributes disappear, 


```r
ggplot(playlist_attributes, aes(x = rating, colour = attribute)) +
  geom_density()
```

<img src="appendix-j-spotify_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" />

You can solve this by putting each attribute into its own facet and letting the y-axis differ between plots by setting `scales = "free_y"`. Now it's easier to see that Eurovision songs tend to have pretty high danceability and energy.


```r
ggplot(playlist_attributes, aes(x = rating, colour = attribute)) +
  geom_density(show.legend = FALSE) +
  facet_wrap(~attribute, scales = "free_y", nrow = 2)
```

<div class="figure" style="text-align: center">
<img src="appendix-j-spotify_files/figure-html/playlist-attributes-facet-1.png" alt="Seven track attributes for the playlist 'Eurovision 2021'" width="100%" />
<p class="caption">(\#fig:playlist-attributes-facet)Seven track attributes for the playlist 'Eurovision 2021'</p>
</div>

### Popularity

Let's look at how these attributes relate to track popularity. We'll exclude instrumentalness, since it doesn't have much variation.


```r
popularity <- eurovision2021 %>%
  select(track.name, track.popularity,
         acousticness, danceability, energy, 
         liveness, speechiness, valence) %>%
  pivot_longer(cols = acousticness:valence,
               names_to = "attribute",
               values_to = "rating")
```



```r
ggplot(popularity, aes(x = rating, y = track.popularity, colour = attribute)) +
  geom_point(alpha = 0.5, show.legend = FALSE) +
  geom_smooth(method = lm, formula = y~x, show.legend = FALSE) +
  facet_wrap(~attribute, scales = "free_x", nrow = 2) +
  labs(x = "Attribute Value",
       y = "Track Popularity")
```

<div class="figure" style="text-align: center">
<img src="appendix-j-spotify_files/figure-html/playlist-popularity-1.png" alt="The relationship between track attributes and popularity." width="100%" />
<p class="caption">(\#fig:playlist-popularity)The relationship between track attributes and popularity.</p>
</div>


### Nested data

Some of the columns in this table contain more tables. For example, each entry in the `track.artist` column contains a table with columns `href`, `id`, `name`, `type`, `uri`, and `external_urls.spotify`. Use `unnest()` to extract these tables. If there is more than one artist for a track, this will expand the table. For example, the track "Adrenalina" has two rows now, one for Senhit and one for Flo Rida.


```r
eurovision2021 %>%
  unnest(track.artists) %>%
  select(track = track.name, 
         artist = name, 
         popularity = track.popularity) %>%
  datatable()
```

```{=html}
<div id="htmlwidget-45c9a9234923ed19c96f" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-45c9a9234923ed19c96f">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"],["ZITTI E BUONI","Je me casse - Eurovision Official Entry","El Diablo","Voilà","Discoteque","Voices","10 Years","Adrenalina","Adrenalina","Set Me Free","Tout l'univers","Last Dance","Embers","Mata Hari","SHUM","RUSSIAN WOMAN","Sugar","Loco Loco","growing up is getting old - Eurovision Version","The Wrong Place","Voy a quedarme","Fallen Angel","Dark Side","Karma","Birth Of A New Age","I Don't Feel Hate","Love Is On My Side","Tick-Tock","Technicolour","Maps","Amnesia","The lucky one","Omaga","The Ride","Øve Os På Hinanden","The Moon Is Rising - Original","Amen","Amen","You","Here I Stand"],["Måneskin","Destiny","Elena Tsagrinou","Barbara Pravi","THE ROOP","Tusse","Daði Freyr","Senhit","Flo Rida","Eden Alene","Gjon's Tears","Stefania","James Newman","Efendi","Go_A","Manizha","Natalia Gordienko","Hurricane","VICTORIA","Hooverphonic","Blas Cantó","TIX","Blind Channel","Anxhela Peristeri","Jeangu Macrooy","Jendrik","The Black Mamba","Albina","Montaigne","Lesley Roy","Roxen","Uku Suviste","Benny Cristo","Rafal Brzozowski","Fyr Og Flamme","Samanta Tina","Ana Soklic","Vincent Bueno","Tornike Kipiani","Vasil Garvanliev"],[70,23,42,68,59,63,65,54,54,56,63,56,54,60,22,58,51,0,48,54,54,61,9,45,48,2,50,49,50,48,53,44,45,43,51,44,40,40,38,37]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>track<\/th>\n      <th>artist<\/th>\n      <th>popularity<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":3},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```


::: {.try data-latex=""}
If you're a Eurovision nerd (like Emily), try downloading playlists from several previous years and visualise trends. See if you can find lists of the [scores for each year](https://en.wikipedia.org/wiki/Eurovision_Song_Contest_2021){target="_blank"} and join the data to see what attributes are most related to points.
:::

## By Genre

Select the first 20 artists in the genre "eurovision". So that people don't spam the Spotify API, you are limited to up to 50 artists per request.





















