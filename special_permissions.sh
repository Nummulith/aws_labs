#!/bin/bash

## Group and users creation

# Create users
useradd foo
useradd bar

# Create group
groupadd labusers

# Add users to the group
usermod -aG labusers foo
usermod -aG labusers bar

echo "Group and users are created. The groups now are:"
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'


## Lab directory creation

# Create directory lab at root
mkdir /lab

# Set owner and group for the directory
chown ec2-user:labusers /lab

echo "lab folder created:"
ls -ld /lab
