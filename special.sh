#!/bin/bash

## Users and group

useradd foo
useradd bar
groupadd labusers

usermod -aG labusers foo
usermod -aG labusers bar

echo
echo "Users and group are created:"
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'


## Lab directory

mkdir /lab
chown ec2-user:labusers /lab

echo
echo "lab folder created:"
ls -ld /lab

cd /lab


## Show ids script

echo '#!/bin/bash
echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh
sudo chmod +x /lab/show_ids.sh
chown foo:bar /lab/show_ids.sh

echo
echo "Show ids script:"
ls -l /lab/show_ids.sh
cat /lab/show_ids.sh


## Sublabs
lab_get() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}

lab_get special_suid
lab_get special_sgid
lab_get special_sb

echo
echo "Sublabs downloaded:"
ls /usr/local/bin/special_*.sh
