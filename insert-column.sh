#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 base_file insert_col src_file which_col"
    exit 1
fi

awk -v ic=$2 -v wc=$4 '
NR==FNR{f1[NR]=$0}                   # read first file to array
NR!=FNR{                             # process second file
    n=split(f1[FNR], f1_line, " ");  # get data from first file
    for(i=1; i<ic; i++) 
        printf "%s ", f1_line[i]
    printf "%s ", $wc
    for(i=ic; i<n+1; i++)
        printf "%s ", f1_line[i]
    printf "\n";
}
' $1 $3 | column -t 
