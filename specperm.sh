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
