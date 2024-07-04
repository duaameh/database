CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Phone NVARCHAR(20),
);
CREATE TABLE Employees (
    EmployeeID INT  PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    Salary DECIMAL,
    Department NVARCHAR(50),
    Position NVARCHAR(50)
);
CREATE TABLE Products (
    ProductID INT  PRIMARY KEY,
    ProductName NVARCHAR(40) NOT NULL,
    Description NVARCHAR(MAX),
    Category NVARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    IsActive BIT DEFAULT 1,
    ImageUrl NVARCHAR(MAX)
);

CREATE TABLE orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    PaymentMethod NVARCHAR(50),
    PaymentStatus NVARCHAR(50),
    CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customer (FirstName, LastName, Phone)
VALUES ('John', 'Doe', '123-456-7890'),
       ('Jane', 'Smith', '098-765-4321'),
       ('Alice', 'Johnson', '555-555-5555');
	   INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Gender, Email, Phone, Address, Salary, Department, Position)
VALUES (1, 'Emily', 'Davis', '1985-07-24', 'Female', 'emily.davis@example.com', '123-456-7890', '123 Main St', 60000, 'Sales', 'Manager'),
       (2, 'Michael', 'Brown', '1990-01-15', 'Male', 'michael.brown@example.com', '987-654-3210', '456 Elm St', 55000, 'IT', 'Developer');
	   INSERT INTO Products (ProductID, ProductName, Description, Category, Price, StockQuantity, IsActive, ImageUrl)
VALUES (1, 'Laptop', '15 inch laptop with 8GB RAM', 'Electronics', 999.99, 10, 1, 'http://example.com/laptop.jpg'),
       (2, 'Smartphone', 'Android smartphone with 64GB storage', 'Electronics', 499.99, 25, 1, 'http://example.com/smartphone.jpg');
	   INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status, PaymentMethod, PaymentStatus)
VALUES (1, GETDATE(), 1499.98, 'Pending', 'Credit Card', 'Paid'),
       (2, GETDATE(), 499.99, 'Shipped', 'PayPal', 'Paid');


 --task2
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY ,
    DepartmentName NVARCHAR(100) NOT NULL,
    NumberOfEmployees INT,
    Location NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20),
    JobTitle NVARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(18, 2),
    Address NVARCHAR(255),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    StartDate DATETIME NOT NULL,
    DueDate DATETIME NOT NULL,
    Description NVARCHAR(1000),
    LevelOfImportance NVARCHAR(50) NOT NULL,
    AssignedEmployeeID INT NOT NULL,
   FOREIGN KEY (AssignedEmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    ManagerID INT NOT NULL,
    Viewed BIT DEFAULT 0,
    messege NVARCHAR(max),              
    Date DATETIME,
   FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Department 
VALUES ('HR', 5, 'New York', 1),
       ('IT', 10, 'San Francisco', 1);

INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, JobTitle, DepartmentID, Salary, Address)
VALUES ('John', 'Doe', 'john.doe@example.com', '1234567890', 'HR Manager', 1, 60000, '123 Main St, New York, NY'),
       ('Jane', 'Smith', 'jane.smith@example.com', '0987654321', 'IT Manager', 2, 80000, '456 Market St, San Francisco, CA'),
       ('Alice', 'Brown', 'alice.brown@example.com', '1122334455', 'HR Assistant', 1, 40000, '789 Broadway, New York, NY'),
       ('Bob', 'Johnson', 'bob.johnson@example.com', '6677889900', 'IT Specialist', 2, 50000, '101 First St, San Francisco, CA');

UPDATE Department
SET ManagerID = (SELECT EmployeeID FROM Employees WHERE JobTitle = 'HR Manager')
WHERE DepartmentName = 'HR';

UPDATE Department
SET ManagerID = (SELECT EmployeeID FROM Employees WHERE JobTitle = 'IT Manager')
WHERE DepartmentName = 'IT';

INSERT INTO Tasks 
VALUES ('Prepare HR Report', '2024-07-01', '2024-07-05', 'Prepare the monthly HR report', 'High',3),
       ('Update IT Systems', '2024-07-02', '2024-07-10', 'Perform system updates and maintenance', 'Medium',4);

INSERT INTO Feedback 
VALUES ('Feedback on HR Report',1,0,'The HR report needs more details on employee engagement.'),
       ('Feedback on IT Systems Update', 2,0, 'The IT systems update was successful, but please check the backup systems.'),
       ('General Feedback', 1, 0, 'Great job on the recent recruitment drive. Keep up the good work.');