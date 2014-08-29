## `neonTerms`
This is a package that will manage data about NEON's internal data product structures

### Quick start



```r
#install.packages("devtools")
#library(devtools)
#install_github("NEONdps/neonTerms")
library(neonTerms)
library(RSQLite)
```

```
## Loading required package: DBI
```

```r
options(stringsAsFactors = F)
```



### Create and set a database in options

First thing you can do is create a database.  Setting it in options makes your life a bit easier.


```r
createDB("test.sqlite")
db <- "test.sqlite"
options(termDB = "test.sqlite")
```


### Load in data from csv's

Next load data into CSV's


```r
dpd <- read.csv("testdata/dpd.csv")
space <- read.csv("testdata/spatial.csv")
temporal <- read.csv("testdata/temporal.csv")
datapub <- read.csv("testdata/mam_datain_test.csv")
genIS <- read.csv("testdata/genericIS_L1.csv")

## Add rev numbers

dpd$rev <- 1
```

Finally you can  add data to the the database.  We'll input the data publication workooks to create table definitions.

```r
addDPD(dpd)
```

```
## [1] "Successfully wrote 7 rows to the DataProductDescription table in your database test.sqlite"
```

```r
addTempRes(temporal)
```

```
## [1] "Successfully wrote 10 rows to the TemporalResolution table in your database test.sqlite"
```

```r
addSpRes(space)
```

```
## [1] "Successfully wrote 26 rows to the SpatialResolution table in your database test.sqlite"
```

```r
inputDataPub(datapub,db)
```

```
## [1] "Successfully wrote 38 rows to the TermDefinition table in your database test.sqlite"
```

```
## Warning: RS-DBI driver warning: (closing pending result sets before closing this connection)
## Warning: RS-DBI driver warning: (closing pending result sets before closing this connection)
## Warning: RS-DBI driver warning: (closing pending result sets before closing this connection)
```

```
## [1] "Successfully wrote 2 rows to the TableDescription table in your database test.sqlite"
## [1] "Successfully wrote 2 rows to the TableDPLink table in your database test.sqlite"
```

```
## Warning: RS-DBI driver warning: (closing pending result sets before closing this connection)
## Warning: RS-DBI driver warning: (closing pending result sets before closing this connection)
```

```
## [1] "Successfully wrote 44 rows to the TableDefinition table in your database test.sqlite"
```

```r
inputDataPub(genIS,db)
```

```
## [1] "Successfully wrote 6 rows to the TermDefinition table in your database test.sqlite"
## [1] "Successfully wrote 1 rows to the TableDescription table in your database test.sqlite"
## [1] "Successfully wrote 1 rows to the TableDPLink table in your database test.sqlite"
## [1] "Successfully wrote 10 rows to the TableDefinition table in your database test.sqlite"
```

```r
## I input a generic table, so we can make extra linkages by adding a new entry to the table description table
toAdd <- data.frame(c("NEON.DOM.SIT.DP1.00002","NEON.DOM.SIT.DP1.00003"))
toAdd <- cbind(c(3,3),toAdd)
colnames(toAdd) <- c("tableID","dpID")
addTDPL(toAdd)
```

```
## [1] "Successfully wrote 2 rows to the TableDPLink table in your database test.sqlite"
```


### Retrieve data

Data can be accessed via data product numbers,  Once data product numbers have been fully extracted you can easily generate a full suite of unique field numbers

```r
out <- qFull("NEON.DOM.SIT.DP1.00002",db)
### Generate full numbers
genFieldUID(out,db)
```

```
##   [1] "NEON.DOM.SIT.DP1.00002.001.001.001.00001.003"
##   [2] "NEON.DOM.SIT.DP1.00002.001.001.001.00002.003"
##   [3] "NEON.DOM.SIT.DP1.00002.001.001.001.00003.003"
##   [4] "NEON.DOM.SIT.DP1.00002.001.001.001.00005.003"
##   [5] "NEON.DOM.SIT.DP1.00002.001.001.001.00039.003"
##   [6] "NEON.DOM.SIT.DP1.00002.001.001.001.00040.003"
##   [7] "NEON.DOM.SIT.DP1.00002.001.001.001.00041.003"
##   [8] "NEON.DOM.SIT.DP1.00002.001.001.001.00042.003"
##   [9] "NEON.DOM.SIT.DP1.00002.001.001.001.00043.003"
##  [10] "NEON.DOM.SIT.DP1.00002.001.001.001.00044.003"
##  [11] "NEON.DOM.SIT.DP1.00002.002.001.001.00001.003"
##  [12] "NEON.DOM.SIT.DP1.00002.002.001.001.00002.003"
##  [13] "NEON.DOM.SIT.DP1.00002.002.001.001.00003.003"
##  [14] "NEON.DOM.SIT.DP1.00002.002.001.001.00005.003"
##  [15] "NEON.DOM.SIT.DP1.00002.002.001.001.00039.003"
##  [16] "NEON.DOM.SIT.DP1.00002.002.001.001.00040.003"
##  [17] "NEON.DOM.SIT.DP1.00002.002.001.001.00041.003"
##  [18] "NEON.DOM.SIT.DP1.00002.002.001.001.00042.003"
##  [19] "NEON.DOM.SIT.DP1.00002.002.001.001.00043.003"
##  [20] "NEON.DOM.SIT.DP1.00002.002.001.001.00044.003"
##  [21] "NEON.DOM.SIT.DP1.00002.001.002.001.00001.003"
##  [22] "NEON.DOM.SIT.DP1.00002.001.002.001.00002.003"
##  [23] "NEON.DOM.SIT.DP1.00002.001.002.001.00003.003"
##  [24] "NEON.DOM.SIT.DP1.00002.001.002.001.00005.003"
##  [25] "NEON.DOM.SIT.DP1.00002.001.002.001.00039.003"
##  [26] "NEON.DOM.SIT.DP1.00002.001.002.001.00040.003"
##  [27] "NEON.DOM.SIT.DP1.00002.001.002.001.00041.003"
##  [28] "NEON.DOM.SIT.DP1.00002.001.002.001.00042.003"
##  [29] "NEON.DOM.SIT.DP1.00002.001.002.001.00043.003"
##  [30] "NEON.DOM.SIT.DP1.00002.001.002.001.00044.003"
##  [31] "NEON.DOM.SIT.DP1.00002.002.002.001.00001.003"
##  [32] "NEON.DOM.SIT.DP1.00002.002.002.001.00002.003"
##  [33] "NEON.DOM.SIT.DP1.00002.002.002.001.00003.003"
##  [34] "NEON.DOM.SIT.DP1.00002.002.002.001.00005.003"
##  [35] "NEON.DOM.SIT.DP1.00002.002.002.001.00039.003"
##  [36] "NEON.DOM.SIT.DP1.00002.002.002.001.00040.003"
##  [37] "NEON.DOM.SIT.DP1.00002.002.002.001.00041.003"
##  [38] "NEON.DOM.SIT.DP1.00002.002.002.001.00042.003"
##  [39] "NEON.DOM.SIT.DP1.00002.002.002.001.00043.003"
##  [40] "NEON.DOM.SIT.DP1.00002.002.002.001.00044.003"
##  [41] "NEON.DOM.SIT.DP1.00002.001.003.001.00001.003"
##  [42] "NEON.DOM.SIT.DP1.00002.001.003.001.00002.003"
##  [43] "NEON.DOM.SIT.DP1.00002.001.003.001.00003.003"
##  [44] "NEON.DOM.SIT.DP1.00002.001.003.001.00005.003"
##  [45] "NEON.DOM.SIT.DP1.00002.001.003.001.00039.003"
##  [46] "NEON.DOM.SIT.DP1.00002.001.003.001.00040.003"
##  [47] "NEON.DOM.SIT.DP1.00002.001.003.001.00041.003"
##  [48] "NEON.DOM.SIT.DP1.00002.001.003.001.00042.003"
##  [49] "NEON.DOM.SIT.DP1.00002.001.003.001.00043.003"
##  [50] "NEON.DOM.SIT.DP1.00002.001.003.001.00044.003"
##  [51] "NEON.DOM.SIT.DP1.00002.002.003.001.00001.003"
##  [52] "NEON.DOM.SIT.DP1.00002.002.003.001.00002.003"
##  [53] "NEON.DOM.SIT.DP1.00002.002.003.001.00003.003"
##  [54] "NEON.DOM.SIT.DP1.00002.002.003.001.00005.003"
##  [55] "NEON.DOM.SIT.DP1.00002.002.003.001.00039.003"
##  [56] "NEON.DOM.SIT.DP1.00002.002.003.001.00040.003"
##  [57] "NEON.DOM.SIT.DP1.00002.002.003.001.00041.003"
##  [58] "NEON.DOM.SIT.DP1.00002.002.003.001.00042.003"
##  [59] "NEON.DOM.SIT.DP1.00002.002.003.001.00043.003"
##  [60] "NEON.DOM.SIT.DP1.00002.002.003.001.00044.003"
##  [61] "NEON.DOM.SIT.DP1.00002.001.004.001.00001.003"
##  [62] "NEON.DOM.SIT.DP1.00002.001.004.001.00002.003"
##  [63] "NEON.DOM.SIT.DP1.00002.001.004.001.00003.003"
##  [64] "NEON.DOM.SIT.DP1.00002.001.004.001.00005.003"
##  [65] "NEON.DOM.SIT.DP1.00002.001.004.001.00039.003"
##  [66] "NEON.DOM.SIT.DP1.00002.001.004.001.00040.003"
##  [67] "NEON.DOM.SIT.DP1.00002.001.004.001.00041.003"
##  [68] "NEON.DOM.SIT.DP1.00002.001.004.001.00042.003"
##  [69] "NEON.DOM.SIT.DP1.00002.001.004.001.00043.003"
##  [70] "NEON.DOM.SIT.DP1.00002.001.004.001.00044.003"
##  [71] "NEON.DOM.SIT.DP1.00002.002.004.001.00001.003"
##  [72] "NEON.DOM.SIT.DP1.00002.002.004.001.00002.003"
##  [73] "NEON.DOM.SIT.DP1.00002.002.004.001.00003.003"
##  [74] "NEON.DOM.SIT.DP1.00002.002.004.001.00005.003"
##  [75] "NEON.DOM.SIT.DP1.00002.002.004.001.00039.003"
##  [76] "NEON.DOM.SIT.DP1.00002.002.004.001.00040.003"
##  [77] "NEON.DOM.SIT.DP1.00002.002.004.001.00041.003"
##  [78] "NEON.DOM.SIT.DP1.00002.002.004.001.00042.003"
##  [79] "NEON.DOM.SIT.DP1.00002.002.004.001.00043.003"
##  [80] "NEON.DOM.SIT.DP1.00002.002.004.001.00044.003"
##  [81] "NEON.DOM.SIT.DP1.00002.001.005.001.00001.003"
##  [82] "NEON.DOM.SIT.DP1.00002.001.005.001.00002.003"
##  [83] "NEON.DOM.SIT.DP1.00002.001.005.001.00003.003"
##  [84] "NEON.DOM.SIT.DP1.00002.001.005.001.00005.003"
##  [85] "NEON.DOM.SIT.DP1.00002.001.005.001.00039.003"
##  [86] "NEON.DOM.SIT.DP1.00002.001.005.001.00040.003"
##  [87] "NEON.DOM.SIT.DP1.00002.001.005.001.00041.003"
##  [88] "NEON.DOM.SIT.DP1.00002.001.005.001.00042.003"
##  [89] "NEON.DOM.SIT.DP1.00002.001.005.001.00043.003"
##  [90] "NEON.DOM.SIT.DP1.00002.001.005.001.00044.003"
##  [91] "NEON.DOM.SIT.DP1.00002.002.005.001.00001.003"
##  [92] "NEON.DOM.SIT.DP1.00002.002.005.001.00002.003"
##  [93] "NEON.DOM.SIT.DP1.00002.002.005.001.00003.003"
##  [94] "NEON.DOM.SIT.DP1.00002.002.005.001.00005.003"
##  [95] "NEON.DOM.SIT.DP1.00002.002.005.001.00039.003"
##  [96] "NEON.DOM.SIT.DP1.00002.002.005.001.00040.003"
##  [97] "NEON.DOM.SIT.DP1.00002.002.005.001.00041.003"
##  [98] "NEON.DOM.SIT.DP1.00002.002.005.001.00042.003"
##  [99] "NEON.DOM.SIT.DP1.00002.002.005.001.00043.003"
## [100] "NEON.DOM.SIT.DP1.00002.002.005.001.00044.003"
```

