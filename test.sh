#!/bin/bash -v

## Test

sudo groupadd lab_users
sudo usermod -aG lab_users ec2-user

sudo mkdir /tst
sudo chown ec2-user:lab_users /tst
sudo chmod g+w /tst

ls -ld /tst

chmod u-s,g+s /tst

ls -ld /tst
