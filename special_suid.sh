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

sudo chmod u-s,u+s /lab

sudo -u alice touch alice.txt

# SUID does not affect to user of created file
ls -l /lab/alice.txt

sudo chmod u-s,u-s /lab


##
##  Next run special_sgid.sh
##
##//////////////////////////
