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

