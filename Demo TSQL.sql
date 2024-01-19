----- T-SQL
DECLARE @COUNTER INT = 1;

SET @COUNTER = @COUNTER + 1;

PRINT @COUNTER;
SELECT @COUNTER

DECLARE @NumberOfCustomers INT;
SELECT @NumberOfCustomers = COUNT(*) FROM Customers
PRINT @NumberOfCustomers

DECLARE @CustomerID VARCHAR(10)
SELECT @CustomerID = CustomerID FROM Customers
PRINT @CustomerID

----- INSTRUCTIONS
CREATE Table Stupid(id INT PRIMARY KEY, name VARCHAR(150));

DECLARE @INDEX INT = 1;
WHILE @INDEX <= 1000
BEGIN
	IF @INDEX % 2 = 0
	BEGIN
		INSERT INTO Stupid(id,name) VALUES(@INDEX, 'Stupid' + CAST(@INDEX as varchar(10)));
	END
	SET @INDEX = @INDEX + 1
END

SELECT * FROM Stupid
TRUNCATE TABLE Stupid

DECLARE @Stupid_id INT
DECLARE @Stupid_name VARCHAR(150)

DECLARE cursor_stupid CURSOR FOR SELECT id,name FROM Stupid
OPEN cursor_stupid
FETCH NEXT FROM cursor_stupid INTO @Stupid_id,@Stupid_name
WHILE @@FETCH_STATUS = 0
BEGIN
	--processing
	DECLARE @Test VARCHAR(150) = CAST(@Stupid_id as VARCHAR(10)) + ' '+@Stupid_name;
	PRINT @Test;

	FETCH NEXT FROM cursor_stupid INTO @Stupid_id,@Stupid_name
END
CLOSE cursor_stupid
DEALLOCATE cursor_stupid

-- STORE PROCEDURE ---
ALTER PROCEDURE sp_countStupid
	@Count_in INT,
	@Count_out INT OUTPUT
AS
BEGIN
	SELECT @Count_in = COUNT(*) FROM Stupid;
	SELECT @Count_out = COUNT(*) FROM Stupid;
	RETURN 1;
END

DECLARE @Count_in_call INT = 5;
DECLARE @Count_out_call INT = 5;

DECLARE @return_value INT;

EXEC @return_value = sp_countStupid @Count_in = @Count_in_call,
					@Count_out = @Count_out_call OUTPUT;

SELECT @Count_in_call,@Count_out_call
PRINT @return_value

CREATE PROC ex1 @countryId VARCHAR(10), @count INT OUTPUT
AS
BEGIN
	SELECT @numberOfProducts = COUNT(DISTINCT ProductID) FROM Product
	WHERE ModelID = @modelID
END
