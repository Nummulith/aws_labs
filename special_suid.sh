#!/bin/bash

######
echo "
////////////////////
//
//  SUID permission
//
"
PS4='+ '
exec 3>&1
set -x

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
set +x
echo "//
//  Next run special_suid.sh
//
////////////////////////////
"
