--1
ALTER PROCEDURE [dbo].[wypisz] (@n INT)
AS
BEGIN
	
	IF @n < 0
		RAISERROR ('Negative values not allowed!', 18, 1)
	ELSE
	SELECT * FROM dbo.[fibonacci](@n);
	
	
END;