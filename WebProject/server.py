# Enter the server code
from flask import Flask, render_template, request, redirect, session
#from flask import *
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'   # MySQL username
app.config['MYSQL_PASSWORD'] = '!QazmlP)9021'  # MySQL password
app.config['MYSQL_DB'] = 'WebProject'  # Database name
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
# Pages
# /   Home Completed
# /about  Completed
# /contact  
# /bookhall
# /decorations
# /catering
# /login Completed
# /signup Completed

# Routes for default home page
@app.route("/")
def home():
    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute(f"select * from Services")
    result = cursor.fetchall()
    cursor.close()
    return render_template("home.html",res = result)
@app.route("/sessionhome")
def sessionhome():
    if 'loggedin' in session:
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"select * from Services")
        result = cursor.fetchall()
        cursor.close()
        return render_template("sessionhome.html", user=f"Welcome back, {session['username']}!",res=result)
    else:
        return redirect("/")





# Routes for signup
@app.route("/signup", methods=['GET','POST'])
def signup():
    if request.method=="POST":
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        repassword = request.form['repassword']
        mobile = request.form['mobile']
        if password == repassword:
            is_strong, feedback = password_check(password)
            if not is_strong:
                return render_template("signup.html", message=" ".join(feedback))
            dbconn = mysql.connection
            cursor = dbconn.cursor()
            cursor.execute(f"Select * from AuthUser where Email='{email}'")
            res = cursor.fetchone()
            if res:
                return render_template("signup.html", message="There is already a user registered with this Email. Please Login!!")
            cursor.execute(f"INSERT INTO AuthUser(AName, Mobile, Email, APassword) VALUES ('{username}', '{mobile}', '{email}', '{password}')")
            dbconn.commit()
            cursor.close()
            return render_template("login.html", message="Registration successful. Please log in.")
        else:
            return render_template("signup.html", message="The Passwords do not match!")
    return render_template("signup.html")
# Routes for Login and creating session
@app.route("/login", methods=['GET','POST'])
def login():
    if request.method == "POST":
        email = request.form['email']
        password = request.form['password']
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"SELECT AuthID,AName FROM AuthUser WHERE email = '{email}' AND apassword = '{password}'")
        user = cursor.fetchone()
        cursor.close()
        if user:
            session['loggedin'] = True
            session['username'] = user[1] 
            session['userid'] = user[0]   
            return redirect("/sessionhome")
        else:
            return render_template("login.html", message="Invalid email or password. Please try again.")
    return render_template("login.html")
# Routes for Logout
@app.route("/logout")
def logout():
    session.pop('userid',None)
    session.pop('username', None)
    session.pop('loggedin', None)
    return redirect("/")







# Route for About us
@app.route("/about")
def aboutus():
    if 'loggedin' in session:
        return render_template("aboutus.html",log = 'loggedin')    
    return render_template("aboutus.html")
# Route for Contact us
@app.route("/contact")
def contactus():
    if 'loggedin' in session:
        return render_template("contactus.html",log = 'loggedin')
    return render_template("contactus.html")
# Routes for submitting feedback
@app.route("/feedback")
def feedback():
    if 'loggedin' in session:
        return render_template("feedback.html",log = 'loggedin')
    return render_template("feedback.html")

@app.route("/services")
def services():
    if 'loggedin' in session:
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"select * from Services")
        result = cursor.fetchall()
        cursor.close()
        return render_template("services.html",res=result)
    return redirect("/")

@app.route("/OurServices/<event>")
def ourservices(event):
    if 'loggedin' in session:
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"select Name, MainImage, pocid from PointsOfContact where ServiceID = {event[0]}")
        result = cursor.fetchall()
        cursor.close()
        return render_template("servicesub.html",res=result,eve=event)
    return redirect("/")

@app.route("/details/<det>")
def details(det):
    if 'loggedin' in session:
        det1 = det.split(" ")
        print(det1)
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"select * from PointsOfContact where pocid = {det1[0]}")
        result = cursor.fetchone()
        cursor.close()
        print(result)
        return render_template("halls.html", res=result)
    return redirect("/")







@app.route("/submitFeedback", methods=['POST'])
def submitFeedback():
    if 'loggedin' in session:
        name = request.form['name']
        email = request.form['email']
        rating = request.form['rating']
        message = request.form['message']
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"INSERT INTO Feedback (name, email, rating, message, authid) VALUES ('{name}', '{email}', '{rating}', '{message}','{session['userid']}')")
        dbconn.commit()
        cursor.close()
        return redirect("/feedback")
    return redirect("/")

@app.route("/submitContact", methods=['GET','POST'])
def submitContact():
    if 'loggedin' in session:
        name = request.form['name']
        email = request.form['email']
        message = request.form['message']
        dbconn = mysql.connection
        cursor = dbconn.cursor()
        cursor.execute(f"INSERT INTO ContactForm (name, email, message, authid) VALUES ('{name}', '{email}', '{message}','{session['userid']}')")
        dbconn.commit()
        cursor.close()
        return redirect("/contact")
    name = request.form['name']
    email = request.form['email']
    message = request.form['message']
    dbconn = mysql.connection
    cursor = dbconn.cursor()
    cursor.execute(f"INSERT INTO ContactForm (name, email, message) VALUES ('{name}', '{email}', '{message}')")
    dbconn.commit()
    cursor.close()
    return redirect("/contact")


if __name__ == "__main__":
    app.run(debug=True)

