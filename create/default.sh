#! /bin/bash
source $HOME/bide/bideLib.sh

deftemplate="$createDir/template.txt"

createFile() {
	local filename ext template
	filename="$1"
	if [ ! -e "$filename" ]; then
		ext="$(getExt $filename)"
		template="$createDir/template.${ext}"

		# Check the case where there is no extension.
		if [ -z "$ext" ]; then
			template="$deftemplate"
		fi

		# Check if the extension template file exits.
		if [ ! -e "$template" ]; then
			template="$deftemplate"
		fi

		# Copy the template file.
		cp "$template" "$filename"
	fi
}

createFiles () {
  local files file
  files="$@"
  for file in "${files[@]}"; do
    createFile "$file"
  done
}

createFiles "$@"
