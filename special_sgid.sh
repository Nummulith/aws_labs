#!/bin/bash -v

##//////////////////
##
##  SGID permission
##

cd /lab


## Run file with SGID

chmod u-s,g+s show_ids

ls -l show_ids

# The program run from its group
sudo -u bob ./show_ids

chmod u-s,g-s show_ids


## Create file in folder with SGID

chmod u-s,g+s /lab

sudo -u bob touch bob.txt

# SUID affect to group of created file
ls -l /lab/bob.txt

chmod u-s,g-s /lab


##
##  Next run special_sb.sh
##
##//////////////////////////
