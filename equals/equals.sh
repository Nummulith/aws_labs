#!/bin/bash

counter=0
while [ $counter -lt 10 ]; do
    echo -n "=="
    ((counter++))
    sleep 1
done
echo

echo "slept for ten seconds"
