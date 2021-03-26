
## Copyright(c) 2021 Yoann Robin
## 
## This file is part of R6String.
## 
## R6String is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## R6String is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with R6String.  If not, see <https://www.gnu.org/licenses/>.

base::rm( list = base::ls() )


###############
## Libraries ##
###############

library(R6)
library(devtools)

try(roxygen2::roxygenize("../R6String"))
devtools::load_all("../R6String")
roxygen2::roxygenize("../R6String")
devtools::load_all("../R6String")

#########
## Run ##
#########

## Start by defining a string
s = R6String("Hello world!")

print(s) ## print as a character in output
s$replace( " " , "-" ) ## we can replace the space by "-"
s$replace("!","") + " " + "with R6String!" ## Transform to "Hello world with R6String!"
s$lower() ## All in lowercase
s$upper() ## And all in uppercase
R6String("_")$join( base::c( "Hello" , "world!" ) ) ## And we join with sep "_"
s[3:7] ## Access to substring

s = R6String("Hello world! How are you?")
s$title() ## Uppercase for all words

