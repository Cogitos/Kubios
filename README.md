# KUBIOS R Package

- **Author:** Guillaume T. Vallet, guillaume.vallet@uqtr.ca, Université du Québec à Trois-Rivières, CRIUGM
- **Version:** 0.2
- **Date:** 2025/05/13

*kubios* is R package developed for a personal use to extract HRV statistics from 1 or more Kubios files.

The detailed description of the functions as well as examples are provided in the R documentation. 
Type ``?*function_name*`` in your R console to access it.


## Table of Contents

- [Licence](#licence)
- [Dependencies](#dependencies)
- [Installation](#install)
- [Functions](#functions)


## <a name='licence'></a>Licence

This package is released under the [Creative Common Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0/) license.


## <a name='dependencies'></a>Dependencies

*kubios* depends on the ``tidyverse`` and ``janitor`` packages. 
You can install them by typing ``install.packages('tidyverse', 'janitor')`` in your R console.


## <a name='install'></a>Installation

To install a R package from Github, you first need to install the devtools package.
In R, type ``install.packages('devtools')``. 
Then install *kubios* with the following command : ``install_github('cogitos/kubios')``.
And now enjoy the package!


## <a name='functions'></a>Functions

### readKubios

This function is designed to extract either the RMSSD or the HF statistics from 1 or more Kubios csv files. 
The function return a dataframe with the corresponding measures across the different samples found in the Kubios files. 
