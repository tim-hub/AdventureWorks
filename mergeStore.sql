/****** Script for SelectTopNRows command from SSMS  ******/

Merge into [dw2_dw].[dbo].[dimStore] dst
using(

	SELECT
      [businessEntityID]
      ,[name]
	FROM [dw2_dw].[dbo].[dimStore_1]
 ) as src
 on dst.businessEntityid = src.businessEntityid
when matched THEN
	update 
	set dst.businessEntityid = src.businessEntityid
when not matched then
	insert
	values(
      [businessEntityID]
      ,[name]);