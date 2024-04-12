#!/bin/bash

# Header
echo "
////////////////////////
//
//  Special permissions
//
"

# Users and group
sudo useradd foo
sudo useradd bar
sudo groupadd labusers

sudo usermod -aG labusers foo
sudo usermod -aG labusers bar

echo "Users and group are created:"
cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'
echo

# Lab directory
sudo mkdir /lab
sudo chown ec2-user:labusers /lab

cd /lab

echo "lab folder created:"
ls -ld /lab
echo

# bash show ids script (does not work)
#echo '#!/bin/bash
#echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh

# gcc
sudo yum install -yq gcc

echo 'gcc installed:'
yum info gcc | grep Version
echo

# show_ids script
echo '#include <stdio.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>
int main() {
    uid_t ruid = getuid(); gid_t rgid = getgid(); uid_t euid = geteuid(); gid_t egid = getegid();
    printf("Real      user: %s(%d):%s(%d)\n", getpwuid(ruid)->pw_name, ruid, getgrgid(rgid)->gr_name, rgid);
    printf("Effective user: %s(%d):%s(%d)\n", getpwuid(euid)->pw_name, euid, getgrgid(egid)->gr_name, egid);
    return 0;
}' > show_ids.c

echo "Show ids script:"
cat show_ids.c
echo

# Compiling script
gcc show_ids.c -o show_ids

sudo chown foo:bar show_ids

echo "Show ids script:"
ls -l show_ids
echo

# Sublabs
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
echo "
//
//  Next run special_suid.sh
//
////////////////////////
"
