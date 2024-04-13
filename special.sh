#!/bin/bash
set +x
set -v

######
echo "
////////////////////////
//
//  Special permissions
//
"

###################################
echo "Users and group are created:"

sudo useradd foo
sudo useradd bar
sudo groupadd labusers

sudo usermod -aG labusers foo
sudo usermod -aG labusers bar

cut -d: -f1,3 /etc/group | awk -F: '$2 >= 1000 && $2 < 65534 {print $1":"$2}'
echo

##################
echo "lab folder:"

sudo mkdir /lab
sudo chown ec2-user:labusers /lab

cd /lab

ls -ld /lab
echo

######################################
# bash show ids script (does not work)
#echo '#!/bin/bash
#echo "uid: $(id -un), gid: $(id -gn)"' > /lab/show_ids.sh

###################
echo 'gcc install:'

sudo yum install -yq gcc

yum info gcc | grep Version
echo

#######################
echo "Show ids script:"

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

cat show_ids.c
echo

############################
echo "Compiling ids script:"

gcc show_ids.c -o show_ids

sudo chown foo:bar show_ids

ls -l show_ids
echo

##########################
echo "Sublabs downloaded:"

lab_get() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}

lab_get special_suid
lab_get special_sgid
lab_get special_sb

ls /usr/local/bin/special_*.sh
echo

########
echo "//
//  Next run special_suid.sh
//
////////////////////////////
"
