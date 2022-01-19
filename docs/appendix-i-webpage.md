# Webpages

In this tutorial, you will learn how to create a simple webpage using <a class='glossary' target='_blank' title='The R-specific version of markdown: a way to specify formatting, such as headers, paragraphs, lists, bolding, and links, as well as code blocks and inline code.' href='https://psyteachr.github.io/glossary/r#r-markdown'>R Markdown</a>, link multiple pages, and style your content using <a class='glossary' target='_blank' title='Cascading Style Sheet: A system for controlling the visual presentation of HTML in web pages.' href='https://psyteachr.github.io/glossary/c#css'>css</a>.

## Create a webpage {#webpage-create}

### Create a project 

1. Choose `New Project...` from the `File` menu (don't save any workspaces)
2. Choose `New Directory` > `Simple R Markdown Website` 
3. Set your project name to "mywebpage"

### Site header

This is where you can set options like whether to show a table of contents and what the navigation bar will look like. We'll edit this later to add a section menu.

1. Open the file `_site.yml`
2. Replace the text with the following:

    ```
    name: "mywebpage"  
    author: "YOUR NAME"  
    output_dir: "docs"  
    output:  
      html_document:  
        self_contained: no  
        theme: 
          version: 4
          bootswatch: yeti 
    navbar:  
      title: "My First Webpage"  
        left:
        - text: "Home"
          href: index.html
        - text: "About"
          href: about.html
    ```
    
3. Save the file (do not change the name)

### Edit the pages

Edit the text in the `index.Rmd` and `about.Rmd` pages. You can use R markdown, including code chunks.


### Render the site

In the upper right "Build" pane, click on the "Build website" hammer icon. This will render the website and automatically open it in a browser window. Alternatively, type the following into the Console pane:


```r
browseURL(rmarkdown::render_site(encoding = 'UTF-8'))
```

If you accidentally close the website and want to look at it again, you don't have to re-render it. Click on the `docs` directory in the `Files` tab of the lower right pane, then click on `index.html` and choose **`View in Web Browser`**

## Add pages {#webpage-pages}

1. Create a new .Rmd file for each webpage
2. Add content to the webpages using R Markdown
3. Re-render the site

If you include linked content like image files, make sure they are copied to your main project directory and linked using <a class='glossary' target='_blank' title='The location of a file in relation to the working directory.' href='https://psyteachr.github.io/glossary/r#relative-path'>relative paths</a>.

To get your webpage online, copy the contents of the `docs` directory to a web server. If you don't have access to a web server, you can make free websites using a GitHub repository and [GitHub Pages](https://pages.github.com/){target="_blank"}).


## Styles {#webpage-styles}

You can change the appearance of your website by changing the theme in the `_site.yml` file (see Appendix\ \@ref(plotstyle)), but the instructions below will help you to customise things even further.


### Add custom styles

You can add a custom style sheet (a document that determines how each element of your website should look) by adding the line `css: style.css` under `html_document:` in the `_site.yml` file.

```
output:  
  html_document:  
    self_contained: no  
    theme: 
      version: 4
      bootswatch: readable
    css: style.css
```

Then you need to create a file named `style.css` and add your custom styles there. The web has thousands of guides to CSS, but [codeacademy](https://www.codecademy.com/en/tracks/htmlcss) has great interactive tutorials for learning html, css, and even more advanced web coding like javascript.

However, the basics of css are easy to learn and it's best to just start playing around with it. Add the following text to your `style.css` file and re-render the website.

### Change global fonts and colours

```
body {
  font-size: 2em;
  font-family: "Times New Roman";
  color: white;
  background-color: #660000;
}
```

<style>
  #body-example * {
    font-size: 2em;
    font-family: "Times New Roman";
    color: white;
    background-color: #660000;
  }
</style>

<div id="body-example">

This will make the text on your website larger, a different font, and change the text and background colours.

</div>

The theme you're using might have css that blocks the styles you're trying to change. You can add `!important` before the end colon to override that.
    
### Change certain elements

Maybe you only want to change the font colour for your headings, not the rest of the text. You can apply a style to a specific *element* type by specifying the element name before the curly brackets. 

```
h1, h2, h3 {
  text-align: center;
  color: hsl(0, 100%, 20%);
}

h3 {
  font-style: italic;
}

p {
  border: 1px solid green;
  padding: 10px;
  line-height: 2;
}

ul {
  border: 3px dotted red;
  border-radius: 10px;
  padding: 10px 30px;
}
```

<style>
  #h-example h2, 
  #h-example h3, 
  #h-example h4 {
    text-align: center;
    color: hsl(0, 100%, 20%);
  }
  
  #h-example h4 {
    font-style: italic;
  }
  
  #h-example p {
    border: 1px solid green;
    padding: 10px;
    line-height: 2;
  }
  
  #h-example ul {
    border: 3px dotted red;
    border-radius: 10px;
    padding: 10px 30px;
  }
</style>

<div id="h-example">

## Example using the styles above

The CSS above changes the styles for three levels of headers (`h2`, `h3`, `h4`) and sets the third level to italics.

### Level 3 header

It also gives paragraphs (`p`) a green border and double-spacing.

#### Level 4 header

Unordered Lists (`ul`) get:

* dotted red border
* round corners
* increased padding on top (`10px`) and sides (`30px`)

</div>

