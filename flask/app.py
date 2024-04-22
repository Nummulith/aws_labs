from flask import Flask, jsonify, request, render_template

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
