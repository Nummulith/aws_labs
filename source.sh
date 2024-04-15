#!/bin/bash -v

##//////////////////////
##
##  Compile Software from Source
##

## 1. Install tools necessary for compiling software:
sudo yum groupinstall "Development Tools" -yq

## 2. Download the Source Code:
wget https://git.kernel.org/pub/scm/utils/dash/dash.git/snapshot/dash-master.tar.gz

## 3. Extract the Source Code:
tar -xvfq dash-master.tar.gz

cd dash-master

## 4. Run autogen.sh to Prepare the Build Environment:
./autogen.sh -q

## 5. Configure the Build (If applicable, depending on the output of autogen.sh):
./configure -q

## 6. Compile the Source Code:
make -q

## 7. Install the Compiled Software:
sudo make install -q

## 8. Verify the Installation Path:
which dash

## 9. Test Running the Installed Software:
dash -c 'echo Hello, Dash!'

##
##//////////////////////////
