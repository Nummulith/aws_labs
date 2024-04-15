#!/bin/bash -v

## Test

sudo mkdir /tst
sudo chown ec2-user:lab_users /tst
sudo chmod g+w /tst

ls -ld /tst

chmod u-s,g+s /tst

ls -ld /tst
