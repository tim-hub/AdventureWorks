/*
MS SQL Script for Creating dimTime dimension table
Time range	: 2011 - 2014
For OLTP	: adventure works
Output table: dimTime

create time dimension
*/



print '***************************************************************'
print '****** Dropping tables if exist'
print '***************************************************************'

print 'Drop all DW tables (except dimTime)'

if exists (select * from sys.tables where name='factSales')
	drop table factSales;
go
if exists (select * from sys.tables where name='dimProduct')
	drop table dimProduct;
go
if exists (select * from sys.tables where name='dimCustomer')
	drop table dimCustomer;
go
if exists (select * from sys.tables where name='dimEmployee')
	drop table dimEmployee;
go
if exists (select * from sys.tables where name='dimStore')
	drop table dimStore;
go
if exists (select * from sys.tables where name='dimCategory')
	drop table dimCategory;
go
if exists (select * from sys.tables where name='dimAddress')
	drop table dimAddress;
go

if exists (select * from sys.tables where name='dimTime')
	drop table dimTime;
go

if exists (select * from sys.tables where name='Numbers_Small')
	drop table Numbers_Small;
go

if exists (select * from sys.tables where name='Numbers_Big')
	drop table Numbers_Big;
go

CREATE TABLE Numbers_Small (Number INT);
INSERT INTO Numbers_Small VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE Numbers_Big (Number_Big BIGINT);
INSERT INTO Numbers_Big ( Number_Big )
SELECT thousands.number * 1000 + hundreds.number * 100 + tens.number * 10 + ones.number as number_big
FROM numbers_small thousands, numbers_small hundreds, numbers_small tens, numbers_small ones;

CREATE TABLE dimTime(
[TimeKey] [int] NOT NULL PRIMARY KEY,
[Date] [datetime] NULL,
[Day] [char](10) NULL,
[DayOfWeek] [smallint] NULL,
[DayOfMonth] [smallint] NULL,
[DayOfYear] [smallint] NULL,
[WeekOfYear] [smallint] NULL,
[Month] [char](10) NULL,
[MonthOfYear] [smallint] NULL,
[QuarterOfYear] [smallint] NULL,
[Year] [int] NULL
);
INSERT INTO dimTime(TimeKey, Date) values(-1,'9999-12-31'); -- Create dummy for a "null" date/time
INSERT INTO dimTime (TimeKey, Date)
SELECT number_big, DATEADD(day, number_big,  '2011-01-01') as Date
FROM numbers_big
WHERE DATEADD(day, number_big,  '2011-01-01') BETWEEN '2011-01-01' AND '2014-12-31'
ORDER BY number_big;

/*
INSERT INTO dimTime (TimeKey, Date)
SELECT CONVERT(INT, CONVERT(CHAR(10),DATEADD(day, number_big,  '1996-01-01'), 112)) as DateKey,
CONVERT(DATE,DATEADD(day, number_big,  '1996-01-01')) as Date
FROM numbers_big
WHERE DATEADD(day, number_big,  '1996-01-01') BETWEEN '1996-01-01' AND '1998-12-31'
ORDER BY 1;
*/

UPDATE dimTime
SET Day = DATENAME(DW, Date),
DayOfWeek = DATEPART(WEEKDAY, Date),
DayOfMonth = DAY(Date),
DayOfYear = DATEPART(DY,Date),
WeekOfYear = DATEPART(WK,Date),
Month = DATENAME(MONTH,Date),
MonthOfYear = MONTH(Date),
QuarterOfYear = DATEPART(Q, Date),
Year = YEAR(Date);
drop table Numbers_Small;
drop table Numbers_Big;

Go

-- create other dimension

print 'Creating all dimension tables required'
--Add statements below...


--dimCategory table
--CREATE TABLE dimCategory
--(
--	CategoryKey			int				IDENTITY(1,1) PRIMARY KEY,
--	categoryID			int       NOT NULL DEFAULT -1,
--	name			nchar(50)       NOT NULL DEFAULT '',
--);

-- --dimProduct table
CREATE TABLE dimProduct
(
	ProductKey			int				IDENTITY(1,1) PRIMARY KEY,
--	CategoryKey			int       FOREIGN KEY REFERENCES dimCategory(CategoryKey),
	productID			  int       NOT NULL DEFAULT -1,
  subCategoryName	  nchar(50)         NOT NULL DEFAULT '',
);


CREATE TABLE dimEmployee
(
	EmployeeKey			int				IDENTITY(1,1) PRIMARY KEY,
	employeeID			int       NOT NULL DEFAULT -1,
  name			nchar(152)       NOT NULL DEFAULT '',
  personType			nchar(2)       NOT NULL DEFAULT '',
  jobTitle			  nchar(50)       NOT NULL DEFAULT '',
  hireDate			  date       NOT NULL DEFAULT '9999-12-31',
  -- bonus           money       NOT NULL DEFAULT 0,
);


-- CREATE TABLE dimAddress
-- (
-- 	AddressKey			int				IDENTITY(1,1) PRIMARY KEY,
-- 	addressID			int       NOT NULL DEFAULT -1,
--   addressLine1			nchar(60)       NOT NULL DEFAULT '',
--   city			  nchar(30)       NOT NULL DEFAULT '',
--   postcode			  nchar(15)       NOT NULL DEFAULT '',
--   stateProvince			  nchar(50)       NOT NULL DEFAULT '',
--   country			  nchar(50)       NOT NULL DEFAULT '',
-- );

CREATE TABLE dimCustomer
(
	CustomerKey			int				IDENTITY(1,1) PRIMARY KEY,
  -- AddressKey			int       FOREIGN KEY REFERENCES dimAddress(AddressKey),
	customerID			int       NOT NULL DEFAULT -1,
  title			nchar(8)       NOT NULL DEFAULT '',
  name			nchar(152)       NOT NULL DEFAULT '',
  email_address			nchar(50)       NOT NULL DEFAULT '',
  phone_number			nchar(25)       NOT NULL DEFAULT '',
);

CREATE TABLE dimStore
(
	StoreKey			int				IDENTITY(1,1) PRIMARY KEY,
  -- AddressKey			int       FOREIGN KEY REFERENCES dimAddress(AddressKey),
	businessEntityID			int       NOT NULL DEFAULT -1,
  name			nchar(50)       NOT NULL DEFAULT '',
);

print 'Creating a fact table required'

CREATE TABLE factSales
(

	CustomerKey			int				FOREIGN KEY REFERENCES dimCustomer(CustomerKey),
	StoreKey		    int				FOREIGN KEY REFERENCES dimStore(StoreKey),
	EmployeeKey		  int				FOREIGN KEY REFERENCES dimEmployee(EmployeeKey),
	OrderTimeKey		int				FOREIGN KEY REFERENCES dimTime(TimeKey),
	ProductKey			int				FOREIGN KEY REFERENCES dimProduct(ProductKey),

	quantity				smallint  NOT NULL DEFAULT 0 CHECK (quantity >= 0),
	-- discountPct			smallmoney    NOT NULL DEFAULT 0 CHECK (discountPct >= 0),
	-- onlineOrderflag			bit     NOT NULL DEFAULT 1,
	profit			    money NOT NULL DEFAULT 0,
  PRIMARY KEY (CustomerKey, StoreKey, EmployeeKey, OrderTimeKey, ProductKey),
);

