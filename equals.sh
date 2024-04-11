#!/bin/bash

counter=0
while [ $counter -lt 10 ]; do
    echo -n "=="
    ((counter++))
done

sleep 10
echo -n "slept for ten seconds"