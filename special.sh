#!/bin/bash -v

##//////////////////////
##
##  Special permissions
##

## Users and group

sudo groupadd alice_group
sudo useradd -g alice_group alice

sudo groupadd bob_group
sudo useradd -g bob_group bob

sudo groupadd labusers
sudo usermod -aG labusers alice
sudo usermod -aG labusers bob

cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'

## lab folder

sudo mkdir /lab
sudo chown ec2-user:labusers /lab

ls -ld /lab

cd /lab

## bash show_ids script (SUID, SGID does not work with Bash)
#echo '#!/bin/bash
#echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh

## gcc install

sudo yum install -yq gcc

yum info gcc | grep Version

## show_ids script

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

## Compiling ids_script

gcc show_ids.c -o show_ids

sudo chown alice:bob_group show_ids

ls -l show_ids

## Sublabs download

lab_get() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}

lab_get special_suid
lab_get special_sgid
lab_get special_sb

ls /usr/local/bin/special_*.sh

##
##  Next run special_suid.sh
##
##//////////////////////////
