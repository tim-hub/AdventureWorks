/****** Script for SelectTopNRows command from SSMS  ******/

Merge into [dw2_dw].[dbo].[dimCustomer] dst
using(

SELECT 
      [customerID]
      ,[title]
      ,[name]
      ,[email_address]
      ,[phone_number]
  FROM [dw2_dw].[dbo].[dimCustomer_1]
) as src
on dst.customerID = src.customerID
when matched THEN
	update 
	set dst.customerid = src.customerid
when not matched then
	insert
	values(
	[customerID]
      ,[title]
      ,[name]
      ,[email_address]
      ,[phone_number]);