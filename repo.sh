#!/bin/bash -v
sudo yum-config-manager --add-repo=https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.rpm
cd /etc/yum.repos.d/
sudo mv dl.fedoraproject.org_pub_epel_epel-release-latest-7.rpm.repo epel.repo
cat epel.repo
# change the file to simplier strings !!!
yum repolist
sudo yum-config-manager --disable epel
