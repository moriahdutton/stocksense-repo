CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role ENUM('Owner', 'Staff') DEFAULT 'Staff' NOT NULL
);

CREATE TABLE Vendors (
    VendorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    ContactInfo TEXT,
    DeliverySchedule VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(100),
    QuantityInStock INT DEFAULT 0 NOT NULL,
    ReorderLevel INT DEFAULT 10 NOT NULL,
    VendorID INT,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

CREATE TABLE InventoryLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ProductID INT NOT NULL,
    Action ENUM('Add', 'Remove', 'Count') NOT NULL,
    QuantityChanged INT NOT NULL,
    NewQuantity INT NOT NULL,
    UserID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    Date DATETIME NOT NULL,
    Time TIME NOT NULL,
    ProductsUsed TEXT
);

CREATE TABLE AppointmentProducts (
    AppointmentProductID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    ProductID INT NOT NULL,
    QuantityUsed INT NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Users (UserID, Name, Email, Password, Role) VALUES
(1, 'Sarah Thompson', 'sarah@blissfulspa.com', 'hashed_pw_123', 'Owner'),
(2, 'Emily Carter', 'emily@blissfulspa.com', 'hashed_pw_456', 'Staff'),
(3, 'John Smith', 'john@blissfulspa.com', 'hashed_pw_789', 'Staff');

INSERT INTO Vendors (VendorID, Name, ContactInfo, DeliverySchedule) VALUES
(1, 'MedSupply Co.', '123-456-7890, medsupply@co.com', '2 business days'),
(2, 'Aesthetic Essentials', '987-654-3210, info@aesthetics.com', '5 days'),
(3, 'PharmaDirect', '555-123-4567, sales@pharmadirect.com', '3 business days');

INSERT INTO Products (ProductID, Name, Category, QuantityInStock, ReorderLevel, VendorID) VALUES
(1, 'Botox Vials', 'Injectable', 50, 10, 1),
(2, 'Dermal Filler', 'Injectable', 30, 5, 2),
(3, 'Chemical Peel Kit', 'Skincare', 20, 5, 2),
(4, 'Numbing Cream', 'Topical', 100, 20, 3);

INSERT INTO InventoryLogs (LogID, Date, ProductID, Action, QuantityChanged, NewQuantity, UserID) VALUES
(1, '2025-02-24 09:00:00', 1, 'Count', 0, 50, 2),
(2, '2025-02-24 09:05:00', 2, 'Count', 0, 30, 2),
(3, '2025-02-24 12:00:00', 1, 'Remove', -5, 45, 3),
(4, '2025-02-24 15:00:00', 4, 'Add', 20, 120, 2),
(5, '2025-02-25 09:00:00', 3, 'Count', 0, 20, 2);

INSERT INTO Appointments (AppointmentID, ClientName, Date, Time, ProductsUsed) VALUES
(1, 'Jane Doe', '2025-02-25 10:00:00', '10:00:00', '[{"ProductID": 1, "Quantity": 2}, {"ProductID": 3, "Quantity": 1}]'),
(2, 'Mark Johnson', '2025-02-25 11:30:00', '11:30:00', '[{"ProductID": 2, "Quantity": 1}]'),
(3, 'Lisa Brown', '2025-02-25 14:00:00', '14:00:00', '[{"ProductID": 4, "Quantity": 1}]');

INSERT INTO AppointmentProducts (AppointmentProductID, AppointmentID, ProductID, QuantityUsed) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 3, 4, 1);