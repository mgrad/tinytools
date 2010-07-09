#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 file"
    echo "example: $0 latex-table.dat"
    echo "cat latex-table.dat | ./$0 -"
    exit 1
fi

# buffer input
idx=0
while read line; do
    BUFFER[$idx]="$line\n"
    echo $idx ${BUFFER[$idx]}
    idx=$(($idx+1))
done < <(cat $1 | egrep -v '^-|=|#')

HEADER=$(echo ${BUFFER[0]} | awk 'BEGIN{i=0} NR==1{do {printf "|c"} while(i++<NF)}')\|
cat<<EOF
\begin{table*}
\centering
\small
\begin{tabular}{$HEADER}
\hline
EOF

echo -e ${BUFFER[@]} | awk '\
    {
        for(i=1;i<=NF;i++) {
            printf $i 
            if (i!=NF) 
                printf " & "
            else
                printf  " \\\\ \\hline "
        }
        printf "\n"
    } ' | sed '1s/$/\\hline/' |  sed 's/_/\\_/g' | column -t | awk '{print "   "$0}'

cat<<EOF
\end{tabular}
\caption{Caption: $1}
\label{tab:$1}
\end{table*}
EOF
