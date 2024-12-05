# Enter the server code
from flask import Flask, render_template, request, redirect, session
#from flask import *
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'   # MySQL username
app.config['MYSQL_PASSWORD'] = '!QazmlP)9021'  # MySQL password
app.config['MYSQL_DB'] = 'FullStackWebDevelopment'  # Database name
mysql = MySQL(app)

# Secret key for session management
app.config['SECRET_KEY'] = 'mysecretkey'

# Password validation function
def password_check(password, min_length=8):
    reasons = []
    if not any(char.isupper() for char in password):
        reasons.append("Password must contain at least one uppercase letter.")
    if not any(char.islower() for char in password):
        reasons.append("Password must contain at least one lowercase letter.")
    if not any(char.isalpha() for char in password):
        reasons.append("Password must contain alphabetic characters.")
    if not any(char.isdigit() for char in password):
        reasons.append("Password must contain at least one digit.")
    if not any(not char.isalnum() for char in password):
        reasons.append("Password must contain at least one special character.")
    if len(password) < min_length:
        reasons.append(f"Password must be at least {min_length} characters long.")

    if reasons:
        return False, reasons
    return True, ["Password is strong."]


@app.route("/")
def home():
    return render_template("home.html")

# Routes for login and signup
@app.route("/login")
def login():
    return render_template("login.html")
@app.route("/signup")
def signup():
    return render_template("signup.html")


@app.route("/createuser", methods=['POST'])
def createuser():
    username = request.form['username']
    email = request.form['email']
    password = request.form['password']

    is_strong, feedback = password_check(password)
    if not is_strong:
        return render_template("signup.html", message=" ".join(feedback))

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO auth_user(username, email, password) VALUES (%s, %s, %s)", (username, email, password))
    dbconn.commit()
    cursor.close()

    return render_template("login.html", message="Registration successful. Please log in.")

@app.route("/createsession", methods=['POST'])
def createsession():
    email = request.form['email']
    password = request.form['password']

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("SELECT username FROM auth_user WHERE email = %s AND password = %s", (email, password))
    user = cursor.fetchone()
    cursor.close()

    if user:
        session['loggedin'] = True
        session['username'] = user[0]
        return redirect("/index")
    else:
        return render_template("login.html", message="Invalid email or password. Please try again.")

@app.route("/logout")
def logout():
    session.pop('username', None)
    session.pop('loggedin', None)
    return redirect("/")

# Home page route
@app.route("/index")
def index():
    if 'loggedin' in session:
        return render_template("index.html", message=f"Welcome back, {session['username']}!")
    else:
        return redirect("/")








# Routes for managing event types
@app.route("/event_types")
def event_types():
    return render_template("event_types.html")

@app.route("/add_event_type", methods=['POST'])
def add_event_type():
    event_name = request.form['event_name']
    base_cost = request.form['base_cost']
    description = request.form['description']

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO EventTypes (EventName, BaseCost, Description) VALUES (%s, %s, %s)", (event_name, base_cost, description))
    dbconn.commit()
    cursor.close()

    return redirect("/event_types")

# Routes for managing event requirements
@app.route("/event_requirements")
def event_requirements():
    return render_template("event_requirements.html")

@app.route("/add_event_requirement", methods=['POST'])
def add_event_requirement():
    event_type_id = request.form['event_type_id']
    requirement_name = request.form['requirement_name']
    approx_cost = request.form['approx_cost']

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO EventRequirements (EventTypeID, RequirementName, ApproxCost) VALUES (%s, %s, %s)", (event_type_id, requirement_name, approx_cost))
    dbconn.commit()
    cursor.close()

    return redirect("/event_requirements")

# Routes for creating events
@app.route("/events")
def events():
    return render_template("events.html")

@app.route("/create_event", methods=['POST'])
def create_event():
    signin_id = request.form['signin_id']
    event_type_id = request.form['event_type_id']
    event_date = request.form['event_date']
    total_cost = request.form['total_cost']
    additional_notes = request.form.get('additional_notes', '')

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO Events (signin_id, EventTypeID, EventDate, TotalCost, AdditionalNotes) VALUES (%s, %s, %s, %s, %s)",
                   (signin_id, event_type_id, event_date, total_cost, additional_notes))
    dbconn.commit()
    cursor.close()

    return redirect("/events")

# Routes for recording payments
@app.route("/payments")
def payments():
    return render_template("payments.html")

@app.route("/record_payment", methods=['POST'])
def record_payment():
    event_id = request.form['event_id']
    amount_paid = request.form['amount_paid']
    payment_method = request.form['payment_method']

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO Payments (EventID, AmountPaid, PaymentMethod) VALUES (%s, %s, %s)", (event_id, amount_paid, payment_method))
    dbconn.commit()
    cursor.close()

    return redirect("/payments")

# Routes for submitting feedback
@app.route("/feedback")
def feedback():
    return render_template("feedback.html")

@app.route("/submit_feedback", methods=['POST'])
def submit_feedback():
    event_id = request.form['event_id']
    signin_id = request.form['signin_id']
    rating = request.form['rating']
    comments = request.form.get('comments', '')

    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute("INSERT INTO Feedback (EventID, Signin_id, Rating, Comments) VALUES (%s, %s, %s, %s)", (event_id, signin_id, rating, comments))
    dbconn.commit()
    cursor.close()

    return redirect("/feedback")

if __name__ == "__main__":
    app.run(debug=True)

