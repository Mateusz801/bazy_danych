--1
WITH CteEmployeeInfo (BusinessEntityID, FirtName, MiddleName, LastName, rowguid, Rate, ModDate )
AS
(
	SELECT per.BusinessEntityID, per.FirstName, per. MiddleName, per.LastName, per.rowguid, eph.Rate, eph.ModifiedDate FROM Person.Person per
	INNER JOIN HumanResources.EmployeePayHistory eph
	ON per.BusinessEntityID = eph.BusinessEntityID
)
SELECT * INTO TempEmployeeInfo FROM CteEmployeeInfo

SELECT * FROM TempEmployeeInfo
ORDER BY BusinessEntityID
--2
WITH CompContactRev (CompanyContact, Revenue)
AS
(
	SELECT  CONCAT (C.CompanyName, ' (', C.FirstName, ' ', C.LastName, ')'), SUM(SOH.TotalDue) FROM SalesLT.Customer C 
	INNER JOIN SalesLT.SalesOrderHeader SOH
	ON C.CustomerID = SOH.CustomerID
	GROUP BY C.CompanyName, C.FirstName, C.LastName
)
SELECT * FROM CompContactRev

--3
WITH CatSaleValue (Category, SalesValue)
AS
(
	SELECT PC.Name, SUM(SOD.LineTotal) FROM SalesLT.ProductCategory PC
	INNER JOIN SalesLT.Product P
	ON PC.ProductCategoryID = P.ProductCategoryID
	INNER JOIN SalesLT.SalesOrderDetail SOD
	ON P.ProductID = SOD.ProductID
	GROUP BY PC.Name
)
SELECT * FROM CatSaleValue