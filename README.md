
# R6String

## Features

Implementation of a class `R6StringClass` which mimics the python class `str`.
For example:

~~~R
s = R6String("Hello world!") ## Start by defining a string

print(s) ## print as a character in output
s$replace( " " , "-" ) ## we can replace the space by "-"
s$replace("!","") + " " + "with R6String!" ## Transform to "Hello world with R6String!"
s$lower() ## All in lowercase
s$upper() ## And all in uppercase
R6String("_")$join( base::c( "Hello" , "world!" ) ) ## And we join with sep "_"
s[3:7] ## Access to substring

s = R6String("Hello world! How are you?")
s$title() ## Capitalize for all words

s = R6String("{} {}!")$format("Hello","world") ## Formatting
~~~

## Installation

Requires:
- R
- roxygen2 (>= 7.0.0)
- devtools
- methods
- R6

Just run:
~~~bash
Rscript build.R -c -v -i
~~~


## License

Copyright(c) 2021 Yoann Robin

This file is part of R6String.

R6String is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

R6String is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with R6String.  If not, see <https://www.gnu.org/licenses/>.
