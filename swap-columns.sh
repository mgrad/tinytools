#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: $0 col_no col_no"
    exit 1
fi;

C1=$1
C2=$2
shift 2

if [ $# -eq 0 ]; then 
    INPUT="-"
else 
    INPUT=$*
fi;

awk -v c1=$C1 -v c2=$C2 ' 
{
    TMP=$c1
    $c1=$c2
    $c2=TMP
    print $0
}' $INPUT | column -t
