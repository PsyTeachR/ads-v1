# Using Teams {#teams}

## What is the best way to share R code on Microsoft Teams?

You have run into a problem and need to get help on MS Teams. What is the right way to share your code?

Please do *not* share a screenshot unless you are asked, or if it is not the code that is giving you problems, but something weird is happening with the RStudio IDE.

If it's your code that is not working, it is almost always better to copy and paste the code, because then people who are trying to help you can copy and paste the code *exactly* to try it out, rather than having to re-type everything from the image. Let's look at an example. Below is a screenshot of how the RStudio IDE might look when your code throws an error. Here the code block labelled `cars` is causing the error.

![*a screenshot of RStudio IDE showing an error indicated by the red arrow*](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/mtcars_error.jpg)

The particular error that our code threw was

    Error in mtcars %>% filter(mpg > 20) : could not find function "%>%"

And the code that threw it was


```r
mtcars %>%
  filter(mpg > 20)
```

Note that you can select and copy the code above if you wanted to run it yourself, but you could not do that if all you had to rely on was the screenshot.

Copying the code and/or error in RStudio is easy; just highlight the code using the mouse and press Ctrl-C.

If you just paste the code into a Teams channel, the formatting is not so nice; you lose the formatting that allows you to read the code easily.

![*A screenshot of MS Teams with the code pasted directly in. Not pretty!*](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_paste1.jpg)

Here are two ways to get your code into Teams, one that is quick and easy but not very flexible, and another that is far more flexible but requires more steps.

### Quick and easy method

First, if it is just a short function call, a single line, or an error, you can signal that text is meant to appear as code by surrounding it by single backticks---i.e., putting a backtick (\`) right before and right after the text that you want to be formatted as code. Teams will automatically format it for you.

For multi-line code, the easiest and fastest way is just to type three backticks inside your message at the beginning of a line. Any subsequent text you enter will be treated as code. To get to the beginning of a line without submitting your post, press Ctrl-Enter while typing your message. Then type the three backticks, and paste your code right into the gray box that automatically appears. Press Enter twice in a row to get back out of the code entry box. So your message might look like this. ![A screenshot of MS Teams with code embedded in a chunk.](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_chunk.jpg)

Above, I surrounded the error message `Error in mtcars %>% filter(mpg > 20) : could not find function "%>%"` with single backticks to indicate code, and we typed triple backticks at the start of the line to create a code chunk. (The next method might be easier for making multi-line posts.)

### More flexible method

There is a more flexible (and possibly easier) way. Before pasting any text, click on the icon that looks like the letter "A", highlighted below.

![Screenshot of Teams showing the icon that looks like an "A"](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_paste2.jpg) 

This will open up options for text formatting and will allow you to easily create a multi-line post. From those options, select the icon that looks like `</>`, which stands for code. 

![Screenshot of Teams formatting icons, with code icon highlighted](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_paste3.jpg) 

The code icon will open a window where you can paste your code. In the dropdown menu on the top right, select 'R' as the type of code. This will give you syntax highlighting. 

![Screenshot of Teams formatting icons, with code icon highlighted](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_paste4.jpg) 

Here is how you might begin your post. 

![Screenshot of Teams with unsubmitted post](https://raw.githubusercontent.com/PsyTeachR/FAQ/master/images/teams_paste5.jpg) 

### Taking it one step further!

If you really want to go down the rabbit hole, you can create a reproducible example using the [reprex](https://www.tidyverse.org/help/#reprex) package from tidyverse.

## Screenshots

If you do need to take a screenshot, for example, if something goes wrong during installation, please use the screenshot functions built-in to your computer rather than taking a photo of your screen using your phone.

### Taking a screenshot on Windows

-   Use the Windows search function to search for "Snip & Sketch"

-   Click "New" then "Snip now"

-   Use the tool to select the area on the screen you want to take a screenshot of. This photo will automatically be copied to your clipboard, so you can paste it into e.g., a Teams chat or a document using Ctrl + V but you can also click the Save icon in the top right to save the screenshot as an image file.

-   The shortcut for the snipping tool is Win + Shift + S.

### Taking a screenshot on Mac

-   Press Shift + Command (???) + 4 to bring up the Screenshot app.

-   Use the tool to select the area on the screen you want to take a screenshot of.

-   If you see a thumbnail in the corner of your screen, click it to edit the screenshot or drag it into e.g., a Teams chat.

-   This photo will also automatically save to your desktop.
