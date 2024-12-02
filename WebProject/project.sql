CREATE DATABASE `project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
use project;
CREATE TABLE `signin` (
  `signin_id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Mobile` int DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Signin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE auth_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE EventTypes (
    EventTypeID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(50) NOT NULL UNIQUE,
    BaseCost DECIMAL(10, 2) NOT NULL,
    Description TEXT
);

-- Insert statements for predefined event types
INSERT INTO EventTypes (EventName, BaseCost, Description)
VALUES 
    ('Wedding', 10000.00, 'A formal ceremony with reception and catering services.'),
    ('Baptism', 2000.00, 'A traditional christening ceremony with light refreshments.'),
    ('Birthday Party', 5000.00, 'A fun and entertaining party with decorations, cake, and snacks.');

CREATE TABLE EventRequirements (
    RequirementID INT AUTO_INCREMENT PRIMARY KEY,
    EventTypeID INT NOT NULL,
    RequirementName VARCHAR(100) NOT NULL,
    ApproxCost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (EventTypeID) REFERENCES EventTypes(EventTypeID) ON DELETE CASCADE
);

-- Insert statements for requirements
INSERT INTO EventRequirements (EventTypeID, RequirementName, ApproxCost)
VALUES 
    (1, 'Venue Rental', 5000.00),
    (1, 'Catering', 3000.00),
    (1, 'Photography', 2000.00),
    (2, 'Venue Rental', 1000.00),
    (2, 'Light Refreshments', 500.00),
    (2, 'Decorations', 500.00),
    (3, 'Venue Rental', 2500.00),
    (3, 'Cake', 1000.00),
    (3, 'Party Decorations', 1500.00);

CREATE TABLE Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    signin_id INT NOT NULL, -- Reference to the user creating the event
    EventTypeID INT NOT NULL, -- Reference to EventTypes
    EventDate DATETIME NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    AdditionalNotes TEXT,
    FOREIGN KEY (EventTypeID) REFERENCES EventTypes(EventTypeID) ON DELETE CASCADE
);


CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT NOT NULL,
    AmountPaid DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod ENUM('Credit Card', 'PayPal', 'Bank Transfer') NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);


CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    EventID INT NOT NULL,
    Signin_id INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments TEXT,
    FeedbackDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
    FOREIGN KEY (Signin_ID) REFERENCES signin(Signin_id) ON DELETE CASCADE
);





