USE shaoqun_D2;

DROP TABLE IF EXISTS rentEquipment;
DROP TABLE IF EXISTS Rental;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS EquipmentType;
DROP TABLE IF EXISTS Branch;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Maintenance;

-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY IDENTITY,  -- New primary key as an auto-incrementing integer
    Email VARCHAR(255) UNIQUE NOT NULL,    -- Ensuring email uniqueness but not as a primary key
    fname VARCHAR(50) NOT NULL,
    sname VARCHAR(50) NOT NULL,
    phone VARCHAR(20)
    CONSTRAINT CHECK_Email CHECK (Email LIKE '%@%.%') -- Email format validation
);

-- Branch Table
CREATE TABLE Branch(
    BranchName VARCHAR(30) PRIMARY KEY,
    location VARCHAR(100) NOT NULL,
    manager_ID INT,
    FOREIGN KEY (manager_ID) REFERENCES Staff(staff_id)
);

-- Equipment Type Table
CREATE TABLE EquipmentType (
    TypeName VARCHAR(255) PRIMARY KEY,
    ratePerHour DECIMAL(10,2) NOT NULL,
    description VARCHAR(255),
    category VARCHAR(50)
);

-- Equipment Table
CREATE TABLE Equipment(
    EquipmentID INT PRIMARY KEY IDENTITY,
    available BIT NOT NULL DEFAULT 1,
    purchaseDate DATE,
    BranchName VARCHAR(30) NOT NULL,
    TypeName VARCHAR(255) NOT NULL,
    FOREIGN KEY (BranchName) REFERENCES Branch(BranchName),
    FOREIGN KEY (TypeName) REFERENCES EquipmentType(TypeName)
);

-- Rental Table
CREATE TABLE Rental(
    RentalID INT PRIMARY KEY IDENTITY,
    startTime DATETIME NOT NULL,
    endTime DATETIME,
    hireFrom VARCHAR(30) NOT NULL,
    customer_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- rentEquipment Join Table
CREATE TABLE rentEquipment(
    rEquipmentID INT NOT NULL,
    rRentalID INT NOT NULL,
    returnTime DATETIME,
    returnTo VARCHAR(30),
    PRIMARY KEY (rEquipmentID, rRentalID),
    FOREIGN KEY (rEquipmentID) REFERENCES Equipment(EquipmentID),
    FOREIGN KEY (rRentalID) REFERENCES Rental(RentalID)
);

-- Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    branch_ID VARCHAR(30),
    fname VARCHAR(50),
    lname VARCHAR(50),
    position VARCHAR(50),
    FOREIGN KEY (branch_ID) REFERENCES Branch(BranchName)
);

-- Maintenance Table
CREATE TABLE Maintenance (
    record_id INT PRIMARY KEY IDENTITY,
    equipment_ID INT NOT NULL,
    maintenance_date DATE,
    description VARCHAR(255),
    FOREIGN KEY (equipment_ID) REFERENCES Equipment(EquipmentID)
);

-- Insertions would be a combination of what is already provided in the original code plus any new required data.
-- Example:
INSERT INTO Customer (Email, fname, sname, home_phone, work_phone, personal_phone) VALUES
('john.doe@example.com', 'John', 'Doe', '123-456-7890', '234-567-8901', '345-678-9012');

INSERT INTO Customer (Email, fname, sname, phone) VALUES
('john.doe@example.com', 'John', 'Doe', '123-456-7890'),
('jane.smith@example.com', 'Jane', 'Smith', '987-654-3210'),
('michael.jackson@example.com', 'Michael', 'Jackson', '555-123-4567'),
('emily.brown@example.com', 'Emily', 'Brown', '111-222-3333'),
('david.williams@example.com', 'David', 'Williams', '444-555-6666'),
('sarah.miller@example.com', 'Sarah', 'Miller', '777-888-9999'),
('james.wilson@example.com', 'James', 'Wilson', '333-222-1111'),
('jennifer.taylor@example.com', 'Jennifer', 'Taylor', '666-777-8888'),
('robert.anderson@example.com', 'Robert', 'Anderson', '999-888-7777'),
('jessica.martinez@example.com', 'Jessica', 'Martinez', '222-333-4444'),
('william.hernandez@example.com', 'William', 'Hernandez', '888-999-0000'),
('elizabeth.jones@example.com', 'Elizabeth', 'Jones', '777-666-5555'),
('christopher.garcia@example.com', 'Christopher', 'Garcia', '111-000-9999'),
('ashley.brown@example.com', 'Ashley', 'Brown', '444-333-2222'),
('matthew.lopez@example.com', 'Matthew', 'Lopez', '888-777-6666'),
('amanda.gonzalez@example.com', 'Amanda', 'Gonzalez', '555-666-7777'),
('daniel.rodriguez@example.com', 'Daniel', 'Rodriguez', '111-222-3333'),
('brittany.perez@example.com', 'Brittany', 'Perez', '444-555-6666'),
('andrew.sanchez@example.com', 'Andrew', 'Sanchez', '777-888-9999'),
('emily.morales@example.com', 'Emily', 'Morales', '333-222-1111'),
('taylor.rivera@example.com', 'Taylor', 'Rivera', '666-777-8888'),
('alex.johnson@example.com', 'Alex', 'Johnson', '999-888-7777'),
('samantha.torres@example.com', 'Samantha', 'Torres', '222-333-4444'),
('tyler.peterson@example.com', 'Tyler', 'Peterson', '888-999-0000'),
('lauren.morgan@example.com', 'Lauren', 'Morgan', '777-666-5555'),
('ryan.cooper@example.com', 'Ryan', 'Cooper', '111-000-9999'),
('hannah.reed@example.com', 'Hannah', 'Reed', '444-333-2222'),
('nicholas.bailey@example.com', 'Nicholas', 'Bailey', '888-777-6666'),
('kayla.bell@example.com', 'Kayla', 'Bell', '555-666-7777'),
('justin.gomez@example.com', 'Justin', 'Gomez', '111-222-3333'),
('victoria.kelly@example.com', 'Victoria', 'Kelly', '444-555-6666'),
('benjamin.howard@example.com', 'Benjamin', 'Howard', '777-888-9999'),
('megan.ward@example.com', 'Megan', 'Ward', '333-222-1111'),
('zachary.cruz@example.com', 'Zachary', 'Cruz', '666-777-8888'),
('rachel.sanders@example.com', 'Rachel', 'Sanders', '999-888-7777'),
('jacob.barnes@example.com', 'Jacob', 'Barnes', '222-333-4444'),
('heather.price@example.com', 'Heather', 'Price', '888-999-0000');

--select * from Customer;

INSERT INTO Branch (BranchName, location) VALUES
('Auckland Central Branch', 'Auckland'),
('Wellington CBD Branch', 'Wellington'),
('Christchurch Central Branch', 'Christchurch'),
('Hamilton East Branch', 'Hamilton'),
('Tauranga Downtown Branch', 'Tauranga');

--select * from branch;

INSERT INTO EquipmentType (TypeName, ratePerHour) VALUES
('Concrete Mixer', 115.00), --1
('Jackhammer', 20.50),      --2
('Circular Saw', 48.75),    --3
('Drill', 22.25),           --4
('Sander', 20.00),          --5
('Paint Sprayer', 12.00),   --6
('Ladder', 8.50),           --7
('Hammer Drill', 25.75),    --8
('Angle Grinder', 21.50),   --9 
('Table Saw', 30.00),       --10 
('Tile Cutter', 17.25),     --11 
('Air Compressor', 55.00),   --12 
('Demolition Hammer', 10.50),  --13
('Floor Sander', 32.75),       --14
('Plaster Mixer', 58.00),      --15
('Jigsaw', 15.50),             --16 
('Impact Driver', 24.25),      --17
('Router', 19.00),             --18
('Wallpaper Steamer', 14.75),  --19
('Masonry Saw', 27.00),         --20
('Nail Gun', 23.25),            --21
('Planer', 20.00),              --22
('Rotary Hammer', 26.50),       --23  
('Drywall Screwgun', 18.25),    --24
('Brick Saw', 29.00),           --25 
('Staple Gun', 16.75),          --26
('Belt Sander', 21.25),         --27
('Concrete Vibrator', 33.50),   --28 
('Mitre Saw', 22.75);           --29


--select * from EquipmentType;

-- Inserting 150 rows into the Equipment table
INSERT INTO Equipment (available, purchaseDate, BranchName, TypeName)
VALUES
--Auckland Central Branch: EquipmentType 1-20;  Equipment# 1-25 
(1, '2022-01-05', 'Auckland Central Branch', 'Concrete Mixer'),
(1, '2022-11-15', 'Auckland Central Branch', 'Jackhammer'),
(1, '2022-10-20', 'Auckland Central Branch', 'Circular Saw'),
(1, '2020-09-25', 'Auckland Central Branch', 'Drill'),
(1, '2021-02-05', 'Auckland Central Branch', 'Sander'),
(1, '2022-12-10', 'Auckland Central Branch', 'Paint Sprayer'),
(1, '2022-11-20', 'Auckland Central Branch', 'Ladder'),
(1, '2019-10-15', 'Auckland Central Branch', 'Hammer Drill'),
(1, '2022-01-30', 'Auckland Central Branch', 'Angle Grinder'),
(1, '2022-09-10', 'Auckland Central Branch', 'Table Saw'),
(1, '2021-03-19', 'Auckland Central Branch', 'Concrete Mixer'),
(1, '2021-11-15', 'Auckland Central Branch', 'Jackhammer'),
(1, '2022-10-20', 'Auckland Central Branch', 'Circular Saw'),
(1, '2022-04-25', 'Auckland Central Branch', 'Drill'),
(1, '2021-02-05', 'Auckland Central Branch', 'Sander'),
(1, '2021-03-05', 'Auckland Central Branch', 'Tile Cutter'),
(1, '2022-11-25', 'Auckland Central Branch', 'Air Compressor'),
(1, '2022-10-15', 'Auckland Central Branch', 'Demolition Hammer'),
(1, '2022-09-20', 'Auckland Central Branch', 'Floor Sander'),
(1, '2021-01-10', 'Auckland Central Branch', 'Plaster Mixer'),
(1, '2022-12-15', 'Auckland Central Branch', 'Jigsaw'),
(1, '2021-11-30', 'Auckland Central Branch', 'Impact Driver'),
(1, '2022-10-05', 'Auckland Central Branch', 'Router'),
(1, '2022-04-22', 'Auckland Central Branch', 'Wallpaper Steamer'),
(1, '2022-09-25', 'Auckland Central Branch', 'Masonry Saw'),

--Wellington CBD Branch: EquipmentType 11-29; Equipment# 26-50
(1, '2021-03-05', 'Wellington CBD Branch', 'Tile Cutter'),
(1, '2022-11-25', 'Wellington CBD Branch', 'Air Compressor'),
(1, '2022-10-15', 'Wellington CBD Branch', 'Demolition Hammer'),
(1, '2022-09-20', 'Wellington CBD Branch', 'Floor Sander'),
(1, '2021-01-10', 'Wellington CBD Branch', 'Plaster Mixer'),
(1, '2022-12-15', 'Wellington CBD Branch', 'Jigsaw'),
(1, '2021-11-30', 'Wellington CBD Branch', 'Impact Driver'),
(1, '2022-10-05', 'Wellington CBD Branch', 'Router'),
(1, '2022-04-22', 'Wellington CBD Branch', 'Wallpaper Steamer'),
(1, '2022-09-25', 'Wellington CBD Branch', 'Masonry Saw'),
(1, '2022-01-10', 'Wellington CBD Branch', 'Plaster Mixer'),
(1, '2020-11-21', 'Wellington CBD Branch', 'Jigsaw'),
(1, '2021-11-30', 'Wellington CBD Branch', 'Impact Driver'),
(1, '2021-03-05', 'Wellington CBD Branch', 'Router'),
(1, '2021-02-20', 'Wellington CBD Branch', 'Wallpaper Steamer'),
(1, '2022-09-25', 'Wellington CBD Branch', 'Masonry Saw'),
(1, '2022-12-10', 'Wellington CBD Branch', 'Nail Gun'),
(1, '2022-11-15', 'Wellington CBD Branch', 'Planer'),
(1, '2019-10-20', 'Wellington CBD Branch', 'Rotary Hammer'),
(1, '2021-01-25', 'Wellington CBD Branch', 'Drywall Screwgun'),
(1, '2022-09-30', 'Wellington CBD Branch', 'Brick Saw'),
(1, '2022-12-05', 'Wellington CBD Branch', 'Staple Gun'),
(1, '2021-02-10', 'Wellington CBD Branch', 'Belt Sander'),
(1, '2021-10-15', 'Wellington CBD Branch', 'Concrete Vibrator'),
(1, '2022-09-20', 'Wellington CBD Branch', 'Mitre Saw'),

-- Christchurch Central Branch: EquipmentType 1-13 & 21-29; Equipment# 51-80
(1, '2022-12-10', 'Christchurch Central Branch', 'Nail Gun'),
(1, '2022-11-15', 'Christchurch Central Branch', 'Planer'),
(1, '2022-12-10', 'Christchurch Central Branch', 'Nail Gun'),
(1, '2022-11-15', 'Christchurch Central Branch', 'Planer'),
(1, '2019-10-20', 'Christchurch Central Branch', 'Rotary Hammer'),
(1, '2021-01-25', 'Christchurch Central Branch', 'Drywall Screwgun'),
(1, '2022-09-30', 'Christchurch Central Branch', 'Brick Saw'),
(1, '2022-12-05', 'Christchurch Central Branch', 'Staple Gun'),
(1, '2021-02-10', 'Christchurch Central Branch', 'Belt Sander'),
(1, '2021-10-15', 'Christchurch Central Branch', 'Concrete Vibrator'),
(1, '2022-09-20', 'Christchurch Central Branch', 'Mitre Saw'),
(1, '2022-01-05', 'Christchurch Central Branch', 'Concrete Mixer'),
(1, '2022-11-15', 'Christchurch Central Branch', 'Jackhammer'),
(1, '2022-10-20', 'Christchurch Central Branch', 'Circular Saw'),
(1, '2020-09-25', 'Christchurch Central Branch', 'Drill'),
(1, '2021-02-05', 'Christchurch Central Branch', 'Sander'),
(1, '2021-01-15', 'Christchurch Central Branch', 'Jackhammer'),
(1, '2022-11-20', 'Christchurch Central Branch', 'Paint Sprayer'),
(1, '2021-10-25', 'Christchurch Central Branch', 'Ladder'),
(1, '2022-09-30', 'Christchurch Central Branch', 'Hammer Drill'),
(1, '2022-02-05', 'Christchurch Central Branch', 'Angle Grinder'),
(1, '2019-12-10', 'Christchurch Central Branch', 'Table Saw'),
(1, '2020-04-15', 'Christchurch Central Branch', 'Tile Cutter'),
(1, '2020-10-20', 'Christchurch Central Branch', 'Air Compressor'),
(1, '2020-01-25', 'Christchurch Central Branch', 'Demolition Hammer'),
(1, '2022-09-30', 'Christchurch Central Branch', 'Floor Sander'),
(1, '2020-12-10', 'Christchurch Central Branch', 'Table Saw'),
(1, '2022-11-15', 'Christchurch Central Branch', 'Tile Cutter'),
(1, '2021-10-20', 'Christchurch Central Branch', 'Air Compressor'),
(1, '2021-03-25', 'Christchurch Central Branch', 'Demolition Hammer'),


-- Hamilton East Branch: EquipmentType 1-29; Equipment# 81-120
(1, '2022-09-30', 'Hamilton East Branch', 'Floor Sander'),
(1, '2022-12-05', 'Hamilton East Branch', 'Plaster Mixer'),
(1, '2019-02-10', 'Hamilton East Branch', 'Jigsaw'),
(1, '2022-10-15', 'Hamilton East Branch', 'Impact Driver'),
(1, '2019-09-20', 'Hamilton East Branch', 'Router'),
(1, '2020-01-30', 'Hamilton East Branch', 'Wallpaper Steamer'),
(1, '2022-12-05', 'Hamilton East Branch', 'Masonry Saw'),
(1, '2021-11-10', 'Hamilton East Branch', 'Nail Gun'),
(1, '2022-10-15', 'Hamilton East Branch', 'Planer'),
(1, '2019-02-20', 'Hamilton East Branch', 'Rotary Hammer'),
(1, '2022-09-25', 'Hamilton East Branch', 'Drywall Screwgun'),
(1, '2022-12-05', 'Hamilton East Branch', 'Plaster Mixer'),
(1, '2020-02-10', 'Hamilton East Branch', 'Jigsaw'),
(1, '2022-10-15', 'Hamilton East Branch', 'Impact Driver'),
(1, '2022-09-20', 'Hamilton East Branch', 'Router'),
(1, '2020-01-30', 'Hamilton East Branch', 'Wallpaper Steamer'),
(1, '2022-12-10', 'Hamilton East Branch', 'Brick Saw'),
(1, '2022-11-15', 'Hamilton East Branch', 'Staple Gun'),
(1, '2020-01-25', 'Hamilton East Branch', 'Belt Sander'),
(1, '2022-10-30', 'Hamilton East Branch', 'Concrete Vibrator'),
(1, '2021-09-15', 'Hamilton East Branch', 'Mitre Saw'),
(1, '2022-01-05', 'Hamilton East Branch', 'Concrete Mixer'),
(1, '2020-03-10', 'Hamilton East Branch', 'Circular Saw'),
(1, '2022-11-20', 'Hamilton East Branch', 'Jackhammer'),
(1, '2019-10-25', 'Hamilton East Branch', 'Paint Sprayer'),
(1, '2023-02-05', 'Hamilton East Branch', 'Ladder'),
(1, '2022-09-30', 'Hamilton East Branch', 'Hammer Drill'),
(1, '2022-12-05', 'Hamilton East Branch', 'Angle Grinder'),
(1, '2023-01-10', 'Hamilton East Branch', 'Table Saw'),
(1, '2020-10-15', 'Hamilton East Branch', 'Tile Cutter'),
(1, '2019-09-20', 'Hamilton East Branch', 'Air Compressor'),
(1, '2023-03-25', 'Hamilton East Branch', 'Demolition Hammer'),
(1, '2022-11-30', 'Hamilton East Branch', 'Floor Sander'),
(1, '2021-10-05', 'Hamilton East Branch', 'Plaster Mixer'),
(1, '2023-02-10', 'Hamilton East Branch', 'Jigsaw'),
(1, '2021-09-15', 'Hamilton East Branch', 'Impact Driver'),
(1, '2022-12-20', 'Hamilton East Branch', 'Router'),
(1, '2023-01-30', 'Hamilton East Branch', 'Wallpaper Steamer'),
(1, '2022-11-05', 'Hamilton East Branch', 'Masonry Saw'),
(1, '2021-10-10', 'Hamilton East Branch', 'Nail Gun'),

-----Tauranga Downtown Branch: EquipmentType 3-22 & Equipment# 121-150
(1, '2020-10-30', 'Tauranga Downtown Branch', 'Circular Saw'),
(1, '2023-03-05', 'Tauranga Downtown Branch', 'Jackhammer'),
(1, '2019-11-10', 'Tauranga Downtown Branch', 'Paint Sprayer'),
(1, '2020-03-21', 'Tauranga Downtown Branch', 'Ladder'),
(1, '2023-02-20', 'Tauranga Downtown Branch', 'Hammer Drill'),
(1, '2022-09-25', 'Tauranga Downtown Branch', 'Angle Grinder'),
(1, '2021-12-30', 'Tauranga Downtown Branch', 'Table Saw'),
(1, '2021-11-19', 'Tauranga Downtown Branch', 'Circular Saw'),
(1, '2022-04-05', 'Tauranga Downtown Branch', 'Jackhammer'),
(1, '2020-12-10', 'Tauranga Downtown Branch', 'Paint Sprayer'),
(1, '2022-11-21', 'Tauranga Downtown Branch', 'Ladder'),
(1, '2021-01-20', 'Tauranga Downtown Branch', 'Hammer Drill'),
(1, '2022-07-11', 'Tauranga Downtown Branch', 'Angle Grinder'),
(1, '2018-12-30', 'Tauranga Downtown Branch', 'Table Saw'),
(1, '2023-01-05', 'Tauranga Downtown Branch', 'Tile Cutter'),
(1, '2023-01-05', 'Tauranga Downtown Branch', 'Tile Cutter'),
(1, '2022-11-15', 'Tauranga Downtown Branch', 'Air Compressor'),
(1, '2023-10-20', 'Tauranga Downtown Branch', 'Demolition Hammer'),
(1, '2023-02-25', 'Tauranga Downtown Branch', 'Floor Sander'),
(1, '2022-12-05', 'Tauranga Downtown Branch', 'Plaster Mixer'),
(1, '2022-11-10', 'Tauranga Downtown Branch', 'Jigsaw'),
(1, '2021-10-15', 'Tauranga Downtown Branch', 'Impact Driver'),
(1, '2023-01-20', 'Tauranga Downtown Branch', 'Router'),
(1, '2022-09-25', 'Tauranga Downtown Branch', 'Wallpaper Steamer'),
(1, '2019-12-30', 'Tauranga Downtown Branch', 'Masonry Saw'),
(1, '2023-01-05', 'Tauranga Downtown Branch', 'Nail Gun'),
(1, '2022-11-15', 'Tauranga Downtown Branch', 'Planer'),
(1, '2021-03-04', 'Tauranga Downtown Branch', 'Planer'),
(1, '2023-01-05', 'Tauranga Downtown Branch', 'Nail Gun'),
(1, '2020-12-30', 'Tauranga Downtown Branch', 'Masonry Saw');



-- Inserting 75 rows into the Rental table
INSERT INTO Rental (startTime, hireFrom, CustomerEmail)
VALUES
--2023 Auckland Rental# 1-10
('2023-01-01 08:00:00', 'Auckland Central Branch', 'john.doe@example.com'),
('2023-02-15 09:30:00', 'Auckland Central Branch', 'jane.smith@example.com'),
('2023-03-20 10:30:00', 'Auckland Central Branch', 'michael.jackson@example.com'),
('2023-04-25 11:30:00', 'Auckland Central Branch', 'emily.brown@example.com'),
('2023-05-05 12:00:00', 'Auckland Central Branch', 'david.williams@example.com'),
('2023-06-10 13:30:00', 'Auckland Central Branch', 'sarah.miller@example.com'),
('2023-07-20 14:30:00', 'Auckland Central Branch', 'james.wilson@example.com'),
('2023-08-15 15:30:00', 'Auckland Central Branch', 'jennifer.taylor@example.com'),
('2023-09-30 11:00:00', 'Auckland Central Branch', 'david.williams@example.com'),
('2023-10-10 17:00:00', 'Auckland Central Branch', 'john.doe@example.com'),


--2023 Wellington Rental# 11-20
('2023-01-15 10:30:00', 'Wellington CBD Branch', 'christopher.garcia@example.com'),
('2023-02-20 11:00:00', 'Wellington CBD Branch', 'ashley.brown@example.com'),
('2023-03-05 12:30:00', 'Wellington CBD Branch', 'matthew.lopez@example.com'),
('2023-04-10 13:00:00', 'Wellington CBD Branch', 'amanda.gonzalez@example.com'),
('2023-05-20 14:30:00', 'Wellington CBD Branch', 'daniel.rodriguez@example.com'),
('2023-06-15 15:30:00', 'Wellington CBD Branch', 'christopher.garcia@example.com'),
('2023-07-30 16:00:00', 'Wellington CBD Branch', 'andrew.sanchez@example.com'),
('2023-08-10 17:30:00', 'Wellington CBD Branch', 'emily.morales@example.com'),
('2023-9-05 08:30:00', 'Wellington CBD Branch', 'william.hernandez@example.com'),
('2023-10-10 09:00:00', 'Wellington CBD Branch', 'christopher.garcia@example.com'),

--2023 Christchurch Rental# 21-30
('2023-01-25 12:30:00', 'Christchurch Central Branch', 'lauren.morgan@example.com'),
('2023-02-10 13:30:00', 'Christchurch Central Branch', 'ryan.cooper@example.com'),
('2023-03-05 14:00:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),
('2023-04-10 15:30:00', 'Christchurch Central Branch', 'nicholas.bailey@example.com'),
('2023-05-20 16:30:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),
('2023-06-15 17:00:00', 'Christchurch Central Branch', 'ryan.cooper@example.com'),
('2023-07-05 08:30:00', 'Christchurch Central Branch', 'taylor.rivera@example.com'),
('2023-08-10 09:30:00', 'Christchurch Central Branch', 'alex.johnson@example.com'),
('2023-09-15 10:00:00', 'Christchurch Central Branch', 'samantha.torres@example.com'),
('2023-10-20 11:00:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),

--2023 Hamilton Rental# 31-40
('2023-01-05 14:30:00', 'Hamilton East Branch', 'heather.price@example.com'),
('2023-02-10 15:00:00', 'Hamilton East Branch', 'sarah.miller@example.com'),
('2023-03-15 16:30:00', 'Hamilton East Branch', 'michael.jackson@example.com'),
('2023-04-20 17:00:00', 'Hamilton East Branch', 'john.doe@example.com'),
('2023-05-30 08:00:00', 'Hamilton East Branch', 'victoria.kelly@example.com'),
('2023-06-10 09:30:00', 'Hamilton East Branch', 'benjamin.howard@example.com'),
('2023-07-15 10:00:00', 'Hamilton East Branch', 'heather.price@example.com'),
('2023-08-20 11:00:00', 'Hamilton East Branch', 'zachary.cruz@example.com'),
('2023-09-25 12:30:00', 'Hamilton East Branch', 'rachel.sanders@example.com'),
('2023-10-30 13:30:00', 'Hamilton East Branch', 'jacob.barnes@example.com'),


--2023 Tauranga Rental# 41-50
('2023-01-05 16:30:00', 'Tauranga Downtown Branch', 'william.hernandez@example.com'),
('2023-02-10 17:30:00', 'Tauranga Downtown Branch', 'elizabeth.jones@example.com'),
('2023-03-25 14:00:00', 'Tauranga Downtown Branch', 'robert.anderson@example.com'),
('2023-04-30 15:00:00', 'Tauranga Downtown Branch', 'jessica.martinez@example.com'),
('2023-05-25 08:30:00', 'Tauranga Downtown Branch', 'jane.smith@example.com'),
('2023-06-30 09:30:00', 'Tauranga Downtown Branch', 'emily.brown@example.com'),
('2023-07-05 10:30:00', 'Tauranga Downtown Branch', 'david.williams@example.com'),
('2023-08-10 11:00:00', 'Tauranga Downtown Branch', 'sarah.miller@example.com'),
('2023-09-15 12:00:00', 'Tauranga Downtown Branch', 'james.wilson@example.com'),
('2023-10-20 13:30:00', 'Tauranga Downtown Branch', 'jennifer.taylor@example.com'),

--2024 Auckland Rental# 51-55
('2024-04-11 08:00:00', 'Auckland Central Branch', 'john.doe@example.com'),
('2024-05-25 09:30:00', 'Auckland Central Branch', 'jane.smith@example.com'),
('2024-06-10 10:30:00', 'Auckland Central Branch', 'michael.jackson@example.com'),
('2024-07-14 11:30:00', 'Auckland Central Branch', 'emily.brown@example.com'),
('2024-08-13 12:00:00', 'Auckland Central Branch', 'john.doe@example.com'),

--2024 Wellington Rental# 56-60
('2024-04-04 10:30:00', 'Wellington CBD Branch', 'christopher.garcia@example.com'),
('2024-05-12 09:00:00', 'Wellington CBD Branch', 'ashley.brown@example.com'),
('2024-06-11 10:30:00', 'Wellington CBD Branch', 'matthew.lopez@example.com'),
('2024-07-23 11:00:00', 'Wellington CBD Branch', 'ashley.brown@example.com'),
('2024-08-15 12:30:00', 'Wellington CBD Branch', 'daniel.rodriguez@example.com'),

--2024 Christchurch Rental# 61-65
('2024-04-15 8:30:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),
('2024-05-20 9:30:00', 'Christchurch Central Branch', 'ryan.cooper@example.com'),
('2024-06-25 14:00:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),
('2024-07-12 11:30:00', 'Christchurch Central Branch', 'robert.anderson@example.com'),
('2024-08-09 10:30:00', 'Christchurch Central Branch', 'hannah.reed@example.com'),

--2024 Hamilton Rental# 66-70
('2024-04-25 09:30:00', 'Hamilton East Branch', 'heather.price@example.com'),
('2024-05-11 11:00:00', 'Hamilton East Branch', 'sarah.miller@example.com'),
('2024-06-22 10:30:00', 'Hamilton East Branch', 'michael.jackson@example.com'),
('2024-07-13 11:00:00', 'Hamilton East Branch', 'john.doe@example.com'),
('2024-08-27 17:00:00', 'Hamilton East Branch', 'victoria.kelly@example.com'),


--2024 Tauranga  Rental# 71-75
('2024-04-15 09:30:00', 'Tauranga Downtown Branch', 'heather.price@example.com'),
('2024-05-21 11:30:00', 'Tauranga Downtown Branch', 'elizabeth.jones@example.com'),
('2024-06-11 12:00:00', 'Tauranga Downtown Branch', 'robert.anderson@example.com'),
('2024-07-02 12:00:00', 'Tauranga Downtown Branch', 'jessica.martinez@example.com'),
('2024-08-15 12:30:00', 'Tauranga Downtown Branch', 'jane.smith@example.com');



INSERT INTO rentEquipment (rEquipmentID, rRentalID, returnTime, returnTo)
VALUES
--Auckland 2023 Rental# 1-10;  Equipment# 1-25
(1, 1, '2023-01-01 12:00:00', 'Auckland Central Branch'),
(7, 1, '2023-01-01 15:00:00', 'Auckland Central Branch'),
(8, 1, '2023-01-01 15:00:00', 'Auckland Central Branch'),
(2, 2, '2023-02-15 012:30:00', 'Auckland Central Branch'),
(3, 3, '2023-03-21 09:30:00', 'Auckland Central Branch'),
(4, 4, '2023-04-25 17:00:00', 'Auckland Central Branch'),
(21, 4, '2023-04-25 17:00:00', 'Auckland Central Branch'),
(6, 4, '2023-04-26 12:00:00', 'Auckland Central Branch'),
(7, 5, '2023-05-05 15:00:00', 'Auckland Central Branch'),
(21, 6, '2023-06-10 17:00:00', 'Auckland Central Branch'),
(22, 6, '2023-06-10 17:00:00', 'Auckland Central Branch'),
(1, 7, '2023-07-21 09:00:00', 'Auckland Central Branch'),
(8, 8, '2023-08-16 12:00:00', 'Auckland Central Branch'),
(21, 9, '2023-09-30 17:00:00', 'Auckland Central Branch'),
(24, 10, '2023-04-10 12:00:00', 'Auckland Central Branch'),
(3, 10, '2023-10-11 15:00:00', 'Auckland Central Branch'),

--Auckland 2024 Rental 51-55; Equipment# 1-25
(1, 51, '2024-04-11 17:00:00', 'Auckland Central Branch'),
(2, 51, '2024-04-11 17:00:00', 'Auckland Central Branch'),
(7, 51, '2024-04-11 12:00:00', 'Auckland Central Branch'),
(8, 52, null, null),
(11, 52, null, null),
(22, 52, null, null),
(21, 53, null, null),
(22, 53, null, null),
(2, 53, null, null),
(11, 54, null, null),
(13, 54, null, null),
(22, 55, null, null),
(15, 55, null, null),
(16, 55, null, null),


--Wellington 2023 Rental# 11-20; Equipment# 26-50;
(26, 11, '2023-01-15 15:30:00', 'Wellington CBD Branch'),
(27, 11, '2023-01-15 15:30:00', 'Wellington CBD Branch'),
(28, 11, '2023-01-15 17:30:00', 'Wellington CBD Branch'),
(26, 12, '2023-02-20 17:00:00', 'Wellington CBD Branch'),
(33, 12, '2023-02-20 17:00:00', 'Wellington CBD Branch'),
(34, 12, '2023-02-20 17:00:00', 'Wellington CBD Branch'),
(34, 13, '2023-03-05 16:30:00', 'Wellington CBD Branch'),
(35, 13, '2023-03-05 17:30:00', 'Wellington CBD Branch'),
(32, 14, '2023-04-11 09:00:00', 'Wellington CBD Branch'),
(28, 15, '2023-05-20 17:30:00', 'Wellington CBD Branch'),
(29, 15, '2023-05-20 17:30:00', 'Wellington CBD Branch'),
(30, 15, '2023-05-21 12:30:00', 'Wellington CBD Branch'),
(26, 16, '2023-06-17 09:30:00', 'Wellington CBD Branch'),
(27, 16, '2023-06-17 09:30:00', 'Wellington CBD Branch'),
(28, 16, '2023-06-17 09:30:00', 'Wellington CBD Branch'),
(33, 17, '2023-07-31 10:00:00', 'Wellington CBD Branch'),
(34, 18, '2023-08-11 12:30:00', 'Wellington CBD Branch'),
(33, 18, '2023-08-11 12:30:00', 'Wellington CBD Branch'),
(49, 18, '2023-08-12 09:00:00', 'Wellington CBD Branch'),
(42, 19, '2023-9-05 17:30:00', 'Wellington CBD Branch'),
(48, 20, '2023-10-10 17:00:00', 'Wellington CBD Branch'),
(49, 20, '2023-10-10 17:00:00', 'Wellington CBD Branch'),
(50, 20, '2023-10-10 17:00:00', 'Wellington CBD Branch'),


--Wellington 2024 Rental# 56-60; Equipment# 26-50; 
(26, 56, '2024-04-04 17:00:00', 'Wellington CBD Branch'),
(27, 57, null, null),
(28, 57, null, null),
(31, 57, null, null),
(32, 58, null, null),
(40, 58, null, null),
(41, 58, null, null),
(30, 59, null, null),
(31, 59, null, null),
(44, 59, null, null),
(45, 60, null, null),
(50, 60, null, null),

--Christchurch 2023  Rental# 21-30; Equipment# 51-80;
(51, 21, '2023-01-25 17:30:00', 'Christchurch Central Branch'),
(52, 21, '2023-01-25 17:30:00', 'Christchurch Central Branch'),
(65, 21, '2023-01-25 17:30:00', 'Christchurch Central Branch'),
(52, 22, '2023-02-10 17:30:00', 'Christchurch Central Branch'),
(61, 23, '2023-03-06 10:00:00', 'Christchurch Central Branch'),
(71, 23, '2023-03-06 10:00:00', 'Christchurch Central Branch'),
(67, 24, '2023-04-11 11:30:00', 'Christchurch Central Branch'),
(68, 24, '2023-04-11 11:30:00', 'Christchurch Central Branch'),
(69, 24, '2023-04-11 11:30:00', 'Christchurch Central Branch'),
(54, 25, '2023-05-21 12:30:00', 'Christchurch Central Branch'),
(55, 25, '2023-05-21 12:30:00', 'Christchurch Central Branch'),
(56, 25, '2023-05-21 12:30:00', 'Christchurch Central Branch'),
(57, 25, '2023-05-21 12:30:00', 'Christchurch Central Branch'),
(68, 26, '2023-06-16 12:00:00', 'Christchurch Central Branch'),
(71, 27, '2023-07-05 15:30:00', 'Christchurch Central Branch'),
(51, 28, '2023-08-10 14:30:00', 'Christchurch Central Branch'),
(61, 28, '2023-08-11 11:30:00', 'Christchurch Central Branch'),
(72, 28, '2023-08-10 17:30:00', 'Christchurch Central Branch'),
(67, 29, '2023-09-15 14:00:00', 'Christchurch Central Branch'),
(75, 29, '2023-09-15 14:00:00', 'Christchurch Central Branch'),
(77, 29, '2023-09-15 14:00:00', 'Christchurch Central Branch'),
(78, 29, '2023-09-15 14:00:00', 'Christchurch Central Branch'),
(55, 30, '2023-10-20 17:00:00', 'Christchurch Central Branch'),
(64, 30, '2023-10-20 17:00:00', 'Christchurch Central Branch'),

--Christchurch 2024  Rental#61-65; Equipment# 51-80;
(51, 61, '2024-04-15 17:30:00', 'Christchurch Central Branch'),
(52, 61, '2024-04-15 17:30:00', 'Christchurch Central Branch'),
(53, 61, '2024-04-15 17:30:00', 'Christchurch Central Branch'),
(65, 62, null, null),
(66, 62, null, null),
(77, 62, null, null),
(78, 62, null, null),
(68, 63, null, null),
(55, 64, null, null),
(56, 64, null, null),
(57, 64, null, null),
(51, 65, null, null),
(79, 65, null, null),



--Hamilton 2023 Rental# 31-40; Equipment# 81-120;
(81, 31, '2023-01-05 15:30:00', 'Hamilton East Branch'),
(82, 31, '2023-01-05 15:30:00', 'Hamilton East Branch'),
(87, 31, '2023-01-05 15:30:00', 'Hamilton East Branch'),
(88, 31, '2023-01-05 15:30:00', 'Hamilton East Branch'),
(82, 32, '2023-02-11 11:00:00', 'Hamilton East Branch'),
(83, 32, '2023-02-11 11:00:00', 'Hamilton East Branch'),
(83, 33, '2023-03-16 10:30:00', 'Hamilton East Branch'),
(91, 33, '2023-03-16 10:30:00', 'Hamilton East Branch'),
(92, 33, '2023-03-16 10:30:00', 'Hamilton East Branch'),
(93, 33, '2023-03-16 17:30:00', 'Hamilton East Branch'),
(84, 34, '2023-04-21 09:00:00', 'Hamilton East Branch'),
(119, 34, '2023-04-21 09:00:00', 'Hamilton East Branch'),
(98, 34, '2023-04-21 09:00:00', 'Hamilton East Branch'),
(99, 34, '2023-04-21 09:00:00', 'Hamilton East Branch'),
(95, 35, '2023-05-30 17:00:00', 'Hamilton East Branch'),
(117, 35, '2023-05-30 17:00:00', 'Hamilton East Branch'),
(116, 36, '2023-06-10 17:30:00', 'Hamilton East Branch'),
(90, 36, '2023-06-10 17:30:00', 'Hamilton East Branch'),
(93, 36, '2023-06-10 17:30:00', 'Hamilton East Branch'),
(110, 37, '2023-07-15 14:00:00', 'Hamilton East Branch'),
(100, 37, '2023-07-15 14:00:00', 'Hamilton East Branch'),
(111, 38, '2023-08-20 17:00:00', 'Hamilton East Branch'),
(112, 38, '2023-08-20 17:00:00', 'Hamilton East Branch'),
(113, 38, '2023-08-20 17:00:00', 'Hamilton East Branch'),
(114, 38, '2023-08-21 17:00:00', 'Hamilton East Branch'),
(112, 39, '2023-09-25 17:30:00', 'Hamilton East Branch'),
(90, 40, '2023-10-30 17:30:00', 'Hamilton East Branch'),
(95, 40, '2023-10-30 17:30:00', 'Hamilton East Branch'),

--Hamilton 2024 Rental#66-70; Equipment# 81-120; 
(88, 66, '2024-04-25 16:00:00', 'Hamilton East Branch'),
(111, 66, '2024-04-25 16:00:00', 'Hamilton East Branch'),
(112, 66, '2024-04-25 16:00:00', 'Hamilton East Branch'),
(115, 66, '2024-04-25 16:00:00', 'Hamilton East Branch'),
(116, 67, null, null),
(118, 67, null, null),
(112, 68, null, null),
(91, 68, null, null),
(94, 68, null, null),
(101, 69, null, null),
(102, 69, null, null),
(115, 70, null, null),
(112, 70, null, null),
(113, 70, null, null),
(114, 70, null, null),


--Tauranga 2023 Rental# 41-50; Equipment# 121-150;
(121, 41, '2023-01-06 17:30:00', 'Tauranga Downtown Branch'),
(122, 41, '2023-01-06 17:30:00', 'Tauranga Downtown Branch'),
(123, 41, '2023-01-06 17:30:00', 'Tauranga Downtown Branch'),
(124, 41, '2023-01-06 17:30:00', 'Tauranga Downtown Branch'),
(131, 42, '2023-02-11 12:30:00', 'Tauranga Downtown Branch'),
(132, 42, '2023-02-11 12:30:00', 'Tauranga Downtown Branch'),
(133, 42, '2023-02-11 12:30:00', 'Tauranga Downtown Branch'),
(126, 42, '2023-02-11 12:30:00', 'Tauranga Downtown Branch'),
(131, 43, '2023-03-25 17:00:00', 'Tauranga Downtown Branch'),
(134, 44, '2023-04-30 17:00:00', 'Tauranga Downtown Branch'),
(135, 44, '2023-04-30 17:00:00', 'Tauranga Downtown Branch'),
(136, 44, '2023-04-30 17:00:00', 'Tauranga Downtown Branch'),
(137, 44, '2023-04-30 17:00:00', 'Tauranga Downtown Branch'),
(145, 45, '2023-05-25 15:30:00', 'Tauranga Downtown Branch'),
(146, 45, '2023-05-25 15:30:00', 'Tauranga Downtown Branch'),
(147, 45, '2023-05-26 08:30:00', 'Tauranga Downtown Branch'),
(148, 45, '2023-05-26 08:30:00', 'Tauranga Downtown Branch'),
(149, 46, '2023-06-30 17:30:00', 'Tauranga Downtown Branch'),
(135, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(136, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(137, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(138, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(147, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(150, 47, '2023-07-05 17:30:00', 'Tauranga Downtown Branch'),
(148, 48, '2023-08-10 16:00:00', 'Tauranga Downtown Branch'),
(149, 49, '2023-09-15 16:00:00', 'Tauranga Downtown Branch'),
(121, 49, '2023-09-15 16:00:00', 'Tauranga Downtown Branch'),
(122, 49, '2023-09-15 16:00:00', 'Tauranga Downtown Branch'),
(123, 49, '2023-09-15 16:00:00', 'Tauranga Downtown Branch'),
(124, 49, '2023-09-15 16:00:00', 'Tauranga Downtown Branch'),
(150, 50, '2023-10-21 12:30:00', 'Tauranga Downtown Branch'),

----Tauranga 2023 Rental#71-75; Equipment# 121 - 150; 
(143, 71, '2024-04-15 17:00:00', 'Tauranga Downtown Branch'),
(145, 71, '2024-04-15 17:00:00', 'Tauranga Downtown Branch'),
(146, 71, '2024-04-15 17:00:00', 'Tauranga Downtown Branch'),
(123, 71, '2024-04-15 17:00:00', 'Tauranga Downtown Branch'),
(124, 72, null, null),
(125, 72, null, null),
(127, 72, null, null),
(133, 72, null, null),
(150, 73, null, null),
(146, 74, null, null),
(147, 74, null, null),
(148, 74, null, null),
(123, 74, null, null),
(124, 75, null, null),
(128, 75, null, null),
(129, 75, null, null);




