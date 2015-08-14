#! /bin/bash

# Global Variables
## Directories
bidedir=$HOME/.bide
ftdir=$bidedir/fttemplate
deftemplate=$ftdir/default.txt
editor=$VISUAL

# Functions
## Set up the bide directory structure
## if it does not exist.
install() {
	# Make the directories if they don't exist.
	if [ ! -d $bidedir ]; then
		mkdir $bidedir
	fi

	if [ ! -d $ftdir ]; then
		mkdir $ftdir
	fi

	# if default template does not exist make it.
	if [ ! -e $deftemplate ]; then
		touch $deftemplate
	fi

	if [ -z $VISUAL ]; then
		editor=/usr/bin/vim
	fi
}

## Check for correct formating of the
## command line arguments.
checkUsage() {
	if [ -z $1 ]; then
		echo "usage: $0 [filename.ext]+"
		exit
	fi
}

## Creates a file based upon the name
## passed in. If the file already exits
## it does nothing.
createFile() {
	# Get the extension and create the
	# default file name.
	filename=$1

	if [ ! -e $filename ]; then
		ext=${filename##*.}
		template=$ftdir/default.${ext}

		# Check the case where there is no extension.
		if [ $ext = $filename ]; then
			template=$deftemplate
		fi

		# Check if the extension template file exits.
		if [ ! -e $template ]; then
			template=$deftemplate
		fi

		# Copy the template file.
		cp $template $filename
	fi
}

## Opens the system editor with the file
## created.
openEditor() {
	$editor $@
}

## Gets the list of flags, -[flag] in the
## arguments.
getFlags() {
	for arg in $@; do
		if [[ $arg == "-"* ]]; then
			printf "%s " "$arg"
		fi
	done
	printf "\n"
}

## Gets the list of files to edit and,
## create. It removes all other elements.
getFiles() {
	for arg in $@; do
		if [[ $arg != "-"* ]]; then
			printf "%s " "$arg"
		fi
	done
	printf "\n"
}

## Returns 1 if the first element in the args
## is contained in the rest of the args.
containsElement() {
	local element other
	element=$1
	for other in ${@:2}; do
		if [ $other == $element ]; then
			return 1
		fi
	done
	return 0
}

## Entry point of the program.
main() {
	files=($(getFiles $@))
	flags=($(getFlags $@))

	checkUsage $files
	install
	for file in $files; do
		createFile $file
	done
	
	## >>> Buggy
	## The function call creates a whole new
	## instance of the shell. If I try to jump out
	## of the editor into the environment, something
	## breaks and vim goes bonkers.
	containsElement "-e" "${flags[@]}"
	if [ $? == 1 ]; then
		openEditor $files
	fi
	## <<<
}

# Call the main method.
main $@
