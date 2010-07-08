#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 file"
    echo "example: $0 latex-table.dat"
    exit 1
fi

INPUTFILE=$1

HEADER=$(awk 'BEGIN{i=0} NR==1{do {printf "|c"} while(i++<NF)}' $INPUTFILE)\|
echo "\begin{tabular}{$HEADER}"
echo "\hline"
egrep -v '^(-|=|#)' $INPUTFILE  | awk '\
    {
        for(i=1;i<=NF;i++) {
            printf $i 
            if (i!=NF) 
                printf " & "
            else
                printf  " \\\\ \\hline "
        }
        printf "\n"
    } ' | sed '1s/$/\\hline/' | column -t

echo "\hline"
echo "\end{tabular}"
