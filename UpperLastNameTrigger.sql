--2
--USE AdventureWorks2017 
CREATE TRIGGER UpperCase
ON Person.Person
AFTER INSERT, UPDATE
AS
	--UPDATE Person.Person SET LastName = UPPER (LastName)
	SELECT UPPER(LastName) AS 'LastName'
	FROM Person.Person
GO

UPDATE Person.Person SET FirstName = 'KEN' WHERE BusinessEntityID = 1
SELECT * FROM Person.Person


INSERT INTO Person.BusinessEntity (rowguid) VALUES (newid())
SELECT * FROM Person.BusinessEntity
INSERT INTO Person.Person (BusinessEntityID,FirstName,MiddleName,LastName,PersonType) VALUES (20778, 'Mateusz', NULL, 'Zygmunt', 'IN')
SELECT * FROM Person.Person
