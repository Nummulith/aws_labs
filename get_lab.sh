#!/bin/bash

get_lab() {
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/aws_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}

get_lab hello_world
