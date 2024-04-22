#!/bin/bash -v

## TEST +1

set -x

file_get() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/test$1" -o "~$1"
    sudo chmod +x "~$1"
}

file_get /test/test.txt