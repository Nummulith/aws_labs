#!/bin/bash

# SUID permission

chmod u+s /lab/show_ids.sh

echo "SUID permission set"
ls -l /lab/show_ids.sh
