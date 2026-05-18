USE master;
GO
--create the farm database only if it does not already exist
IF NOT EXISTs (SELECT name FROM sys.databases WHERE name = 'Farm')
BEGIN   
    CREATE DATABASE Farm;
END
GO
--Switch to the farm database
USE Farm;
GO
--Create Chicken table
CREATE TABLE Chicken(
    ChickID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Breed VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    EggProduction DECIMAL(5,2) NOT NULL, --eggs per day
    IsPregnant BIT NOT NULL, --1 FOR YES, 0 FOR NO
    LastVetCheck DATE NOT NULL
);
GO
--Insert data into Chicken table
INSERT INTO Chicken(Name, Breed, Age, EggProduction, IsPregnant, LastVetCheck)
VALUES
('Jeffy', 'Holstein', 5,25.5,1, '2026-04-01'),
('Lilly', 'Jersey', 3,20.0,0, '2026-03-15'),
('Tumi', 'Guernsey', 4,23.8,1, '2026-03-30');
GO