#!/bin/sh

#FILES=`ls`

RANDNUMBERS=$1

for FILE in *; do
    if [ $FILE != run.sh ] 
    then
        python3 $FILE $RANDNUMBERS
    fi
done