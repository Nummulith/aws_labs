#!/bin/bash

## Users and group

sudo useradd foo
sudo useradd bar
sudo groupadd labusers

sudo usermod -aG labusers foo
sudo usermod -aG labusers bar

echo "Users and group are created:"
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'
echo


## Lab directory

sudo mkdir /lab
sudo chown ec2-user:labusers /lab

echo "lab folder created:"
ls -ld /lab
echo


## Show ids script

echo '#!/bin/bash
echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh
chmod +x /lab/show_ids.sh
chown foo:bar /lab/show_ids.sh

echo "Show ids script:"
ls -l /lab/show_ids.sh
cat /lab/show_ids.sh
echo


## Sublabs
lab_get() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}

lab_get special_suid
lab_get special_sgid
lab_get special_sb

echo "Sublabs downloaded:"
ls /usr/local/bin/special_*.sh
echo

# Next
echo "Run special_suid.sh"
