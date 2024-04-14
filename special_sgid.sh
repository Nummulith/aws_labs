#!/bin/bash -v

##//////////////////
##
##  SGID permission
##

cd /lab


## file SGID

chmod u-s,g+s show_ids

ls -l show_ids

# The program run from its group
./show_ids


## folder SGID

sudo chmod u-s,u+s /lab

sudo -u bob touch bob.txt

# SUID affect to group of created file
ls -l /lab/bob.txt

sudo chmod u-s,u-s /lab


##
##  Next run special_sb.sh
##
##//////////////////////////
