--1
ALTER FUNCTION [dbo].[fibonacci] ( @n INT)
RETURNS @FibTab TABLE (Wyraz_ci¹gu INT, Wartoœæ_wyrazu_ci¹gu NUMERIC)
AS
BEGIN

	DECLARE @fib INT

	IF @n <= 2
		IF @n <= 1
			INSERT INTO @FibTab VALUES(1, 0)
		ELSE
			INSERT INTO @FibTab VALUES(1, 0), (2,0)

	ELSE
		
		DECLARE @i INT = 0; --licznik
		DECLARE @f1 NUMERIC  = 0; --wartoœæ I el.
		DECLARE @f2 NUMERIC  = 1; --wartoœæ II el.
		DECLARE @temp NUMERIC

		WHILE @i <= @n
		BEGIN
			IF @i <= 1
			BEGIN
				IF @i = 0
					INSERT INTO @FibTab VALUES (@i, 0);
				ELSE IF @i = 1
					INSERT INTO @FibTab VALUES (@i,1);
			END; --if

			ELSE
			BEGIN
				SET @temp = @f1 + @f2;
				SET @f1 = @f2
				SET @f2 = @temp
				--I obieg: temp =0+1 = 1; f1 = f2 = 1; f2 = temp = 1
				--II obieg: temp = 1+1 = 2; f1 = f2 = 1; f2 = temp = 2
				--III obieg: temp = 1+2 = 3; f1 = f2 = 2; f2 = temp = 3
				INSERT INTO @FibTab values(@i, @temp);
			END;
			SET @i = @i+1;
		END;
	RETURN;
END;


