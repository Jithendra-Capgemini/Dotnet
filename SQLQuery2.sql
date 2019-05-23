use sqlpractice 
GO
--Table for Storing Book Details

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='Books')
DROP TABLE Books 
GO

create table Books
(
	ID int primary key,
	Name varchar(100) not null,
	Price money not null,
	Description varchar(200) not null,
)
go

INSERT INTO BOOKS VALUES(1,'Let US C',643,'Yashwanth'),
(2,'Java2 Complete',8883,'Simon'),
(3,'Dotnet BlackBook',8821,'BPB'),
(4,'Angular 6',4211,'CorePub')
GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='usp_InsertBook')
DROP PROC usp_InsertBook 
GO

--Stored Procedure for inserting data
create proc usp_InsertBook(@id int,@name varchar(100),@price money,@desc varchar(200))
as
Begin 
insert into Books values(@id,@name,@price,@desc)
end
go

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='usp_UpdateBook')
DROP PROC usp_UpdateBook 
GO
--Stored Procedure for updating data
create proc usp_UpdateBook(@id int,@name varchar(100),@price money,@desc varchar(200))
as
begin 
update Books
set Name=@name,Price=@price,Description=@desc
where ID=@id
end
go

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='usp_DeleteBook')
DROP PROC usp_DeleteBook 
GO
--stored procedure for deleteing data
create proc usp_DeleteBook(@id int)
as
begin 
delete from Books
where ID=@id
end
go

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='usp_ShowBook')
DROP PROC usp_ShowBook 
GO
--stored procedure for displaying all record
create proc usp_ShowBook
as
begin
select * from Books
end
go

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='usp_SearchBook')
DROP PROC usp_SearchBook 
GO
--stored procedure for searching data
create proc usp_SearchBook(@id int)
as
begin 
select * from Books where ID=@id
end
go