--3
CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE @NewTaxRate FLOAT, @TaxRate FLOAT;
	SELECT @NewTaxRate = TaxRate FROM INSERTED SalesTaxRate; --nowe albo zmienione rzêdy
	SELECT @TaxRate = TaxRate FROM DELETED; --kopie zmienionych rzêdów
	
	IF @NewTaxRate > 1.3*@TaxRate
		RAISERROR ('Tax rates increased over 30 percent!',
			18, --severity - 'powa¿noœæ', 0-10 - info. 11-18 - err, 19-25 - fatal err
			1) --state - pomaga znaleŸæ, w którym miejsu jest b³¹d
			
END;


UPDATE Sales.SalesTaxRate SET TaxRate = 1.5*TaxRate;
SELECT * FROM Sales.SalesTaxRate