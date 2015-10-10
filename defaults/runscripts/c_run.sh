#! /bin/bash

gcc $1
./a.out "${@:2}"
rm a.out
