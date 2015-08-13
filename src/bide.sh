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

## Entry point of the program.
main() {
	checkUsage $@
	install
	for file in $@; do
		createFile $file
	done
	openEditor $@
}

# Call the main method.
main $@
