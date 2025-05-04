from flask import Flask, request, render_template, redirect, url_for, flash,jsonify,session
from flask_mysqldb import MySQL

app = Flask(__name__)

app.secret_key = 'mihir_super_secret_key' 
# MySQL configurations
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Mihir@001'
app.config['MYSQL_DB'] = 'LibraryManagementSystem'


mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('login.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']  # In production, consider hashing the password

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM `user` WHERE username = %s AND password = %s", (username, password))
        user = cursor.fetchone()
        cursor.close()

        if user:
            session['logged_in'] = True
            session['user'] = {'id': user[0], 'name': user[1]}  # Adjust the indices based on your database schema
            return redirect(url_for('welcome'))  # Redirect to the welcome page on successful login
        else:
            return redirect(url_for('register'))  # Redirect to the registration page if user not found

    return render_template('login.html')


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Insert the new user into the database
        cursor = mysql.connection.cursor()
        try:
            cursor.execute("INSERT INTO `user` (username, password) VALUES (%s, %s)", (username, password))
            mysql.connection.commit()
            return redirect(url_for('login'))
        except Exception as e:
            mysql.connection.rollback()
            flash(str(e))  # You might want to handle this more discreetly in a production environment
        finally:
            cursor.close()

    return render_template('register.html')


@app.route('/admin')
def admin():
    # Render admin login page
    return render_template('adminlogin.html')

@app.route('/admin_login', methods=['POST'])
def admin_login():
    # Fetch form data
    admin_id = request.form['adminId']
    admin_password = request.form['adminPassword']

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM `admin` WHERE username = %s AND `password` = %s", (admin_id, admin_password,))
    admin = cursor.fetchone()
    cursor.close()

    if admin:
        session['admin_logged_in'] = True
        # Successful login, redirect to admin.html
        return redirect(url_for('admin_home'))
    else:
        flash('Invalid admin credentials')
        return redirect(url_for('admin'))

@app.route('/admin_home')
def admin_home():
    # Ensure this route is protected and only accessible by a logged-in admin
    return render_template('admin.html')

@app.route('/manage_books')
def manage_books():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM books WHERE is_deleted = FALSE")
    books = cursor.fetchall()
    cursor.close()
    return render_template('manage_books.html', books=books)

@app.route('/add_book', methods=['GET', 'POST'])
def add_book():
    cursor = mysql.connection.cursor()

    if request.method == 'POST':
        title = request.form['title']
        author_id = request.form['author_id']
        genre_id = request.form['genre_id']
        publishing_year = request.form['publishing_year']
        average_rating = request.form['average_rating']
        ratings_count = request.form['ratings_count']
        publisher_id = request.form['publisher_id']
        sale_price = request.form['sale_price']
        sales_rank = request.form['sales_rank']
        units = request.form['units']

        cursor.execute("""
            INSERT INTO books
            (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank, units)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (title, author_id, genre_id, publishing_year, average_rating, ratings_count, publisher_id, sale_price, sales_rank, units))
        mysql.connection.commit()
        cursor.close()
        flash('Book successfully added!')
        return redirect(url_for('manage_books'))

    # 👇 GET request: fetch dropdown data
    cursor.execute("SELECT AuthorID, AuthorName FROM authors")
    authors = cursor.fetchall()

    cursor.execute("SELECT GenreID, GenreName FROM genres")
    genres = cursor.fetchall()

    cursor.execute("SELECT PublisherID, PublisherName FROM publishers")
    publishers = cursor.fetchall()

    cursor.close()
    return render_template('add_book.html', authors=authors, genres=genres, publishers=publishers)


# @app.route('/delete_book/<int:book_id>', methods=['POST'])
# def delete_book(book_id):
#     cursor = mysql.connection.cursor()
#     cursor.execute("DELETE FROM books WHERE BookID = %s", [book_id])
#     mysql.connection.commit()
#     cursor.close()
#     flash('Book successfully deleted!')
#     return redirect(url_for('manage_books'))


@app.route('/delete_book/<int:book_id>', methods=['POST'])
def delete_book(book_id):
    cursor = mysql.connection.cursor()
    try:
        # Instead of deleting, mark the book as deleted
        cursor.execute("UPDATE books SET is_deleted = TRUE WHERE BookID = %s", [book_id])
        mysql.connection.commit()
    except Exception as e:
        mysql.connection.rollback()
        flash(f'Error while deleting book: {str(e)}')
    finally:
        cursor.close()
    return redirect(url_for('manage_books'))


# Placeholder route for editing books
@app.route('/edit_book/<int:book_id>', methods=['GET', 'POST'])
def edit_book(book_id):
    # Handle GET to show the edit form with book data pre-filled
    # Handle POST to update book data in the database
    # This route will require a template with a form for editing book data
    pass

@app.route('/show_transactions')
def show_transactions():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM transactions")
    transactions = cursor.fetchall()
    cursor.close()
    return render_template('show_transactions.html', transactions=transactions)


@app.route('/welcome')
def welcome():
    if 'logged_in' in session and session['logged_in']:
        return render_template('welcome.html')
    else:
        return redirect(url_for('login'))  # Redirect to login if not logged in




@app.route('/search_books', methods=['POST'])
def search_books():
    search_query = request.form.get('search', '').strip()
    cursor = mysql.connection.cursor()

    if search_query:
        query = """SELECT books.BookID, books.Title, authors.AuthorName, authors.AuthorRating,
                          genres.GenreName, publishers.PublisherName, books.PublishingYear,
                          books.AverageRating, books.SalesRank, books.SalePrice
                   FROM books
                   JOIN authors ON books.AuthorID = authors.AuthorID
                   JOIN genres ON books.GenreID = genres.GenreID
                   JOIN publishers ON books.PublisherID = publishers.PublisherID
                   WHERE books.is_deleted = FALSE AND books.Title LIKE %s"""
        cursor.execute(query, ('%' + search_query + '%',))
    else:
        query = """SELECT books.BookID, books.Title, authors.AuthorName, authors.AuthorRating,
                          genres.GenreName, publishers.PublisherName, books.PublishingYear,
                          books.AverageRating, books.SalesRank, books.SalePrice
                   FROM books
                   JOIN authors ON books.AuthorID = authors.AuthorID
                   JOIN genres ON books.GenreID = genres.GenreID
                   JOIN publishers ON books.PublisherID = publishers.PublisherID
                   WHERE books.is_deleted = FALSE"""
        cursor.execute(query)

    books = cursor.fetchall()
    cursor.close()

    book_list = []
    if books:
        book_list = [dict(
            id=book[0], title=book[1], author=book[2], AuthorRating=book[3],
            GenreName=book[4], PublisherName=book[5], PublishingYear=book[6],
            AverageRating=book[7], SalesRank=book[8], SalePrice=book[9]
        ) for book in books]
    else:
        flash('No books matched your search. Showing all available books instead.')

    return render_template('display.html', books=book_list)


@app.route('/display')
def display():
    # Fallback if user navigates directly without search
    return redirect(url_for('welcome'))




# @app.route('/display')
# def display():
#     # Retrieve books from session
#     books = session.get('books', [])
#     return render_template('display.html', books=books)

@app.route('/checkout', methods=['POST'])
def checkout():
    if 'logged_in' not in session or not session['logged_in']:
        return redirect(url_for('login'))

    selected_ids = request.form.getlist('selected_book_ids')
    if not selected_ids:
        return redirect(url_for('display'))

    cursor = mysql.connection.cursor()
    format_strings = ','.join(['%s'] * len(selected_ids))
    cursor.execute(f"""
        SELECT
            BookID, Title, SalePrice
        FROM books
        WHERE BookID IN ({format_strings})
    """, selected_ids)
    books = cursor.fetchall()
    cursor.close()

    selected_books = [
        {'id': row[0], 'title': row[1], 'SalePrice': row[2]} for row in books
    ]

    return render_template('checkout.html', selected_books=selected_books)

@app.route('/perform_checkout', methods=['POST'])
def perform_checkout():
    if 'logged_in' not in session or not session['logged_in']:
        return redirect(url_for('login'))

    selected_book_ids = request.form.getlist('selected_book_ids')
    if not selected_book_ids:
        return redirect(url_for('display'))

    cursor = mysql.connection.cursor()
    try:
        for book_id in selected_book_ids:
            quantity_str = request.form.get(f'quantities[{book_id}]')
            if not quantity_str or not quantity_str.isdigit():
                raise ValueError(f"Invalid quantity for book ID {book_id}")

            quantity = int(quantity_str)

            # Get book price and available units
            cursor.execute("SELECT SalePrice, units FROM books WHERE BookID = %s", (book_id,))
            row = cursor.fetchone()
            if not row:
                continue  # skip missing books

            sale_price, available_units = row
            if available_units < quantity:
                raise Exception(f"Not enough stock for book ID {book_id}")

            new_units = available_units - quantity
            gross_sales = sale_price * quantity

            # Update units
            cursor.execute("UPDATE books SET units = %s WHERE BookID = %s", (new_units, book_id))

            # Record transaction
            cursor.execute(
                "INSERT INTO transactions (BookID, GrossSales, UnitsSold) VALUES (%s, %s, %s)",
                (book_id, gross_sales, quantity)
            )

        mysql.connection.commit()

    except Exception as e:
        mysql.connection.rollback()
        return str(e), 400

    finally:
        cursor.close()

    return redirect(url_for('checkout_complete'))


@app.route('/checkout_complete')
def checkout_complete():
    return render_template('checkout_complete.html')

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    session.pop('user', None)
    return redirect(url_for('login'))  # Redirect to login page on logout


if __name__ == '__main__':
    app.run(debug=True)
