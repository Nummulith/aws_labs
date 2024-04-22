#!/bin/bash -v

# install pip, python and flask

sudo yum update -yq
python3 --version
python3 -m ensurepip
pip3 --version
pip3 install --upgrade pip
pip3 install flask
flask --version

cd ~
pwd
ls

# download app

file_get() {
    curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/test/$1" -o ~/$1;
    chmod +x ~/$1;
}

file_get app.py

mkdir templates
file_get /templates/index.html
file_get /templates/books.html

# run flask

export FLASK_ENV=development
export FLASK_APP=app.py

@flask run --debug --host=0.0.0.0
