#!/bin/bash

# Create users
useradd foo
useradd bar

# Create group
groupadd labusers

# Add users to the group
usermod -aG labusers foo
usermod -aG labusers bar

# Create directory lab at root
mkdir /lab

# Set owner and group for the directory
chown ec2-user:labusers /lab

# Print groups
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'