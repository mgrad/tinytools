#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 file"
    exit 1
fi;
awk  '{for  (i=1;i<NF+1;i++){printf  "%s,  ",  $i}  printf  "\n"}' $* | column -t
