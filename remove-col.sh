#!/bin/bash

function usage {
   echo "usage: $0 file columns_list"
   echo "example: ./$0 1 3 5 file"
   echo "example: cat file | ./$0 1 3 5 - "
}

INPUTFILE=$(eval "echo \$$#")
length=$(($#-1))
array=${@:1:$length}

if [ ${#array[@]} -eq 0 ]; then usage ;  exit 1; fi

# buf=$(cat $INPUTFILE)
## echo $buf
# exit
#if [ ! -e $INPUTFILE ]; then 
#     echo -e "ERROR: file $INPUTFILE not found\n"; 
#     usage; exit 1; 
#fi

COLS=""
for i in $array; do
    COLS=$(echo -n $COLS\$$i=)
done
COLS="$COLS\"\""

eval "awk '{$COLS}1' $INPUTFILE" | column -t
