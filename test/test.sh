#!/bin/bash -v

## TEST

file_get() {
    curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/test$1" -o "~$1"
    chmod +x "~$1"
}

mkdir test
file_get /test/test.txt
