
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vacancesscolr

[![Travis build
status](https://travis-ci.org/Tutuchan/vacancesscolr.svg?branch=master)](https://travis-ci.org/Tutuchan/vacancesscolr)

The goal of `vacancesscolr` is to be able to quickly retrieve school
holidays in France for the 2008-2018 period and bank holidays for any
given year.

The data used in this package has been obtained from [Antoine Augusti’s
vacances-scolaires
dataset](https://github.com/AntoineAugusti/vacances-scolaires), under
the Etalab license (open license).

The functionalities are direct ports from his
[vacances-scolaires-france](https://github.com/AntoineAugusti/vacances-scolaires-france)
and
[jours-feries-france](https://github.com/AntoineAugusti/jours-feries-france)
Python packages, under MIT license.

## Installation

`vacancesscolr` lives only on Github for now. Please use `devtools` or
`remotes` to install it.

``` r
# devtools::install_github("tutuchan/vacancesscolr")
# remotes::install_github("tutuchan/vacancesscolr")
```

## Examples

### Holidays

Check if a date is a holiday:

``` r
is_holiday("2018-03-05")
#> [1] TRUE
is_holiday("2018-03-05", zone = "A")
#> [1] FALSE
is_holiday("2018-03-05", zone = "B")
#> [1] TRUE
```

Retrieve all holidays for a year, optional zone and optional type of
holiday:

``` r
get_holidays(2018, name = "Vacances d'hiver")
#>          date vacances_zone_a vacances_zone_b vacances_zone_c
#> 1  2018-02-10            TRUE           FALSE           FALSE
#> 2  2018-02-11            TRUE           FALSE           FALSE
#> 3  2018-02-12            TRUE           FALSE           FALSE
#> 4  2018-02-13            TRUE           FALSE           FALSE
#> 5  2018-02-14            TRUE           FALSE           FALSE
#> 6  2018-02-15            TRUE           FALSE           FALSE
#> 7  2018-02-16            TRUE           FALSE           FALSE
#> 8  2018-02-17            TRUE           FALSE            TRUE
#> 9  2018-02-18            TRUE           FALSE            TRUE
#> 10 2018-02-19            TRUE           FALSE            TRUE
#> 11 2018-02-20            TRUE           FALSE            TRUE
#> 12 2018-02-21            TRUE           FALSE            TRUE
#> 13 2018-02-22            TRUE           FALSE            TRUE
#> 14 2018-02-23            TRUE           FALSE            TRUE
#> 15 2018-02-24            TRUE            TRUE            TRUE
#> 16 2018-02-25            TRUE            TRUE            TRUE
#> 17 2018-02-26           FALSE            TRUE            TRUE
#> 18 2018-02-27           FALSE            TRUE            TRUE
#> 19 2018-02-28           FALSE            TRUE            TRUE
#> 20 2018-03-01           FALSE            TRUE            TRUE
#> 21 2018-03-02           FALSE            TRUE            TRUE
#> 22 2018-03-03           FALSE            TRUE            TRUE
#> 23 2018-03-04           FALSE            TRUE            TRUE
#> 24 2018-03-05           FALSE            TRUE           FALSE
#> 25 2018-03-06           FALSE            TRUE           FALSE
#> 26 2018-03-07           FALSE            TRUE           FALSE
#> 27 2018-03-08           FALSE            TRUE           FALSE
#> 28 2018-03-09           FALSE            TRUE           FALSE
#> 29 2018-03-10           FALSE            TRUE           FALSE
#> 30 2018-03-11           FALSE            TRUE           FALSE
#>        nom_vacances
#> 1  Vacances d'hiver
#> 2  Vacances d'hiver
#> 3  Vacances d'hiver
#> 4  Vacances d'hiver
#> 5  Vacances d'hiver
#> 6  Vacances d'hiver
#> 7  Vacances d'hiver
#> 8  Vacances d'hiver
#> 9  Vacances d'hiver
#> 10 Vacances d'hiver
#> 11 Vacances d'hiver
#> 12 Vacances d'hiver
#> 13 Vacances d'hiver
#> 14 Vacances d'hiver
#> 15 Vacances d'hiver
#> 16 Vacances d'hiver
#> 17 Vacances d'hiver
#> 18 Vacances d'hiver
#> 19 Vacances d'hiver
#> 20 Vacances d'hiver
#> 21 Vacances d'hiver
#> 22 Vacances d'hiver
#> 23 Vacances d'hiver
#> 24 Vacances d'hiver
#> 25 Vacances d'hiver
#> 26 Vacances d'hiver
#> 27 Vacances d'hiver
#> 28 Vacances d'hiver
#> 29 Vacances d'hiver
#> 30 Vacances d'hiver
```

You can use shortened names for the holidays names:

``` r
holidays_names_full()
#> [1] "Vacances de Noël"         "Vacances d'hiver"        
#> [3] "Vacances de printemps"    "Vacances d'été"          
#> [5] "Vacances de la Toussaint"

holidays_names_short()
#> [1] "noel"      "hiver"     "printemps" "ete"       "toussaint"
```

### Bank holidays

Get all bank holidays for a year:

``` r
get_bank_holidays(2018)
#>               type       date
#> 5          jour_an 2018-01-01
#> 1           paques 2018-04-01
#> 2     lundi_paques 2018-04-02
#> 6     fete_travail 2018-05-01
#> 7  victoire_allies 2018-05-08
#> 3        ascension 2018-05-10
#> 4        pentecote 2018-05-21
#> 8   fete_nationale 2018-07-14
#> 9       assomption 2018-08-15
#> 10       toussaint 2018-11-01
#> 11       armistice 2018-11-11
#> 12            noel 2018-12-25
```

Get a specific bank holiday:

``` r
bh_lundi_paques(2018)
#> [1] "2018-04-02"
```

Get the names of bank holidays (some have multiple ways to call them):

``` r
bank_holidays_names()
#>  [1] "paques"           "lundi_paques"     "vendredi_saint"  
#>  [4] "ascension"        "pentecote"        "jour_an"         
#>  [7] "1 mai"            "premier_mai"      "fete_travail"    
#> [10] "8 mai"            "huit_mai"         "victoire_allies" 
#> [13] "14 juillet"       "quatorze_juillet" "fete_nationale"  
#> [16] "15 aout"          "quinze_aout"      "assomption"      
#> [19] "toussaint"        "11 novembre"      "onze_novembre"   
#> [22] "armistice"        "noel"             "saint_etienne"

bank_holidays_names_unique()
#>  [1] "paques"          "lundi_paques"    "vendredi_saint" 
#>  [4] "ascension"       "pentecote"       "jour_an"        
#>  [7] "fete_travail"    "victoire_allies" "fete_nationale" 
#> [10] "assomption"      "toussaint"       "armistice"      
#> [13] "noel"            "saint_etienne"
```

Get a bank holiday knowing its name:

``` r
bank_holiday("1 mai")(2018)
#> [1] "2018-05-01"
```
