CREATE TABLE Users (
  id INT PRIMARY KEY ,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  profile_picture VARCHAR(255),
  bio TEXT
);

CREATE TABLE Profiles (
  id INT PRIMARY KEY,
  user_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  birthdate DATE,
  location VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Services (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE User_Services (
  id INT PRIMARY KEY,
  user_id INT NOT NULL,
  service_id INT NOT NULL,
  purchase_date DATETIME NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (service_id) REFERENCES Services(id)
);

CREATE TABLE Payments (
  id INT PRIMARY KEY ,
  user_id INT NOT NULL,
  service_id INT NOT NULL,
  payment_date DATETIME NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (service_id) REFERENCES Services(id)
);

CREATE TABLE Messages (
  id INT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  message_text TEXT NOT NULL,
  sent_at DATETIME NOT NULL,
  FOREIGN KEY (sender_id) REFERENCES Users(id),
  FOREIGN KEY (receiver_id) REFERENCES Users(id)
);
INSERT INTO Users (id, username, email, password, profile_picture, bio) 
VALUES 
(1, 'johnDoe', 'johndoe@example.com', 'password123', 'https://example.com/johndoe.jpg', 'Software Engineer'),
(2, 'janeDoe', 'janedoe@example.com', 'password123', 'https://example.com/janedoe.jpg', 'Marketing Manager'),
(3, 'bobSmith', 'bobsmith@example.com', 'password123', 'https://example.com/bobsmith.jpg', 'Sales Representative'),
(4, 'aliceJohnson', 'alicejohnson@example.com', 'password123', 'https://example.com/alicejohnson.jpg', 'Graphic Designer'),
(5, 'ikeBrown', 'ikebrown@example.com', 'password123', 'https://example.com/mikebrown.jpg', 'IT Consultant');
INSERT INTO Profiles (id, user_id, first_name, last_name, birthdate, location) 
VALUES 
(1, 1, 'John', 'Doe', '1990-01-01', 'New York'),
(2, 2, 'Jane', 'Doe', '1992-02-02', 'Los Angeles'),
(3, 3, 'Bob', 'Smith', '1985-03-03', 'Chicago'),
(4, 4, 'Alice', 'Johnson', '1995-04-04', 'Miami'),
(5, 5, 'Mike', 'Brown', '1980-05-05', 'San Francisco')
INSERT INTO Services (id, name, description, price) 
VALUES 
(1, 'Premium Messaging', 'Unlimited messaging with priority support', 9.99),
(2, 'Extra Storage', 'Additional 1GB of storage for files and media', 4.99),
(3, 'Ad-Free Experience', 'Remove ads from the messenger app', 2.99),
(4, 'Custom Emoji', 'Create and use custom emojis in messages', 1.99),
(5, 'Priority Customer Support', 'Get priority support for any issues', 19.99),
(6, 'Virtual Meeting Room', 'Host virtual meetings with up to 10 participants', 29.99);
INSERT INTO User_Services (id, user_id, service_id, purchase_date) 
VALUES 
(1, 1, 1, '2022-01-01 00:00:00'),
(2, 2, 2, '2022-01-05 00:00:00'),
(3, 3, 3, '2022-01-10 00:00:00');
INSERT INTO Payments (id, user_id, service_id, payment_date, amount, payment_method) 
VALUES 
(1, 1, 1, '2022-01-01 00:00:00', 9.99, 'Credit Card'),
(2, 2, 2, '2022-01-05 00:00:00', 4.99, 'PayPal'),
(3, 3, 3, '2022-01-10 00:00:00', 2.99, 'Credit Card'),
(4, 1, 1, '2022-01-15 00:00:00', 9.99, 'PayPal'),
(5, 2, 4, '2022-01-20 00:00:00', 1.99, 'Credit Card'),
(6, 3, 5, '2022-01-25 00:00:00', 19.99, 'PayPal');
INSERT INTO Messages (id, sender_id, receiver_id, message_text, sent_at) 
VALUES 
(1, 1, 2, 'Hello, how are you?', '2022-01-01 10:00:00'),
(2, 2, 1, 'I am good, thanks! How about you?', '2022-01-01 10:05:00'),
(3, 3, 4, 'What is your favorite food?', '2022-01-05 12:00:00'),
(4, 4, 3, 'I love pizza! How about you?', '2022-01-05 12:05:00');
UPDATE Users 
SET email = 'johndoe2@example.com', bio = 'Software Engineer at ABC Corp.'
WHERE id = 1;

UPDATE Users 
SET profile_picture = 'https://example.com/janedoe2.jpg', bio = 'Marketing Manager at DEF Inc.'
WHERE id = 2;
UPDATE Profiles 
SET first_name = 'Johnathan', last_name = 'Doe Jr.'
WHERE user_id = 1;

UPDATE Profiles 
SET location = 'San Francisco', birthdate = '1991-02-02'
WHERE user_id = 3;
UPDATE Services 
SET price = 12.99, description = 'Unlimited messaging with priority support and extra features'
WHERE id = 1;

UPDATE Services 
SET name = 'Extra Storage Plus', price = 9.99
WHERE id = 2;
UPDATE User_Services 
SET purchase_date = '2022-02-01 00:00:00'
WHERE user_id = 1 AND service_id = 1;

UPDATE User_Services 
SET service_id = 3
WHERE user_id = 4 AND service_id = 1;
UPDATE Payments 
SET payment_method = 'Bank Transfer', amount = 12.99
WHERE user_id = 1 AND service_id = 1;

UPDATE Payments 
SET payment_date = '2022-02-05 00:00:00', amount = 9.99
WHERE user_id = 4 AND service_id = 2;
UPDATE Messages 
SET message_text = 'Hello, how are you today?', sent_at = '2022-02-01 10:00:00'
WHERE id = 1;

UPDATE Messages 
SET receiver_id = 3, message_text = 'What is your favorite food? 🍔🍕'
WHERE id = 3;
--delete
DELETE FROM Users 
WHERE id = 1;

DELETE FROM Users 
WHERE id = 3;

DELETE FROM Profiles 
WHERE user_id = 2;

DELETE FROM Profiles 
WHERE user_id = 5;
DELETE FROM Services 
WHERE id = 1;

DELETE FROM Services 
WHERE id = 4;
DELETE FROM User_Services 
WHERE user_id = 1 AND service_id = 1;

DELETE FROM User_Services 
WHERE user_id = 4 AND service_id = 2;
DELETE FROM Payments 
WHERE user_id = 1 AND service_id = 1;

DELETE FROM Payments 
WHERE user_id = 3 AND service_id = 3;
DELETE FROM Messages 
WHERE id = 1;

DELETE FROM Messages 
WHERE id = 4;
--3
EXEC sp_rename 'Users', 'Accounts';
EXEC sp_rename 'Accounts.Username', 'AccountName', 'COLUMN';
ALTER TABLE Accounts ALTER COLUMN AccountName nvarchar(50);
