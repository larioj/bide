# C Project Manager: bide

## Purpose
Manages big C projects. Manages dependencies and builds the
project.

## Features
+ Build/Project Manager
	+ Maybe interfaces with make?
	+ Git like interface.
	+ Performs operations as the project grows. For example
		add files, create sub-projects.
	+ May interface with git. So that "bide add file", will add
		file to the project as well as the underlying git repo.
+ Template add-ons for code.
	+ Examples
		+ dide add filename.html -t template_name
		+ dide add cppclass.cpp -t class

## Language
Perl because it is quick to write, and has great support for
text manipulation and running processes.

# Usage example
+ adding files: creates a file of type ext, with template initialization.
	+ bide add filename.ext
	+ Support c, perl files.
+ adding a project: creates a directory, and readme.
	+ bide project project_name -type c
