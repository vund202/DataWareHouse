INSERT INTO [E-CommerceDW].dbo.DimDate (Datekey, FullDate, DayNumberOfWeek, 
DayNameOfWeek, DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear, MonthName, MonthNumberOfYear, CalendarQuarter, CalendarYear)
SELECT  Datekey,
        FullDate,
        DayNumberOfWeek,
        DayNameOfWeek,
        DayNumberOfMonth,
        DayNumberOfYear,
        WeekNumberOfYear,
        MonthName,
        MonthNumberOfYear,
        CalendarQuarter,
        CalendarYear
FROM [E-CommerceStage].dbo.StageDate;
--Load Product
INSERT INTO [E-CommerceDW].dbo.DimProduct(SKU,Size,Color,CategoryID)
SELECT  SKU , Size,Color, CategoryID
From [E-CommerceStage].dbo.StageProduct;

--Load Category
INSERT INTO [E-CommerceDW].dbo.DimCategory(CategoryName,CategoryID)
SELECT CategoryName,CategoryID
from [E-CommerceStage].dbo.StageCategory
--Load Geography
INSERT INTO [E-CommerceDW].dbo.DimGeoGraphy(City,State,PostalCode,Country)
SELECT Distinct City,State,PostalCode,Country
FROM [E-CommerceStage].dbo.StageGeography

--Load FactSales
INSERT INTO [E-CommerceDW].dbo.FactSales (DateKey, ProductKey,GeographyKey,SKU, Quantity, SaleAmount)
SELECT CONVERT(varchar(8), s.Date, 112) AS Datekey, p.ProductKey,g.GeographyKey,s.SKU, s.Quantity, s.Amount
FROM [E-CommerceStage].dbo.FactSales s
INNER JOIN [E-CommerceDW].dbo.DimProduct p ON s.SKU=p.SKU
INNER JOIN [E-CommerceDW].dbo.DimGeoGraphy g on g.PostalCode=s.ship_postal_code



--Load FactProductInventory
INSERT INTO [E-CommerceDW].dbo.FactProductInventory (CategoryKey,ProductKey,SKU, CategoryID, Quantity, CategoryName)
SELECT  c.CategoryKey,p.ProductKey,i.SKU ,i.CategoryID, i.Quantity, i.Name
FROM [E-CommerceStage].dbo.FactProductInventory i
INNER JOIN [E-CommerceDW].dbo.DimCategory c ON c.CategoryID = i.CategoryID
INNER JOIN [E-CommerceDW].dbo.DimProduct p ON p.SKU=i.SKU