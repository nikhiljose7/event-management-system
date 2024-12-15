CREATE DATABASE WebProject ;
use WebProject;
CREATE TABLE AuthUser (
  AuthID int PRIMARY KEY AUTO_INCREMENT,
  AName varchar(50) NOT NULL,
  Mobile bigint NOT NULL, -- Use bigint for mobile to avoid overflow
  Email varchar(50) NOT NULL,
  APassword varchar(50) NOT NULL,
  ARole varchar(50) DEFAULT 'user'
);
CREATE TABLE Services (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each service
    ServiceName VARCHAR(100) NOT NULL,        -- Name of the service
    ServiceImage VARCHAR(255),                -- Path or URL for the service image
    ServiceDescription TEXT                   -- Description of the service
);
INSERT INTO Services (ServiceName, ServiceImage, ServiceDescription) VALUES
('Hall Bookings', 'images/elegant_venue.jpg', 'Find and book the perfect venue for your event.'),
('Catering', 'images/royal_feast.jpg', 'Delicious menus crafted for every occasion.'),
('Decorations', 'images/decorations.jpg', 'Professional decor services tailored to your needs.'),
('Photography', 'images/photography.jpg', 'Capture your special moments with expert photographers.');
CREATE TABLE PointsOfContact (
    POCID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key for Points of Contact
    ServiceID INT NOT NULL,              -- Foreign Key referencing Services
    Name VARCHAR(255) NOT NULL,          -- Name of the Point of Contact or Service
    Price DECIMAL(10, 2),                -- Price associated with the service
    Capacity VARCHAR(50),                -- Capacity details
    Description TEXT,                    -- Description of the service or POC
    Address TEXT,                        -- Address details
    MainImage VARCHAR(255),              -- Main image file name or URL
    Image1 VARCHAR(255),                 -- Additional image
    Image2 VARCHAR(255),                 -- Additional image
    Image3 VARCHAR(255),                 -- Additional image
    Image4 VARCHAR(255),                 -- Additional image
    Amenities TEXT,                      -- List of amenities
    Link VARCHAR(255),                   -- External link for more information
    CuisinesOffered TEXT,                -- List of cuisines offered
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE CASCADE
);

CREATE TABLE ContactForm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    authid int,
    foreign key (authid) references AuthUser(AuthID) on delete cascade
);
CREATE TABLE Feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    rating INT NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    authid int,
    foreign key (authid) references AuthUser(AuthID) on delete cascade
);



