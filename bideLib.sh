#!/bin/bash

# Global Variables
bide=$0

# Directories
bideDir="$HOME/bide"
createDir="$bideDir/create"
runDir="$bideDir/run"
formatDir="$bideDir/format"
testDir="$bideDir/test"

# Defaults
defaultScriptName="default.sh"

# Operations
actionDic=(
"u:usage"
"r:run"
"c:create"
"f:format"
"t:runtest"
)

# Prints usage to stdout.
usage () {
	echo "usage: $bide action [params]+"
}

# Runs the given file using the filetype script in
# the run directory
run() {
	local file dir script 
	file="$1"
	dir="$runDir"
	script="$(getScript $file $dir)"
	$script "$@"
}

# Creates the file given in the arguments, using the
# the filetype script in the create directory.
# If the file already exits it does nothing.
create() {
	local file dir script
	file="$1"
	dir="$createDir"
	script="$(getScript $file $dir)"
	if [ ! -e $file ]; then
		$script "$@"
	fi
}

# Calls the format script for the given file type.
format() {
	local file dir script
	file="$1"
	dir="$formatDir"
	script="$(getScript $file $dir)"
	$script "$@"
}

# Calls the test script for the given file type.
runtest() {
	local file dir script
	file="$1"
	dir="$testDir"
	script="$(getScript $file $dir)"
	$script "$@"
}

# Gets the name of the script assosiated with the given file, in the
# given directory. The directory is the context of the operation. For
# example if this was called for a run operation, the runDir would be
# passed in for dir.
#
# usage: getScript file dir
# returns: the script in dir corresponding to file's extension
# globals: defaultScriptName
getScript() {
	local file dir ext script
	file="$1"
	dir="$2"
	ext="$(getExt $file)"
	script="${dir}/${ext}.sh"
	if [ ! -e "$script" ]; then
		script="${dir}/${defaultScriptName}"
	fi
	ret "$script"
}

# Gets the action corresponding to the string passed in.
#
# usage: getAction action
# requires: action must be in actionDic
# globals: actionDic
getAction () {
	local action
	action="usage"
	for item in ${actionDic[*]}; do
		if [ "$1" == "$(key $item)" ]; then
			action="$(val $item)"
		fi
	done
	ret "$action"
}

# Gets the extension of the file, or "" if no extension.
#
# usage: getExt file
getExt () {
	local file ext
	file=$1
	ext=${file##*.}
	if [ "$file" == "$ext" ]; then
		ext=""
	fi
	ret "$ext"
}

# Gets the name of the file without the extension.
#
# usage: getName file
getName () {
	local file name
	file=$1
	name=${file%%.*}
	ret "$name"
}

# Gets the second element of a pair of the form "key:val".
#
# usage: val keyval
# requires: keyval must be of the form "key:val", neither 
# key nor val must be empty
val () {
	ret "${1##*:}"
}

# Gets the first element of a pair of the form "key:val".
#
# usage: key keyval
# requires: keyval must be of the form "key:val", neither 
# key nor val must be empty
key () {
	ret "${1%%:*}"
}

# Mimics return by printing the given parameters.
#
# usage: ret val
# returns: a string that can be caught with $()
ret() {
	echo "$@"
}

# Entry Point
main () {
	local action files
	if [ -z "$1" ] || [ -z "$2" ]; then
		usage "$@"
	else
		files="${@:2}"
		$(getAction "$1") "$files"
	fi
}

