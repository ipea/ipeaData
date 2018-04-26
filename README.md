# IpeaData

# ipeaData  [![Build Status](https://travis-ci.org/ipea/ipeaData.svg?branch=master)](https://travis-ci.org/ipea/ipeaData) [![Cran](https://www.r-pkg.org/badges/version/ipeaData)](https://www.r-pkg.org/badges/version/ipeaData) [![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/ipeaData)](https://cranlogs.r-pkg.org/badges/grand-total/ipeaData) [![Coverage](https://img.shields.io/codecov/c/github/ipea/ipeaData/master.svg)](https://img.shields.io/codecov/c/github/ipea/ipeaData/master.svg) [![Rdoc](http://www.rdocumentation.org/badges/version/ipeaData)](http://www.rdocumentation.org/packages/ipeaData)

This package has functions to access series on [IPEADATA](http://www.ipeadata.gov.br/)

## Installation

The package is on CRAN, so to install it just use the command:

```{r eval=FALSE}
install.packages("ipeaData") 
````

## Use

The package has three functions: get_fonts, get_metadata, and get_values.

get_sources returns data from fonts on IPEDATA.
get_metadata returns metadata from a serie.
ipeadata returns values from a given serie.



## Contributing 

To add new functions to this package, it is needed to create a new breach with the new code and submit a 
pull request to branch dev. 

To create the new branch using git command line use the command:

```{r eval=FALSE}
git checkout -b name_of_new_branch
````

To do it on RStudio just click on Tools >> Shell. On the new opened window type the command above. 

After adding the new code and [**tests**](http://r-pkgs.had.co.nz/tests.html#test-tests) commit the changes to the git repository and check on [travis](https://travis-ci.org/ipea/utilsIPEA) 
if it has been build correctly. 

Now, the code is ready to be incorporated to master branch. To do so, a [pull request](https://help.github.com/articles/about-pull-requests/) has to be made to branch dev. The branch dev contains all code that is not released on CRAN.
