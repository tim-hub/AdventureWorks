select p.subCategoryName, sum(quantity) as qty, sum(profit) as pro
from factSales as s, dimProduct as p, dimTime as t
where p.ProductKey = s.ProductKey and t.Date < '2013-12-31' 
	and t.Date> '2013-1-1' 
	and t.TimeKey = s.OrderTimeKey

group by p.subCategoryName