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

cd /lab

echo "lab folder created:"
ls -ld /lab
echo


# bash show ids script (does not work)

#echo '#!/bin/bash
#echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh


## gcc

sudo yum install -yq gcc

echo 'gcc installed:'
yum info gcc
echo


## Show ids script

echo '
#include <stdio.h>
#include <unistd.h>
int main () {
    printf("REAL      %d:%d\n", getuid (), getgid ());
    printf("EFFECTIVE %d:%d\n", geteuid(), getegid());
}
' > show_ids.c

gcc show_ids.c -o show_ids

chmod +x show_ids
chown foo:bar show_ids

echo "Show ids script:"
ls -l show_ids
cat show_ids
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
