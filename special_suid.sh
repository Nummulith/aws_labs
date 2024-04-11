#!/bin/bash

# SUID permission

sudo chmod u+s /lab/show_ids.sh

echo "SUID permission set"
ls -l /lab/show_ids.sh
echo

echo "Running:"
/lab/show_ids.sh