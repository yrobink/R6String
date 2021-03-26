
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

library(devtools)
library(roxygen2)


## Read command line arguments
##============================

args = commandArgs( trailingOnly = TRUE )
verbose = FALSE
install = FALSE
build   = TRUE
build_manual = FALSE
check   = FALSE
if( length(args) > 0 )
{
	for( a in args )
	{
		if( a == "-v" || a == "--verbose" )
		{
			verbose = TRUE
		}
		if( a == "-i" || a == "--install" )
		{
			install = TRUE
		}
		if( a == "-nb" || a == "--not-build" )
		{
			build = FALSE
		}
		if( a == "-c" || a == "--check" )
		{
			check = TRUE
		}
		if( a == "-bm" || a == "--build-manual" )
		{
			build_manual = TRUE
		}
	}
}


## Building
##=========
r6string = ""
if( build )
{
	if( verbose ) cat( "Generation of Rd files with roxygen" )
	try( roxygen2::roxygenize("R6String") , silent = TRUE )
	if( verbose ) cat( "Load of R6String to generate Rd files with Rcpp" )
	devtools::load_all("R6String")
	if( verbose ) cat( "Generation of Rd files for cpp with roxygen" )
	roxygen2::roxygenize("R6String")
	if( verbose ) cat( "Final build" )
	r6string = devtools::build("R6String")
}

if( build_manual )
{
	devtools::build_manual("ROOPSD")
}

## Check
##======
if( check )
{
	if( verbose ) cat( "Check R6String" )
	try( devtools::check( "R6String" ) )
}


## Installation
##=============

if( install )
{
	if( verbose ) cat( "Installation" )
	if( r6string == "" )
	{
		files = base::list.files()
		r6string = ""
		
		for( f in files )
		{
			f_split = base::unlist(base::strsplit( f , "[.]" ))
			if( length(f_split) > 2 )
			{
				f_split = base::rev(f_split)
				if( f_split[1] == "gz" && f_split[2] == "tar" )
				{
					r6string = f
				}
			}
		}
	}
	if( r6string == "" )
	{
		cat( "Error, R6String not build, so can not be install" )
	}
	else
	{
		install.packages(r6string)
	}
}

