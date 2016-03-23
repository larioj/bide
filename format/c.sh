#!/bin/bash

astyle --style=allman --pad-oper --delete-empty-lines --align-pointer=name --add-brackets --indent-col1-comments --max-code-length=80 --break-after-logical --suffix=none --quiet "$@"
