-- Citation for code to disable commits and foreign key checks
-- Date: 2/6/24
-- Source: OSU Canvas Project Step 2 Draft
-- https://canvas.oregonstate.edu/courses/1946034/assignments/9456214

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- Drop Trainers table if the table exist
DROP TABLE IF EXISTS Trainers;
-- Create new table called Trainers with tranerID as primary key.
CREATE TABLE Trainers (
    trainerID INT NOT NULL AUTO_INCREMENT UNIQUE,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    PRIMARY KEY(trainerID)
);
-- Set AUTO_INCREMENT TO START AT 9000 for Trainers table
-- to distinguish trainers from members/classes.
ALTER TABLE Trainers AUTO_INCREMENT = 9000;

-- Add sample data to Trainers table.
Insert INTO Trainers (firstName, lastName)
VALUES
('Billy', 'Decker'),
('Logan', 'Cordova'),
('Ethen', 'Pollard'),
('Alyson', 'Sherman'),
('Mia', 'Maddox');

-- Drop Memberships table if the table exists.
DROP TABLE IF EXISTS Memberships;
-- Create new table called Memberships with membershipID as primary key.
CREATE TABLE Memberships (
    membershipID VARCHAR(45) NOT NULL UNIQUE,
    price DECIMAL(19,2) NOT NULL,
    details VARCHAR(100) NOT NULL,
    PRIMARY KEY(membershipID)
);

-- Add sample data to Memberships table.
Insert INTO Memberships (membershipID, price, details)
VALUES
('Gold', '59.99', 'Gym only'),
('Platinum', '79.99', 'Gym + 1 class per week'),
('Diamond',	'99.99', 'Gym + Unlimited classes');

-- Drop Members table if the table exists.
DROP TABLE IF EXISTS Members;
-- Create table called Members with memberID as Primary key. 
-- Members has two foreign keys - membershipID and trainerID.
CREATE TABLE Members (
    memberID INT NOT NULL AUTO_INCREMENT UNIQUE,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    phoneNumber VARCHAR(12) NOT NULL,
    email VARCHAR(100) NOT NULL,
    joinDate DATE NOT NULL,
    birthday DATE NOT NULL,
    membershipID VARCHAR(45) NOT NULL,
    trainerID INT NULL,
    PRIMARY KEY(memberID),
    FOREIGN KEY(membershipID) REFERENCES Memberships(membershipID)
    ON DELETE CASCADE,
    FOREIGN KEY(trainerID) REFERENCES Trainers(trainerID)
    ON DELETE CASCADE
);

-- Add sample data to Members table.
Insert INTO Members (firstName, lastName, phoneNumber, email, joinDate, birthday, membershipID, trainerID)
VALUES
('Cherish', 'Wells', '815-637-9546', 'Cherish.Wells@gmail.com', '2021-03-19',	'2004-09-12', 'Gold', 9001),
('Gracie', 'Jennings', '424-868-7341', 'Gracie.Jennings@gmail.com', '2021-03-19', '2002-07-28', 'Diamond', 9001),
('Irvin', 'Hodges', '232-983-1705', 'Irvin.Hodges@gmail.com', '2021-05-03',	'1974-10-18', 'Gold', NULL),
('Kole',	'Pennington', '437-792-9413', 'Kole.Pennington@gmail.com', '2021-05-03', '1975-04-10', 'Platinum', 9004),
('Roselyn', 'Velez', '764-605-3748',	'Roselyn.Velez@gmail.com',	'2021-05-03',	'1989-07-17', 'Diamond', 9003);

-- Drop Classes table if table exists.
DROP TABLE IF EXISTS Classes;
-- Create table named Classes with primary key classID.
-- Table has one foreign key - trainerID.
CREATE TABLE Classes (
    classID INT NOT NULL AUTO_INCREMENT UNIQUE,
    classType VARCHAR(45) NOT NULL,
    schedule DATETIME NOT NULL,
    trainerID INT NOT NULL,
    PRIMARY KEY(classID),
    FOREIGN KEY(trainerID) REFERENCES Trainers(trainerID)
    ON DELETE CASCADE
);

-- Add sample data to Classes table.
Insert INTO Classes (classType, schedule, trainerID)
VALUES
('HITT', '2024/02/05 08:00:00', 9004),
('Boxing', '2024/02/05 10:00:00', 9002),
('BJJ', '2024/02/05 12:00:00', 9003),
('Yoga', '2024/02/05 14:00:00', 9000),
('Cycling', '2024/02/05 15:00:00', 9001);

-- Drop Member_Classes table if table exists.
DROP TABLE IF EXISTS MemberClasses;
-- Create table named Member_Classes with primary key member_classes_id
-- Table has two foreign keys - memberID and classID.
-- This table serves as a connection for a M:N relationship 
-- between Members and Classes.
CREATE TABLE MemberClasses (
    memberClassesID INT NOT NULL AUTO_INCREMENT UNIQUE,
    memberID INT NOT NULL,
    classID INT NOT NULL,
    PRIMARY KEY (memberClassesID),
    FOREIGN KEY (memberID) REFERENCES Members(memberID)
    ON DELETE CASCADE,
    FOREIGN KEY (classID) REFERENCES Classes(classID)
    ON DELETE CASCADE
);

-- Add sample data to Member_Classes.
INSERT INTO MemberClasses(memberID, classID)
VALUES
(1,1),
(2,1),
(5,1),
(4,2),
(3,3);


-- Citation for code to enable commits and foreign key checks
-- Date: 2/6/24
-- Source: OSU Canvas Project Step 2 Draft
-- https://canvas.oregonstate.edu/courses/1946034/assignments/9456214

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
