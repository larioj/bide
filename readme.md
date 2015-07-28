# Project Manager: bide

## Purpose
Manages big projects. Manages dependencies and builds the
project.

## Features
+ Build/Project Manager
	+ Maybe interfaces with make?
	+ Git like interface.
	+ Performs operations as the project grows. For example
		add files, create sub-projects.
	+ May interface with git. So that "bide add file", will add
		file to the project as well as the underlying git repo.
+ Templates for file types
	+ Examples
		+ dide add filename.html -t template_name
		+ dide add cppclass.cpp -t class

## Language
Shell for now because it is quick to write. This is the prototype.
May migrate to an industrial strength language later.

# Usage example
+ adding files: creates a file of type ext, with template initialization.
	+ bide add filename.ext
	+ Support c, perl files.
+ adding a project: creates a directory, and readme.
	+ bide project project_name -type c


# Current Status
Creates files only.
+ Example: bide add.rkt
		+ Creates file add.rkt with contents and persmissions of the defualt
			template ~/.bide/rkt_default.bide
