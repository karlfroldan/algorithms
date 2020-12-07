#!/bin/sh

for FILE in *; do
    if [ $FILE != run.sh ] && [ $FILE != random.txt ]
    then
        python3 $FILE
    fi
done