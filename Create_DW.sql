

print '***************************************************************'
print '****** Section 1: Creating DW Tables'
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
if exists (select * from sys.tables where name='dimEmpoyee')
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

print 'Creating all dimension tables required'
--Add statements below...


--dimCategory table
CREATE TABLE dimCategory
(
	CategoryKey			int				IDENTITY(1,1) PRIMARY KEY,
	categoryID			int       NOT NULL DEFAULT -1,
	name			nchar(50)       NOT NULL DEFAULT '',
);


-- CREATE TABLE dimCustomer
-- (
-- 	CustomerKey			int				IDENTITY(1,1) PRIMARY KEY,
-- 	CustomerID			nchar(5),
-- 	CompanyName			nvarchar(40),
-- 	ContactName			nvarchar(30),
-- 	ContactTitle		nvarchar(30),
-- 	Address				nvarchar(60),
-- 	City				nvarchar(15),
-- 	Region				nvarchar(15),
-- 	PostalCode			nvarchar(10),
-- 	Country				nvarchar(15),
-- 	Phone				nvarchar(24),
-- 	Fax					nvarchar(24)
-- );

-- --dimProducts table
-- CREATE TABLE dimProduct
-- (
-- 	ProductKey			int				IDENTITY(1,1) PRIMARY KEY,
-- 	ProductID			int,
-- 	ProductName			nvarchar(40),
-- 	QuantityPerUnit		nvarchar(20),
-- 	UnitPrice			money,
-- 	UnitsInStock		smallint,
-- 	UnitsOnOrder		smallint,
-- 	ReorderLevel		smallint,
-- 	Discontinued		bit,
-- 	CategoryName		nvarchar(15),
-- 	Description			ntext,
-- 	Picture				image
-- );

-- --dimSuppliers table
-- CREATE TABLE dimSupplier
-- (
-- 	SupplierKey			int				IDENTITY(1,1) PRIMARY KEY,
-- 	SupplierID			int,
-- 	CompanyName			nvarchar(40),
-- 	ContactName			nvarchar(30),
-- 	ContactTitle		nvarchar(30),
-- 	Address				nvarchar(60),
-- 	City				nvarchar(15),
-- 	Region				nvarchar(15),
-- 	PostalCode			nvarchar(10),
-- 	Country				nvarchar(15),
-- 	Phone				nvarchar(24),
-- 	Fax					nvarchar(24),
-- 	HomePage			ntext
-- );


-- print 'Creating a fact table required'
-- --Add statements below...
-- CREATE TABLE 		factSales
-- (
-- 	ProductKey			int				FOREIGN KEY REFERENCES dimProducts(ProductKey),
-- 	CustomerKey			int				FOREIGN KEY REFERENCES dimCustomers(CustomerKey),
-- 	SupplierKey			int				FOREIGN KEY REFERENCES dimSuppliers(SupplierKey),
-- 	OrderDateKey		int				FOREIGN KEY REFERENCES dimTime(TimeKey),
-- 	RequiredDateKey		int				FOREIGN KEY REFERENCES dimTime(TimeKey),
-- 	ShippedDateKey		int				FOREIGN KEY REFERENCES dimTime(TimeKey),
-- 	OrderID				int,
-- 	UnitPrice			money,
-- 	Quantity			smallint,
-- 	Discount			real,
-- 	TotalPrice			real,
-- 	ShipperCompanyName	nvarchar(40),
-- 	ShipperPhone		nvarchar(24),
-- 	PRIMARY KEY (ProductKey, CustomerKey, SupplierKey, OrderDateKey)
-- );

