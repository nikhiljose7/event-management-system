CREATE DATABASE WebProject /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
use WebProject;
CREATE TABLE SignIn (
  SigninID int NOT NULL AUTO_INCREMENT,
  SName varchar(50) DEFAULT NULL,
  Mobile int DEFAULT NULL,
  Email varchar(50) DEFAULT NULL,
  SPassword varchar(50) DEFAULT NULL,
  PRIMARY KEY (SigninID)
);

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
INSERT INTO PointsOfContact (POCID, ServiceID, Name, Price, Capacity, Description, Address, MainImage, Image1, Image2, Image3, Image4, Amenities, Link, CuisinesOffered)
VALUES
(1, 1, 'Pai Vista Convention Hall', 65000, 'Upto 800 People', 'Pai Vista Convention Hall is located in Banashankari, Bangalore. Pai Vista Convention Hall has 3 beautiful banquet halls of capacity upto 800 people can manage in floating. All venues are centralised ac, attached dress changing rooms and separate dining area. Pai Vista Convention Hall has spacious car parking which can park upto 40 vehicles. Outside food / catering is not allowed, inhouse catering facility is available and guest need to pay per plate system. Starting menu price per plate or buffet price in Pai Vista Convention Hall is Rs.675. It is pure vegetarian venue and only vegetarian food allowed.', '#3/1,27th Cross End of K.R Road,2nd Stage Canara Bank, Banashankari, Bangalore, 560070', 'PaiVistaMain.jpg', 'PaiVista1.jpg', 'PaiVista2.jpg', 'PaiVista3.jpg', 'PaiVista4.jpg', 'Stage is available at the Venue, Power Backup / Generator is available at the Venue, Basic sound system available, Projector provided with additional charges, Microphone provided with additional charges, Homa / Fire Pooja allowed, Plantain leaf services allowed', 'Pai Vista Convention Hall Banashankari Bangalore | Banquet Hall | Menu, Price, Reviews & Availability', NULL),
(2, 1, 'Farmhouse Collective', 45000, 'Upto 350 People', 'Farmhouse Collective offers two exquisite venues, perfect for a variety of events and celebrations. Whether you choose the expansive Lawn, which accommodates up to 300 seated guests and 350 floating, or the charming Backyard, ideal for more intimate gatherings with a capacity of 50 seated and 80 floating guests, you\'ll find the perfect setting for your special occasion.', 'Nirmala Farm, Virgonagar, Budigere Cross, Old Madras Road, Bangalore, 560049', 'FarmHouseMain.jpg', 'FarmHouse1.jpg', 'FarmHouse2.jpg', 'FarmHouse3.jpg', 'FarmHouse4.jpg', 'Stage is available at the Venue, Power Backup / Generator is available at the Venue, Basic sound system available, Projector provided with additional charges, Microphone provided with additional charges, Homa / Fire Pooja allowed, Plantain leaf services allowed', 'Farmhouse Collective Old Madras Road Bangalore | Event Venue, Cost & Reviews', NULL),
(3, 1, 'Zenya Events And Spaces', 30000, 'Upto 125 People', 'At Zenya Event Space, our commitment goes beyond providing a beautiful venue – we also offer comprehensive event management services. With meticulous attention to detail, our experienced team will collaborate closely with you to transform your vision into a flawless reality. From planning to execution, trust us to curate every aspect, ensuring your event unfolds seamlessly and leaves a lasting impression. Indulge your guests with delectable delights through our expert catering services at Zenya Event Space. From mouthwatering cuisines to impeccable presentation, our culinary offerings are tailored to elevate your event experience. Let us delight your senses and create a memorable gastronomic journey.', '#189, 4th Cross, 4th Main Dollars Colony, JP Nagar, 4th Phase, JP Nagar, Bangalore, 560078', 'ZenyaMain.jpg', 'Zenya1.jpg', 'Zenya2.jpg', 'Zenya3.jpg', 'Zenya4.jpg', 'Stage is available at the Venue, Power Backup / Generator is available at the Venue, Basic sound system available, Projector provided with additional charges, Microphone provided with additional charges, Homa / Fire Pooja allowed, Plantain leaf services allowed', 'Zenya Events And Spaces JP Nagar Bangalore | Banquet Hall | Menu, Price, Reviews & Availability', NULL),
(4, 2, 'KHAGAZ FOODS Catering Services', 250, NULL, 'KHAGAZ FOODS, are pleased to introduce ourself as fine catering service company specializes in variety of cuisines including but not limited to Northern and Southern Indian Cuisines. We provide services for both corporate and private entities, regardless of any sector. We use only finest and fresh ingredients in our dishes, prepared under a highly skilled, professionally trained culinary team.', 'Shop No.1, Ground Floor, 794, 6th Cross, 16th Main Road, Vyalikaval HBCS, Veeraana Palya, Near Chaitanya Techno School, Bengaluru - 560045', 'KhagazMain.png', 'Khagaz1.png', 'Khagaz2.png', 'Khagaz3.png', NULL, NULL, 'Khagaz Foods | Home', 'North Indian, South Indian, Chinese'),
(5, 2, 'ATMOSFIRE', 500, NULL, 'Barbeque Nation introduces ATMOSFIRE, a catering service designed to suit all your party requirements- be it birthdays, weddings, anniversaries, corporate parties or home get- togethers. We provide customised catering solutions- any menu, any location, any occasion to ensure your guests are well taken care of.', 'Barbeque Nation Bangalore', 'BarbequeMain.png', 'Barbeque1.png', 'Barbeque2.png', 'Barbeque3.png', NULL, NULL, 'Barbeque Nation - Price & Reviews | Marriage Catering in Bangalore', 'North Indian, South Indian, Gujarati, Goan, Chinese, Mexican, Japanese, Italian'),
(6, 3, 'Birthday Decoration', 3000, NULL, 'Package Includes: Decoration as in picture, "Happy birthday" foil balloons, hall decoration with balloon of bunches (upto 20 to 25 balloon bunches), happy, birthday banner, Birthday accessories, 10 birthday caps, 10 birthday eye mask, popper, musical knife, lotus candle.', NULL, 'BirthdayMain.png', NULL, NULL, NULL, NULL, NULL, 'Birthday Decoration| A Events.in', NULL),
(7, 3, 'FlowerDecoration', 30000, NULL, 'Flower decoration: Backdrop as in the picture, Door decoration with colorful drapes, door flower bunches for the door (3 nos), Entrance welcome board.', NULL, 'FlowerDecorationMain.png', NULL, NULL, NULL, NULL, NULL, 'Wedding | A Events & Planner', NULL),
(8, 4, 'Arun Joe Photography', 5000, NULL, 'We offer professional photography services for all occasions. We specialize in Bengali Wedding, Indian Wedding, Couple Portraits, Pre-wedding Shoots, Candid Wedding, Theme Wedding, Concept Wedding, Destination Wedding, North Indian Wedding, South Indian Wedding, Catholic Wedding, Tamil Wedding, Engagement, Muslim Wedding, Marwadi Wedding, Christian Wedding, Bridal Portraits, Reception, Gujarati Wedding, Hindu Wedding, Wedding, Birthday, Kids Portraits, New Born, Babies & Kids, Maternity, Convocation, Housewarming, Anniversary and Special Occasion photography and have been in the business for 2 years now.', '6/19, I Floor, II C Cross, Grape Garden Near K V S School, Austin Town, Bengaluru, Karnataka, India', NULL, NULL, NULL, NULL, NULL, NULL, 'Arun Joe Photography - Phone Number, Albums, Packages and Reviews | Photographers from Bengaluru, Karnataka | BookMyShoot', NULL),
(9, 4, 'Chait Photography', 8000, NULL, 'We offer professional photography services for all occasions. We specialize in Hindu Wedding, Candid Wedding, Pre-wedding Shoots, Couple Portraits, Bridal Portraits, Indian candid Wedding, Kids Portraits, New Born, Babies & Kids, Model Portfolio, Portraits, Fashion & Portfolio, Adventure, Destination/Sights, Travel, Wildlife, Flora & Fauna and Nature photography and have been in the business for 1 year now. Apart from regular photography, we offer products and services such as CD / DVD. We cover events in Karnataka, Andhra Pradesh, depending on the requirement. We are comfortable communicating in Telugu and English.', 'Bellendur, Bengaluru, Karnataka, India', NULL, NULL, NULL, NULL, NULL, NULL, 'Chait Photography - Phone Number, Albums, Packages and Reviews | Photographers from Bengaluru, Karnataka | BookMyShoot', NULL);
