#!/bin/bash

file="$1"
args="${@:2}"
./$file $args
