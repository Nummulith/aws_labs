sudo yum update -y
python3 --version
pip3 --version
python3 -m ensurepip
pip3 --version
pip3 install --upgrade pip
pip3 install flask
flask --version
pwd
ls
sudo nano app.py
from flask import Flask
app = Flask(__name__)
@app.get('/')
def index():
  return 'Hello world'
flask run --debug --host=0.0.0.0