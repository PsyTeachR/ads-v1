# Conventions

This book will use the following conventions:

* Generic code: `list(number = 1, letter = "A")`
* Highlighted code: <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/base/list.html'>list</a></span><span class='op'>(</span>number <span class='op'>=</span> <span class='fl'>1</span>, letter <span class='op'>=</span> <span class='st'>"A"</span><span class='op'>)</span></code>
* File paths: <code class='path'>data/sales.csv</code>
* R Packages: <code class='package'>tidyverse</code>
* Functions: <code><span class='fu'><a target='_blank' href='https://rdrr.io/r/base/paste.html'>paste</a></span><span class='op'>(</span><span class='op'>)</span></code>
* Strings: <code><span class='st'>"Lisa"</span></code>, <code><span class='st'>"Emily"</span></code>
* Numbers: <code><span class='fl'>100</span></code>, <code><span class='fl'>3.14</span></code>
* Logical values: <code><span class='cn'>TRUE</span></code>, <code><span class='cn'>FALSE</span></code>
* Glossary items: <a class='glossary' target='_blank' title='Discrete variables that have an inherent order, such as number of legs' href='https://psyteachr.github.io/glossary/o#ordinal'>ordinal</a>
* Citations: @R-tidyverse
* Internal links: Chapter\ \@ref(viz)
* External links: [Mastering Shiny](https://mastering-shiny.org/){target="_blank"}
* Menu/interface options: **`New File...`**
* Quiz question: I am going to learn a lot: <select class='webex-select'><option value='blank'></option><option value='answer'>TRUE</option><option value=''>FALSE</option></select>

* What is a p-value? <div class='webex-radiogroup' id='radio_DLBGGTXAHZ'><label><input type="radio" autocomplete="off" name="radio_DLBGGTXAHZ" value=""></input> <span>the probability that the null hypothesis is true</span></label><label><input type="radio" autocomplete="off" name="radio_DLBGGTXAHZ" value="answer"></input> <span>the probability of the observed, or more extreme, data, under the assumption that the null-hypothesis is true</span></label><label><input type="radio" autocomplete="off" name="radio_DLBGGTXAHZ" value=""></input> <span>the probability of making an error in your conclusion</span></label></div>



<div class='webex-solution'><button>Hidden Solutions</button>
You found it!
</div>

::: {.info data-latex=""}
Informational asides.
:::

::: {.warning data-latex=""}
Notes to warn you about something.
:::

::: {.dangerous data-latex=""}
Notes about things that could cause serious errors.
:::

::: {.try data-latex=""}
Try it yourself.
:::


```r
# code chunks
paste("Code", "Output", 1, sep = " ")
```

```
## [1] "Code Output 1"
```

<div class='verbatim'><pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;{r, fig.width = 2, fig.height = 2}</code></pre>

```r
# code chunks with headers
hist(rnorm(100000))
```

<pre class='sourceCode r'><code class='sourceCode R'>&#96;&#96;&#96;</code></pre></div>


```md
## Markdown Example

* Inline code: `r nrow(iris)`
* *Italics*
* **Bold**
```



