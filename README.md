# Event Management System

A comprehensive **Flask-based Event Management Web Application** that allows users to browse, book, and manage event services including hall bookings, catering, decorations, and photography.

## 🌟 Features

### User Management
- **User Registration & Authentication**
  - Secure signup with strong password validation
  - Email-based login system
  - Session management for logged-in users
  - User role management (default: 'user')

### Service Offerings
- **Hall Bookings**: Find and reserve the perfect venue for your event
- **Catering Services**: Delicious menus crafted for every occasion
- **Decoration Services**: Professional decor tailored to your needs
- **Photography**: Capture special moments with expert photographers

### Interactive Features
- **Contact Form**: Users can send inquiries and messages
- **Feedback System**: Rate and review services
- **Service Details**: Browse detailed information about each service provider
- **Point of Contact Management**: View vendor details, pricing, capacity, amenities, and more

## 🛠️ Technology Stack

- **Backend**: Flask (Python)
- **Database**: MySQL
- **Frontend**: HTML, CSS, JavaScript (Jinja2 templating)
- **Session Management**: Flask sessions with secret key
- **Database Connector**: Flask-MySQLdb

## 📋 Prerequisites

Before running this application, ensure you have the following installed:

- Python 3.7+
- MySQL Server
- pip (Python package manager)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone <your-repo-url>
cd MDSWebProject
```

### 2. Install Dependencies
```bash
pip install flask flask-mysqldb
```

### 3. Database Setup

1. Start your MySQL server
2. Run the SQL script to create the database and tables:
```bash
mysql -u root -p < WebProject/project.sql
```

3. Update database credentials in `WebProject/server.py`:
```python
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'your_username'
app.config['MYSQL_PASSWORD'] = 'your_password'
app.config['MYSQL_DB'] = 'WebProject'
```

### 4. Add Sample Data

Load the sample Points of Contact data from `PocData.csv` into the database (if needed).

### 5. Run the Application
```bash
cd WebProject
python server.py
```

The application will start on `http://127.0.0.1:5000/`

## 📂 Project Structure

```
MDSWebProject/
├── WebProject/
│   ├── server.py              # Main Flask application
│   ├── project.sql            # Database schema
│   ├── static/                # CSS, JS, images, and other static files
│   └── templates/             # HTML templates
│       ├── base.html          # Base template (non-authenticated)
│       ├── sessionbase.html   # Base template (authenticated)
│       ├── home.html          # Landing page
│       ├── sessionhome.html   # Home page for logged-in users
│       ├── login.html         # Login page
│       ├── signup.html        # Registration page
│       ├── aboutus.html       # About us page
│       ├── contactus.html     # Contact form
│       ├── feedback.html      # Feedback form
│       ├── services.html      # Services listing
│       ├── servicesub.html    # Service subcategories
│       └── halls.html         # Detailed service view
├── PocData.csv                # Sample data for Points of Contact
├── ProjectReport.docx         # Project documentation (old)
├── ProjectReportNew.docx      # Updated project documentation
└── README.md                  # This file
```

## 🔐 Password Requirements

The application enforces strong password policies:
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one digit
- At least one special character

## 🗃️ Database Schema

### Tables
1. **AuthUser**: User authentication and profile data
2. **Services**: Event service categories
3. **PointsOfContact**: Vendor details for each service
4. **ContactForm**: User inquiries
5. **Feedback**: User ratings and reviews

## 🎯 Key Routes

| Route | Method | Description |
|-------|--------|-------------|
| `/` | GET | Home page (public) |
| `/signup` | GET, POST | User registration |
| `/login` | GET, POST | User login |
| `/logout` | GET | User logout |
| `/sessionhome` | GET | Home page (authenticated) |
| `/about` | GET | About us page |
| `/contact` | GET | Contact page |
| `/feedback` | GET | Feedback form |
| `/services` | GET | Services listing |
| `/OurServices/<event>` | GET | Service subcategories |
| `/details/<det>` | GET | Detailed service view |
| `/submitContact` | POST | Submit contact form |
| `/submitFeedback` | POST | Submit feedback |

## ⚠️ Security Considerations

**Note**: This project was developed for educational purposes. For production use, please consider:

1. **SQL Injection**: Replace string formatting in SQL queries with parameterized queries
2. **Password Security**: Implement password hashing (e.g., bcrypt, werkzeug.security)
3. **Environment Variables**: Store sensitive data (DB credentials, secret keys) in environment variables
4. **HTTPS**: Use HTTPS in production
5. **CSRF Protection**: Implement CSRF tokens for forms
6. **Input Validation**: Add comprehensive server-side validation

## 📝 Future Enhancements

- Payment gateway integration
- Booking management system
- Admin dashboard
- Email notifications
- Advanced search and filtering
- Real-time availability checking
- Multi-language support

## 👥 Authors

- **Original Developer**: Roshan Varghese
- **Current Maintainer**: Nikhil Jose

## 📄 License

This project is available for educational and personal use.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

---

**Happy Event Planning! 🎉**