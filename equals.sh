#!/bin/bash

counter=0
while [ $counter -lt 10 ]; do
    echo -n "=="
    ((counter++))
done

echo
sleep 10
echo "slept for ten seconds"
