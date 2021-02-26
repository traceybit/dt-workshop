# Eco-data-science data.table workshop

This is a workshop geared at giving an introduction to, as well as some hands-on experience in using, the ``data.table`` package in R.

To get this workshop's materials, please feel free to either **fork** this repository or **download** it as a .zip.

## Workshop structure

We will begin the workshop with a presentation. The presentation includes examples of ``data.table`` and ``tidyverse`` coding chunks -- there is a ``follow-along.R`` script that allows you to run the code chunks along with the presentation.

Then, we will move into a hands-on coding session in an R notebook, where we will go through some examples of how we can analyze data using the ``data.table`` package.

## Requirements

This workshop will be focused on the R programming language, and there is an live coding component that takes place in an R notebook. If you would like to partake in the live coding, please have RStudio installed.

As for packages, you will need the following R packages to follow along with the presentation and to participate in the live coding session:
  * `data.table`
  * `tidyverse`
  * `here`
  * `janitor`
  * `microbenchmark`
  
To install any of the packages above, run the following lines of code as necessary:
  
```
install.packages('data.table')
install.packages('tidyverse')
install.packages('here')
install.packages('janitor')
install.packages('microbenchmark')
```
  
## Data
  
We will be using a few different datasets for our presentation and hands-on coding session. Due to the size of the data files, they were not hosted here in the repo. Instead, please download the data files using this link: [dt-workshop-data](https://drive.google.com/drive/folders/1QGHJ-HkCxHyuj5axptNkPYkLmyF8kygS?usp=sharing)

Then, drop the three data .csv files into the ``/data`` folder here in the repo. The ``.gitignore`` already includes the data .csv files in there (assuming they are properly located in the ``/data`` folder), so the files should not be tracked to be committed.
