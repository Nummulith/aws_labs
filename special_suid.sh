#!/bin/bash


# SUID permission

cd /lab

sudo chmod u+s show_ids

echo "SUID permission set"
ls -l show_ids
echo


# Run

echo "Running:"
show_ids.sh

