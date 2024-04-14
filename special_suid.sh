#!/bin/bash -v

##//////////////////
##
##  SUID permission
##

cd /lab

## SUID

chmod u+s,g-s show_ids

ls -l show_ids

./show_ids

## SGID

chmod u-s,g+s show_ids

ls -l show_ids

./show_ids

##
##  Next run special_suid.sh
##
##//////////////////////////
