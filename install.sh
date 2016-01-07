#!/bin/bash

mkdir -p ~/.bide
cp ./bide.sh ~/.bide/bide.sh
cp -r ./defaults/* ~/.bide
ln -s ~/.bide/bide.sh "/usr/local/bin/bide"
