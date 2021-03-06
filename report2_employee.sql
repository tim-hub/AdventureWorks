
select dimEmployee.name, dimEmployee.employeeID, dimEmployee.jobTitle, dimEmployee.personType, e.pro, e.qty
from dimEmployee, 
	(select s.EmployeeKey, sum(quantity) as qty, sum(profit) as pro
	from factSales as s, dimEmployee as e, dimTime as t
	where e.EmployeeKey = s.EmployeeKey
		and t.Date < '2013-12-31' 
		and t.Date> '2013-1-1' 
		and t.TimeKey = s.OrderTimeKey
	group by s.EmployeeKey)  as e
where dimEmployee.EmployeeKey = e.EmployeeKey