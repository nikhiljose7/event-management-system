# Quick Setup Guide

## For New Users

Follow these steps to get the Event Management System up and running:

### Step 1: Clone the Repository
```bash
git clone <your-new-repo-url>
cd MDSWebProject
```

### Step 2: Create Virtual Environment (Recommended)
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

### Step 3: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 4: Setup MySQL Database

1. Open MySQL Command Line or MySQL Workbench
2. Create a new database:
   ```sql
   CREATE DATABASE WebProject;
   ```
3. Run the SQL script:
   ```bash
   mysql -u root -p WebProject < WebProject/project.sql
   ```

### Step 5: Configure Database Connection

Edit `WebProject/server.py` and update these lines with your MySQL credentials:

```python
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'          # Your MySQL username
app.config['MYSQL_PASSWORD'] = 'your_password'  # Your MySQL password
app.config['MYSQL_DB'] = 'WebProject'
```

### Step 6: (Optional) Add Sample Data

If you want to populate the database with sample services, you can manually insert data or import from `PocData.csv`.

### Step 7: Run the Application
```bash
cd WebProject
python server.py
```

### Step 8: Access the Application

Open your web browser and navigate to:
```
http://127.0.0.1:5000/
```

## Troubleshooting

### MySQL Connection Issues
- Ensure MySQL server is running
- Check username and password in `server.py`
- Verify the database `WebProject` exists

### Module Not Found Errors
```bash
pip install flask flask-mysqldb
```

### Port Already in Use
If port 5000 is already in use, modify the last line in `server.py`:
```python
app.run(debug=True, port=5001)  # Change to any available port
```

## Default Test Credentials

After setting up, you'll need to register a new user. There are no default credentials.

## Need Help?

- Check the main README.md for detailed documentation
- Review the project structure
- Ensure all prerequisites are installed

---

**Happy Coding! 🚀**
