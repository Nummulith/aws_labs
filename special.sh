#!/bin/bash

## Users and group

useradd foo
useradd bar
groupadd labusers

usermod -aG labusers foo
usermod -aG labusers bar

echo "Users and group are created:"
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'


## Lab directory

mkdir /lab
chown ec2-user:labusers /lab

echo "lab folder created:"
ls -ld /lab

cd /lab


## Show ids script

echo '#!/bin/bash
echo "uid: $(id -u), gid: $(id -g)"' > /lab/show_ids.sh
sudo chmod +x /lab/show_ids.sh

echo "Show ids script:"
ls -l /lab/show_ids.sh
cat /lab/show_ids.sh
