#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: $0 from_col_no to_col_no"
    exit 1
fi;

FROM=$1
TO=$2
shift 2

if [ $# -eq 0 ]; then 
    INPUT="-"
else 
    INPUT=$*
fi;

awk -v f=$FROM -v t=$TO ' 
BEGIN{ pos=0; if (t>f) pos=1 }
{
    for(i=1; i<NF+1; i++) {
        if (i-pos==t) 
           printf "%s ", $f
        if (i!=f)
            printf "%s ", $i
    }
    printf "\n"
}' $INPUT  | column -t
