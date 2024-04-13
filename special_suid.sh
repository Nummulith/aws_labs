#!/bin/bash

######
echo "
////////////////////
//
//  SUID permission
//
"
set -v
set +x

###########
echo "SUID"

cd /lab

sudo chmod u+s,g-s show_ids

ls -l show_ids

show_ids

###########
echo "SGID"

cd /lab

sudo chmod u-s,g+s show_ids

ls -l show_ids

show_ids

######
echo "//
//  Next run special_suid.sh
//
////////////////////////////
"
