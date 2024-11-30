# Enter the server code
from flask import *
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'   # MySQL username
app.config['MYSQL_PASSWORD'] = '!QazmlP)9021'  # MySQL password
app.config['MYSQL_DB'] = 'FullStackWebDevelopment'  # Database name
mysql = MySQL(app)


@app.route('/')
def home():
   print("hello")
   return render_template('home.html')

app.run(debug=True)

