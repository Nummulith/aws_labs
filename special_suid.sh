#!/bin/bash

######
echo "
////////////////////
//
//  SUID permission
//
"

##########################
echo "Set SUID permission"

cd /lab

sudo chmod u+s show_ids

ls -l show_ids
echo

#################
echo "Run script"
show_ids.sh

########
echo "//
//  Next run special_suid.sh
//
////////////////////////////
"
