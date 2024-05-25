CREATE TABLE DimDate (
    Datekey int PRIMARY KEY,
    FullDate date,
    DayNumberOfWeek int,
    DayNameOfWeek nchar(20),
    DayNumberOfMonth tinyint,
	DayNumberOfYear smallint,
    WeekNumberOfYear tinyint,
    MonthName nchar(10),
    MonthNumberOfYear tinyint,
    CalendarQuarter tinyint,
    CalendarYear smallint,
);


Create Table DimProduct (
ProductKey int IDENTITY(1,1) Primary key,
SKU nvarchar(50),
Size nvarchar(50),
Color nvarchar(50),
CategoryID nvarchar(50),
);


Create table DimCategory(
CategoryKey int IDENTITY(1,1) Primary Key,
CategoryName nvarchar(50),
CategoryID nvarchar(50),
);


Create table DimGeoGraphy(
GeographyKey int IDENTITY(1,1) Primary Key,
City nvarchar(50),
State nvarchar(50),
PostalCode nvarchar(50),
Country nvarchar(50),
);

CREATE TABLE FactSales (
    DateKey int,
    ProductKey int,
    GeographyKey int,
	SKU nvarchar(50),
    Quantity int,
    SaleAmount float,
    FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey),
    FOREIGN KEY (ProductKey) REFERENCES DimProduct (ProductKey),
    FOREIGN KEY (GeographyKey) REFERENCES DimGeography (GeographyKey)
);

CREATE TABLE FactProductInventory (
    CategoryKey int,
	ProductKey int,
	SKU nvarchar(50),
    CategoryID nvarchar(50),
    Quantity int,
	CategoryName nvarchar(50),
    FOREIGN KEY (CategoryKey) REFERENCES DimCategory (CategoryKey),
	FOREIGN KEY (ProductKey) REFERENCES DimProduct (ProductKey),

);