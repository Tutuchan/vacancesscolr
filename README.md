
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vacancesscolr

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

**Please note that data.frames are printed as `tibble`s in this README
for clarity but they are simple `data.frame`s in R.**

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
get_year_holidays(2018, name = "Vacances d'hiver")
#> # A tibble: 30 x 5
#>    date       vacances_zone_a vacances_zone_b vacances_zone_c nom_vacances
#>  * <date>     <lgl>           <lgl>           <lgl>           <chr>       
#>  1 2018-02-10 TRUE            FALSE           FALSE           Vacances d'…
#>  2 2018-02-11 TRUE            FALSE           FALSE           Vacances d'…
#>  3 2018-02-12 TRUE            FALSE           FALSE           Vacances d'…
#>  4 2018-02-13 TRUE            FALSE           FALSE           Vacances d'…
#>  5 2018-02-14 TRUE            FALSE           FALSE           Vacances d'…
#>  6 2018-02-15 TRUE            FALSE           FALSE           Vacances d'…
#>  7 2018-02-16 TRUE            FALSE           FALSE           Vacances d'…
#>  8 2018-02-17 TRUE            FALSE           TRUE            Vacances d'…
#>  9 2018-02-18 TRUE            FALSE           TRUE            Vacances d'…
#> 10 2018-02-19 TRUE            FALSE           TRUE            Vacances d'…
#> # ... with 20 more rows
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
get_year_bank_holidays(2018)
#> # A tibble: 12 x 2
#>    type            date      
#>  * <chr>           <date>    
#>  1 jour_an         2018-01-01
#>  2 paques          2018-04-01
#>  3 lundi_paques    2018-04-02
#>  4 fete_travail    2018-05-01
#>  5 victoire_allies 2018-05-08
#>  6 ascension       2018-05-10
#>  7 pentecote       2018-05-21
#>  8 fete_nationale  2018-07-14
#>  9 assomption      2018-08-15
#> 10 toussaint       2018-11-01
#> 11 armistice       2018-11-11
#> 12 noel            2018-12-25
```

Get a specific bank holiday:

``` r
bh_lundi_paques(2018)
#> [1] "2018-04-02"
```

Get the names of bank holidays (some have multiple ways to call them):

``` r
bank_holiday_names()
#>  [1] "paques"           "lundi_paques"     "vendredi_saint"  
#>  [4] "ascension"        "pentecote"        "jour_an"         
#>  [7] "1 mai"            "premier_mai"      "fete_travail"    
#> [10] "8 mai"            "huit_mai"         "victoire_allies" 
#> [13] "14 juillet"       "quatorze_juillet" "fete_nationale"  
#> [16] "15 aout"          "quinze_aout"      "assomption"      
#> [19] "toussaint"        "11 novembre"      "onze_novembre"   
#> [22] "armistice"        "noel"             "saint_etienne"

bank_holiday_names_unique()
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
