#!/bin/bash

function run {
    BASE=$1
    INCR=$2
    RESULTS=$3
awk '
     NR==FNR{f1[NR]=$0}                 # read first file to array
     NR!=FNR{
        n=split(f1[FNR], f1_line," ");     # split data from 1st file
        skip=n/NF
        for(i=1; i<n+1; i++) {
            printf "%s ", f1_line[i]
            if (i%skip==0) 
                printf "%s ", $(i/skip)
        }
        printf "\n";
     }
     END{
        if (length(array)!=FNR) {print "Warning: wrong number of rows"}
     }' $BASE $INCR > $RESULTS
}



# ============== main ============== #
if [ $# -lt 2 ]; then 
    echo "usage: $0 base_file file_to_add [.. files_to_add]"
    exit 1
fi;

BASE=$1
FIRST=$BASE
shift 1

while [ $# -ne 0  ]; do
    INCR=$1
    shift 1
    RESULTS="$BASE.tmp"
    run $BASE $INCR $RESULTS
    BASE=$RESULTS
 done

cat $RESULTS
rm -rf $FIRST.tmp*
