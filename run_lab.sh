#!/bin/bash
run_lab() {
    curl -OJL https://raw.githubusercontent.com/Nummulith/aws_labs/main/"$1".sh -o "$1"
    chmod +x "$1".sh
    ./"$filename".sh
}
run_lab("hello_world")
