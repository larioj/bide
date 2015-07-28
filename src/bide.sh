#! /bin/bash
if [ -z $1 ]; then
	echo usage: $0 filename.ext
	exit
fi

# Directories
bidedir=$HOME/.bide
ftdir=$bidedir/fttemplate
deftemplate=$ftdir/default.bide

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

# Get the extension and create the
# default file name.
filename=$1
ext=${filename##*.}
template=$ftdir/${ext}_default.bide

# Check the case where there is no extension.
if [ $ext = $filename ]; then
	template=$ftdir/default.bide
fi

# Check if the extension template file exits.
if [ ! -e $template ]; then
	template=$ftdir/default.bide
fi

# Copy the template file.
cp $template $filename
