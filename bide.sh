#! /bin/bash
# Global Variables
scriptName=$0

# Directories
bidedir=$HOME/.bide
ftdir=$bidedir/fttemplate
rundir=$bidedir/runscripts
deftemplate=$ftdir/default.txt

# Operations
actionDic=(
"usage:usage"
"r:runFile"
"m:makeFiles"
)

# Entry Point
main () {
  local action files
  files="${@:2}"
  $(getAction $1) $files
}

# Top Level Actions
usage () {
  echo "usage: $scriptName action [params]+"
}

makeFiles () {
  local files file
  files=$@
  for file in "${files[@]}"; do
    createFile $file
  done
}

runFile () {
  local args file ext runscript
  file=$1
  args="${@:2}"
  ext=$(getExt $file)
  runscript=${rundir}/${ext}_run.sh
  if [ -e $runscript ]; then
    $runscript $file $args
  else
    ./$file $args
  fi
}

# Functions
## Creates a file based upon the name
## passed in. If the file already exits
## it does nothing.
createFile() {
  local filename ext template

  # Get the extension and create the
  # default file name.
  filename=$1

  if [ ! -e $filename ]; then
    ext=$(getExt $filename)
    template=$ftdir/default.${ext}

    # Check the case where there is no extension.
    if [ -z $ext ]; then
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

## Gets the action corresponding to the string passed
## in.
getAction () {
  local action
  action="usage"
  for item in ${actionDic[*]}
  do
    if [ "$1" == "$(key $item)" ]; then
      action="$(val $item)"
    fi
  done
  printf "%s" $action
}

getExt () {
  local file ext
  file=$1
  ext=${file##*.}
  if [ $file == $ext ]; then
    ext=""
  fi
  printf "%s" $ext
}

getName () {
  local file name
  file=$1
  name=${file%%.*}
  printf "%s" $name
}

## Gets the second element of a pair of the form "key:val"
val () {
  printf "%s" ${1##*:}
}

## Gets the first element of a pair of the form "key:val"
key () {
  printf "%s" ${1%%:*}
}

# Call the main method.
main $@
