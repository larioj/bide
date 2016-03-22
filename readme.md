# Commandline Development Tool: bide

## Purpose
Bide is made for programmers who jump around many languages. It collects
common tasks such as running a file, or running a formater on a file. It is made
for small projects, usually no bigger than a couple of files.

## Use Cases
### Run a File
When I first started to program in C, I would write a file that tested
some feature of the language, e.g. unions. In order to test my file I would
type on the terminal

	gcc foo.c
	./a.out
	rm a.out

This quickly got tedious. In bide you would do

	bide r foo.c

and it would accomplish the same thing. It doesn't seem like much, but when you're
having to do the equialent for haskell, java, cpp, racket, shell, python, scala, and
others it really adds up. In bide you can just do

	bide r foo.c
	bide r foo.hs
	bide r foo.cpp
	bide r foo.rkt
	bide r foo.sh
	bide r foo.scala
	bide r foo.??

and the files will be compiled, run, and cleaned up regardless of the language.

### Fill in Initial Boilerplate
In bash and many other scripting languages every file should have a directive at the top.
For example

	#!/bin/bash

	echo "hello world"

Since there are many variations of this, I would find myself having to repatedly look up
what the correct string was. In bide you can create a file, with the inital boilerplate
already filled in. For example

	bide c foo.c

would create a file with the contents

	#include <stdio.h>
	#include <stdlib.h>
	
	int main(int argc, char **argv) {
		return 0;
	}

This works for many languages.

### Format a File
There are a lot of formatters out there. There is gofmt, scalariform, etc. You can run
them from bide. For example

	bide f foo.scala

would call scalariform on foo.scala to reformat it.

## Extending bide
You can extend bide to support new languages by adding a bash script to one of the bide
folders. For example if we wanted to extend bide so that it is able to reformat go code,
we could add a script called go.sh to the folder format/ with the following contents

	gofmt "$@"

bide will pass all the arguments from it received to the script, with the exception
of the first argument. So a call to bide like

	bide f foo.go a b c d

would pass

	foo.go a b c d

to the go.sh script.

## Features
+ Run (bide r foo.ext)
+ Create (bide c foo.ext)
+ Format (bide f foo.ext)
+ Test (bide t foo.ext)

## Language
Bash as it is the scriptiest of languages.

# Current Status
Test feature does not have any scripts associated with it. 

# Wish List
+ c header files
	+ Translate h files function declarations
		to stubs.
	+ Update function stubs to reflect header
		files.
+ Better creation templates, with argument substitution.
+ Automatic imports.
+ Automatic extensions
	+ When you add a folder to the bide directory, an option is added to the arguments.

