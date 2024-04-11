#!/bin/bash

counter=0
while [ $counter -lt 10 ]; do
    echo -n "=="
    ((counter++))
done

echo "123"
sleep 1
echo "slept for ten seconds"
