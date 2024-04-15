#!/bin/bash -v

## TEST

sudo groupadd lab_users
sudo usermod -aG lab_users ec2-user

sudo mkdir dir
sudo chown ec2-user:lab_users dir

touch file

ls -ld dir

chmod u-s,g+s dir
chmod u-s,g+s file

ls -ld dir
