import requests
from flask import Flask, jsonify, request, render_template, redirect
import subprocess
import os

app = Flask(__name__)

books = [
  {
    "id": 1,
    "title": "Godfather",
    "author": "Mario Puzo",
    "price": 25.99
  },  
  {
    "id": 2,
    "title": "Humans of New York",
    "author": "Brandon Stanton",
    "price": 19.99
  }  
]
lab_cur = "hello"
result = ""

#curl http://localhost:5000
@app.get('/')
def index(): 
    # return 'Hello world'
    return render_template("index.html")

#curl http://localhost:5000/books
@app.get('/books')
def get_books():
    # return jsonify(books)
    return render_template("books.html", books=books)

#curl http://localhost:5000/book/1
@app.get('/book/<int:id>')
def get_book(id):
    for book in books:
        if book['id'] == id:
            return jsonify(book)

    return f"Book with id {id} not found", 404

#curl http://localhost:5000/add_book --request POST --data '{"id": 3, "title": "War and Peace", "author": "Lev Tolstoy", "price": 35.00}' --header "Content-Type: application/json"
@app.post('/add_book')
def add_book():
    data = request.get_json()
    new_book = {
         "id": data["id"],
         "title": data["title"],
         "author": data["author"],
         "price": data["price"],
    }
    books.append(new_book)
    return jsonify(new_book), 201

#curl http://localhost:5000/update_book/2 --request POST --data '{"id": 3, "title": "War and Peace", "author": "Lev Tolstoy", "price": 35.00}' --header "Content-Type: application/json"
@app.post('/update_book/<int:id>')
def update_book(id):
    data = request.get_json()

    for book in books:
        if book['id'] == id:

            book["id"]     = data["id"]
            book["title"]  = data["title"]
            book["author"] = data["author"]
            book["price"]  = data["price"]

            return jsonify(book)

    return f"Book with id {id} not found", 404

#curl http://localhost:5000/delete_book/2 --request DELETE
@app.delete('/delete_book/<int:id>')
def delete_book(id):
    for book in books:
        if book['id'] == id:
            books.remove(book)
            return f"Book with id {id} has been removed", 200

    return f"Book with id {id} not found", 404

def lab_file(lab):
    return os.path.join("/usr/local/bin", f"{lab}.sh")

def lab_exist(lab):
    return os.path.isfile(lab_file(lab))

#curl http://localhost:5000/labs
@app.get('/labs')
def get_labs():

    username = "Nummulith"
    repository = "linux_labs"

    url = f"https://api.github.com/repos/{username}/{repository}/git/trees/main"
    response = requests.get(url)

    if response.status_code == 200:
        contents = response.json()
        directories = [{"name": content['path'], "exists": lab_exist(content['path'])}
                        for content in contents["tree"]
                        if content['type'] == 'tree'
                    ]
        result = ""
    else:
        directories = []
        result = "Github request error"

    script = ""
    if lab_cur != "" and lab_exist(lab_cur):
        with open(lab_file(lab_cur), 'r') as file:
            script = file.read()
    script = script.replace("\n", "<br>")

    return render_template("labs.html", labs=directories, lab_cur=lab_cur, script=script, result=result)


def run(script_content):
    # return subprocess.run(script_content, shell=True, capture_output=True, text=True).stdout
    return subprocess.run(script_content, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

#curl http://localhost:5000/lab/hello
@app.get('/lab/<lab>')
def get_lab(lab):

    script_content = f'''
    #!/bin/bash -v
    lab_get() {{
        sudo curl -fsSL  -H 'Cache-Control: no-cache, no-store' "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1/$1.sh" -o "/usr/local/bin/$1.sh"
        sudo chmod +x "/usr/local/bin/$1.sh"
    }}
    lab_get {lab}
    {lab}.sh
    '''

    result = run(script_content)

    stdout = result.stdout.replace("\n", "<br>")
    stderr = result.stderr.replace("\n", "<br>")

    return render_template("lab.html", lab=lab, stdout=stdout, stderr=stderr)

#curl http://localhost:5000/lab/hello/select
@app.get('/lab/<lab>/select')
def get_lab_select(lab):
    global lab_cur, result
    lab_cur = lab
    result = ""
    return redirect('/labs')

#curl http://localhost:5000/lab/hello/get
@app.post('/lab/<lab>/run')
def get_lab_get(lab):
    global result

    run_res = run(f"{lab}.sh")
    std_out = run_res.stdout.replace("\n", "<br>")
    std_err = run_res.stderr.replace("\n", "<br>")

    result = std_out
    if std_err != "":
        result += "<br>Errors:<br>" + std_err

    return redirect('/labs')

#curl http://localhost:5000/lab/hello/run
@app.post('/lab/<lab>/get')
def get_lab_run(lab):

    script_content = f'''
    #!/bin/bash -v
    lab_get() {{
        sudo curl -fsSL  -H 'Cache-Control: no-cache, no-store' "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1/$1.sh" -o "/usr/local/bin/$1.sh"
        sudo chmod +x "/usr/local/bin/$1.sh"
    }}
    lab_get {lab}
    '''

    run(script_content)

    return redirect('/labs')
