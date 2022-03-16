# Practice Report

## Assessment information

-   You will be given a dataset and a finished report on that data. Your task is to write the code that produces the report.
-   Please check Moodle and the assessment information sheet for the deadline.
-   The solution will be released immediately after the deadline on Moodle.
-   This is a formative activity and does not count towards your course grade.
-   You should submit two files to Moodle to complete the exercise - your .Rmd file and the knitted html document.
-   Please read all the assessment information before attempting the exercise. Additionally, you should not expect to be able to complete it until you have worked through Chapters 1-5 (although particularly Chapters 1-3).
-   The practice report will not be individually graded. Instead, we will release the solution file so that you can compare your code to our solution as generic feedback. If you would like to discuss any aspect of the report, you can attend office hours with the course leads and/or teaching assistants.

## Intended Learning Outcomes (ILOs)

Knowledge and skills

-   Demonstrate the ability to use R for data wrangling and visualisation

-   Demonstrate the ability to use R Markdown for reproducible reports

Evaluation

-   Demonstrate the ability to evaluate an output to understand the underlying data wrangling and analysis

Communication

-   Demonstrate the ability to produce a clear and coherent report with appropriate spelling, grammar, and layout.

## Details and files

-   There are two files you need to download. The first is the dataset: [review_data.csv](https://psyteachr.github.io/ads-v1/data/review_data.csv). The second is the finished report that you need to backwards engineer from the data: [formative_report_output.html]((https://psyteachr.github.io/ads-v1/data/formative_report_output.html).

-   There are multiple ways to achieve the same outcome when coding. You do not have to use the same solutions that we did, what matters is that the output is the same.

-   All plots, and tables in the report should be fully reproducible, in addition, all numbers in bold should also be reproducible, i.e., you should use inline coding.

-   For any visuals, you should get as close to the example report as possible, although we recognise that it may be difficult to know the exact theme or colours used without seeing the code.

-   In order to replicate the report you will need the following skills:

    -   Markdown text formatting (e.g., bold, italics, headings)

    -   Adding images to Markdown from online sources

    -   Data visualisation

    -   Summarising data in tables Inline coding

Almost everything you need to do generate this report will have been covered at least once in the workbook, but you should also expect to need to Google some things - being able to search for alternative solutions is such a key skill for programming.

## Support

This assessment will require you to use the skills you have learned from Chapter 1 (Intro to R and R Studio) up to and including Chapter 5 (Data Summaries) of the Applied Data Skills workbook. You can also ask for help on Teams, although because this is a formative activity, the help we give will be constrained.

Google and Stack Overflow will help you a lot. Remember to include the names of packages and functions to help ensure the results are closer to what you're trying to do.

## Helpful hints

A few hints to help you on your way:

-   This dataset is bigger than the ones you've used before, which means you might find it takes R a little longer to complete certain tasks.
-   Googling "ggplot rotate x axis labels" will help you out.
-   theme_fivethirtyeight()
-   The verified review definition is formatted as a block quote.
-   [Create Awesome HTML Table with knitr::kable and kableExtra](https://haozhu233.github.io/kableExtra/awesome_table_in_html)
-   [How to Turn off scientific notation like 1e+09 in R?](<https://community.rstudio.com/t/how-to-turn-off-scientific-notation-like-1e-09-in-r/71575)
-   There are a couple of ways you can create the final plot, one method might be to calculate the numbers you need first, and then use this new dataset for the plot, another method would be to use stat_summary().

## Why am I being assessed like this?

This report serves as a practice for the full report, which will be due at the end of the semester. The practice report gives you the intended output so that you can focus on your coding skills, rather than deciding how to summarise and present the data. You will need to make these decisions for the full report.

Whist most of the skills required for the practice report have been explicitly taught, there are minor bits of the coding that will require you to look up solutions independently. This will be good practice for the final summative assessment and for applying your coding skills to your own work.
