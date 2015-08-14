# Project Manager: bide

## Purpose
Manages big projects. Manages dependencies and builds the
project.

## Possible Features
+ Build/Project Manager
	+ Maybe interfaces with make?
	+ Git like interface.
	+ Performs operations as the project grows. For example
		add files, create sub-projects.
	+ May interface with git. So that "bide add file", will add
		file to the project as well as the underlying git repo.
+ Templates for file types
	+ Examples
		+ bide add filename.html -t template_name
		+ bide add cppclass.cpp -t class

## Language
Shell for now because it is quick to write. This is the prototype.
May migrate to an industrial strength language later.

# Usage example
+ Creating files
	+ bide filename.ext
+ Enabling editing after creation
	+ bide -e filename.ext

# Current Status
Creates files from simple templates.

For example, bide fun.rkt creates file fun.rkt with contents and permissions
of the default template ~/.bide/default.rkt. If the file already exists
it does nothing, unless the editing switch, -e, is specified in which case
it will called the editor on the files.

Also supports editing files, given the switch -e bide will call
the editor after creating the files.

# Wish List
+ c header files
	+ Translate h files function declarations
		to stubs.
	+ Update function stubs to reflect header
		files.
+ Better templates, with argument substitution.

# Updates
+ Aug 13 2015
	+ Added the option to call the editor on file creation.
		+ Flag -e
