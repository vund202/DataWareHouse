
--StageDate
SELECT DISTINCT
	   CONVERT(varchar(8), Date, 112) AS Datekey,
       Date AS FullDate,
       DATEPART(WEEKDAY, Date) AS DayNumberOfWeek,
       DATENAME(WEEKDAY, Date) AS DayNameOfWeek,
       DAY(Date) AS DayNumberOfMonth,
       DATEPART(DAYOFYEAR, Date) AS DayNumberOfYear,
       DATEPART(WEEK, Date) AS WeekNumberOfYear,
       DATENAME(MONTH, Date) AS MonthName,
       MONTH(Date) AS MonthNumberOfYear,
       DATEPART(QUARTER, Date) AS CalendarQuarter,
       YEAR(Date) AS CalendarYear
INTO [dbo].[StageDate]
FROM [E-Commerce].[dbo].[AmazonSaleReport];
--StageProduct
SELECT SKU_Code as SKU, Design_no as CategoryID , Size,Color
INTO [dbo].[StageProduct]
FROM [E-Commerce].[dbo].[StockReport];
--StageCategory
SELECT Distinct Category as CategoryName,Design_no as CategoryID
INTO [dbo].[StageCategory]
FROM [E-Commerce].[dbo].[StockReport];
--StageGeography
SELECT DISTINCT ship_city AS City, ship_state AS State, ship_postal_code AS PostalCode, ship_country AS Country
INTO [dbo].[StageGeography]
FROM [E-Commerce].[dbo].[AmazonSaleReport];
--FactSales
SELECT Qty AS Quantity, Amount, SKU, [Date], ship_postal_code, Style AS CategoryID
INTO [dbo].[FactSales]
FROM [E-Commerce].[dbo].[AmazonSaleReport] 
WHERE Status NOT LIKE 'Cancelled';


--FactProductInventory
SELECT Stock AS Quantity, Design_No AS CategoryID, Category AS Name,SKU_Code as SKU
INTO [dbo].[FactProductInventory]
FROM [E-Commerce].[dbo].[StockReport]
