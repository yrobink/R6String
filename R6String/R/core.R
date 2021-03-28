
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


## R6StringClass ##{{{

#' R6StringClass
#'
#' @description
#' Main class for string in OOP way like python
#'
#' @details
#' This class use build-in function from R to provide an interface like python
#' for string manipulation.
#' 
#' @importFrom R6 R6Class
#' @importFrom methods new
#'
#' @examples
#'
#' ## Start by defining a string
#' s = R6String("Hello world!")
#' 
#' print(s) ## print as a character in output
#' s$replace( " " , "-" ) ## we can replace the space by "-"
#' s$replace("!","") + " " + "with R6String!" ## Transform to "Hello world with R6String!"
#' s$lower() ## All in lowercase
#' s$upper() ## And all in uppercase
#' R6String("_")$join( base::c( "Hello" , "world!" ) ) ## And we join with sep "_"
#' s[3:7] ## Access to substring
#' 
#' s = R6String("Hello world! How are you?")
#' s$title() ## Capitalize for all words
#'
#' @export
R6StringClass = R6::R6Class( "R6StringClass" ,
	
	## private list ##{{{
	
	private = list(
	
	#' @field str  [character] Underlying string
	#' @field size [integer] Length of the string
	.str = NULL
	
	),
	##}}}
	
	## active list ##{{{
	
	active = list(
	
	## str ## {{{
	
	str = function(value)
	{
		if( missing(value) )
			return(private$.str)
		else
			private$.str = value
	},
	##}}}
	
	## size ## {{{
	
	size = function(value)
	{
		if( missing(value) )
			return( base::nchar(self$str) )
	}
	##}}}
	
	),
	
	##}}}
	
	## public list ##{{{
	
	public = list(
	
	## initialize ##{{{
	
	#' @description
    #' Create a new R6StringClass object.
    #' @param str [character] String represented by the R6StringClass
	#' @return A new `R6StringClass` object.
	initialize = function(str)
	{
		if( "R6StringClass" %in% class(str) )
			str = str$str
		self$str = str
	},
	##}}}
	
	## print ##{{{
	
	#' @description
    #' Override the built-in print function
	print = function()
	{
		cat(base::paste0(self$str,"\n"))
		invisible(NULL)
	},
	##}}}
	
	## concatenate ##{{{
	
	#' @description
	#' Concatenate function, used by the operator +
	#' @param str [R6StringClass or character] string to concatenate
	#' @return self
	concatenate = function(str)
	{
		if( "R6StringClass" %in% class(str) )
		{
			self$str = base::paste0(self$str,str$str)
		}
		else
		{
			self$str = base::paste0(self$str,as.character(str))
		}
		return(self)
	},
	##}}}
	
	## replace ##{{{
	
	#' @description
	#' Replace pattern `old` by `new`
	#' @param old [R6StringClass or character] pattern to replace
	#' @param new [R6StringClass or character] new pattern
	#' @return self
	replace = function( old , new )
	{
		if( "R6StringClass" %in% class(old) )
			old = old$str
		if( "R6StringClass" %in% class(new) )
			new = new$str
		str = base::gsub( old , new , self$str )
		return(R6StringClass$new(str))
	},
	##}}}
	
	## split ##{{{
	
	#' @description
	#' Return a list of the words in the string, using sep as the delimiter string.
	#' @param sep [R6StringClass or character] The delimiter
	#' @return A list of R6StringClass
	split = function( sep )
	{
		if( "R6StringClass" %in% class(sep) )
			sep = sep$str
		
		split   = base::strsplit(self$str,sep)[[1]]
		n_split = length(split)
		out     = base::c()
		for( i in 1:n_split )
		{
			if( base::nchar(split[i]) > 0 )
				out = base::c(out,R6StringClass$new(split[i]))
		}
		return(out)
	},
	##}}}
	
	## join ##{{{
	
	#' @description
	#' Concatenate a list of string.
	#' @param iter [list or vector] List or vector of string to concatenate
	#' @return self
	join = function( iter )
	{
		str = R6StringClass$new("")
		for( s in iter )
		{
			str = str + self$str + s
		}
		str = str[(self$size+1):str$size]
		return(str)
	},
	##}}}
	
	## uper ##{{{
	
	#' @description
	#' Return a copy converted to uppercase
	#' @return [R6StringClass]
	upper = function()
	{
		return(R6StringClass$new(base::toupper(self$str)))
	},
	
	##}}}
	
	## lower ##{{{
	
	#' @description
	#' Return a copy converted to lowercase
	#' @return [R6StringClass]
	lower = function()
	{
		return(R6StringClass$new(base::tolower(self$str)))
	},
	
	##}}}
	
	## capitalize ##{{{
	
	#' @description
	#' Return a copy capitalized (i.e. the first character is in uppercase, others in lowercase)
	#' @return [R6StringClass]
	capitalize = function()
	{
		return(self[1]$upper() + self[2:self$size]$lower())
	},
	##}}}
	
	## title ##{{{
	
	#' @description
	#' Transform to title (i.e. all characters after sep are in uppercase, others in lowercase)
	#' @param sep [R6StringClass or character] separator
	#' @return [R6StringClass]
	title = function( sep = " " )
	{
		split = self$split(sep)
		splitc = base::c()
		for( i in 1:length(split) )
			splitc = base::c( splitc , split[[i]]$capitalize() )
		return( R6StringClass$new(sep)$join(splitc) )
	}
	##}}}
	
	)
	
	##}}}
	
)

##}}}

## operator +  ##{{{

#' operator +
#'
#' Override operator + between two R6StringClass
#'
#' @param str1 [R6StringClass] First string
#' @param str2 [R6StringClass or character] Second string, note that the second can be a character
#'
#' @return [R6StringClass] The string concatenate
#'
#' @examples
#'
#' s = R6String("Hello")
#' s = s + " " + "world!" ## "Hello world!"
#' @export
`+.R6StringClass` = function( str1 , str2 )
{
	str = R6StringClass$new(str1$str)
	return(str$concatenate(str2))
}
##}}}

## operator [] ##{{{

#' operator []
#'
#' Override operator [] two access individual character
#'
#' @param str [R6StringClass] string
#' @param i   [vector of integer] indexes
#'
#' @return [R6StringClass] The substring
#'
#' @examples
#'
#' s   = R6String("Hello")
#' sub = s[2:3] ## "ell"
#' @export
`[.R6StringClass` = function( str , i )
{
	return( R6StringClass$new(base::substr(str$str,i[1],i[length(i)])) )
}
##}}}

## as.vector ##{{{

#' as.vector
#'
#' Override as.vector for R6StringClass
#' 
#' @param str [R6StringClass] string
#' 
#' @return [character] base::c(The string)
#' 
#' @examples
#'
#' s   = R6String("Hello")
#' as.vector(s)
#'
#' @export
as.vector.R6StringClass = function( str , mode )
{
	return(base::c(str$str))
}

##}}}

## as.character {{{

#' as.character
#'
#' Override as.character for R6StringClass
#' 
#' @param str [R6StringClass] string
#' 
#' @return [character] The string
#' 
#' @examples
#'
#' s   = R6String("Hello")
#' as.character(s)
#'
#' @export
as.character.R6StringClass = function( str )
{
	return(str$str)
}
##}}}

## constructor ##{{{

#' R6String
#'
#' Quick constructor, just a call to R6StringClass$new
#'
#' @param str [R6StringClass or character] string
#'
#' @return [R6StringClass]
#'
#' @examples
#'
#' s   = R6String("Hello world!")
#' @export
R6String = function( str = "" )
{
	if( "R6StringClass" %in% class(str) )
		str = str$str
	return(R6StringClass$new(str))
}
##}}}

