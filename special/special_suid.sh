#!/bin/bash -v

##//////////////////
##
##  SUID permission
##

cd /lab


## Run file with SUID

chmod u+s,g-s show_ids

ls -l show_ids

# The program run from its user
sudo -u alice ./show_ids

chmod u-s,g-s show_ids


## Create file in folder with SUID

chmod u+s,g-s /lab

sudo -u alice touch alice.txt

# SUID does not affect to user of created file
ls -l /lab/alice.txt

chmod u-s,g-s /lab


##
##  Next run special_sgid.sh
##
##//////////////////////////
