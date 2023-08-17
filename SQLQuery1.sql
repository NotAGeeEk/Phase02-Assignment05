-- Create the database
CREATE DATABASE Assesment05Db;
USE Assesment05Db;

-- Create the schema
CREATE SCHEMA bank;
GO

-- Create the Customer table
CREATE TABLE bank.Customer (
    Cld INT PRIMARY KEY IDENTITY(1000, 1),
    CName NVARCHAR(100) NOT NULL,
    CEmail NVARCHAR(100) NOT NULL UNIQUE,
    Contact NVARCHAR(20) NOT NULL UNIQUE,
    CPwd AS RIGHT(CName, 2) + CAST(Cld AS NVARCHAR(10)) + LEFT(Contact, 2) PERSISTED
);
GO
insert into bank.Customer(CName,CEmail,Contact) values ('Aman ','AMancul@gmail.com','9090908080')
insert into bank.Customer(CName,CEmail,Contact) values ('Nikhit','Nikh@gmail.com','9090907070')
insert into bank.Customer(CName,CEmail,Contact) values ('Nikhil','Nkhil2@gmail.com','9090808080')
insert into bank.Customer(CName,CEmail,Contact) values ('Pragya','Prgya@gmail.com','8077807790')
insert into bank.Customer(CName,CEmail,Contact) values ('Apoorva','apurva@gmail.com','8077505070')

select * from bank.Customer

-- Create the Mailinfo table
CREATE TABLE bank.Mailinfo (
    MailTo NVARCHAR(100) PRIMARY KEY,
    CEmail NVARCHAR(100) NOT NULL,
    MailDate DATE DEFAULT GETDATE(),
    MailMessage NVARCHAR(MAX)
);
GO
drop TABLE bank.Mailinfo
CREATE TABLE bank.Maillnfo (
    MailTo VARCHAR(100),
    MailDate DATE,
    MailMessage VARCHAR(200)
)

-- Create the trgMailToCust trigger
-- Create the trgMailToCust trigger
CREATE TRIGGER trgMaillToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    INSERT INTO bank.Maillnfo (MailTo, MailDate, MailMessage)
    SELECT i.CEmail, GETDATE(), 'Your net banking password is: ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
    FROM inserted i;
END;


select * from bank.Customer
select * from bank.Maillnfo