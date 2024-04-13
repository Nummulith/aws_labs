#!/bin/bash -v

##//////////////////
##
##  SUID permission
##

cd /lab

## SUID

sudo chmod u+s,g-s show_ids

ls -l show_ids

./show_ids

## SGID

sudo chmod u-s,g+s show_ids

ls -l show_ids

./show_ids

##
##  Next run special_suid.sh
##
##//////////////////////////
