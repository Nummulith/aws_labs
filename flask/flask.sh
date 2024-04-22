sudo yum update -yq
python3 --version
python3 -m ensurepip
pip3 --version
pip3 install --upgrade pip
pip3 install flask
flask --version

sudo echo 'from flask import Flask
app = Flask(__name__)
@app.get('/')
def index():
  return 'Hello world'
' > app.py

pwd
ls
flask run --debug --host=0.0.0.0