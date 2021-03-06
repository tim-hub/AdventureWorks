GO  
-- Creates a partition function called myRangePF1 that will partition a table into four partitions  
CREATE PARTITION FUNCTION myRangePF1 (int)  
    AS RANGE LEFT FOR VALUES (50000) ;  
GO  
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above  
CREATE PARTITION SCHEME myRangePS1  
    AS PARTITION myRangePF1  
    TO ('PRIMARY', 'Vice') ;  
GO  

CREATE TABLE factSalesPartioned
(
	FactKey			int				IDENTITY(1,1) PRIMARY KEY,
	CustomerKey			int				FOREIGN KEY REFERENCES dimCustomer(CustomerKey),
	StoreKey		    int				FOREIGN KEY REFERENCES dimStore(StoreKey),
	EmployeeKey		  int				FOREIGN KEY REFERENCES dimEmployee(EmployeeKey),
	OrderTimeKey		int				FOREIGN KEY REFERENCES dimTime(TimeKey),
	ProductKey			int				FOREIGN KEY REFERENCES dimProduct(ProductKey),

	quantity				smallint  NOT NULL DEFAULT 0 CHECK (quantity >= 0),
	-- discountPct			smallmoney    NOT NULL DEFAULT 0 CHECK (discountPct >= 0),
	-- onlineOrderflag			bit     NOT NULL DEFAULT 1,
	profit			    money NOT NULL DEFAULT 0,
  -- PRIMARY KEY (CustomerKey, StoreKey, EmployeeKey, OrderTimeKey, ProductKey),
)ON myRangePS1 (FactKey) ;  