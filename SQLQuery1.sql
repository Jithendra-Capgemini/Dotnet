
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='prcEmpShow')
DROP PROC PrcEmpShow 
GO

CREATE PROC prcEmpShow 
AS
BEGIN
	SELECT * FROM Emp 
END
GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='prcEmpSearch')
DROP PROC prcEmpSearch 
GO

CREATE PROC prcEmpSearch
					@empno INT 
AS
BEGIN
	SELECT * FROM Emp WHERE Empno=@empno
END
GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='prcEmpInsert')
DROP PROC prcEmpInsert 
GO

CREATE PROC prcEmpInsert 
					@empno INT,
					@name VARCHAR(30),
					@dept VARCHAR(30),
					@desig VARCHAR(30),
					@basic INT
AS
BEGIN
	INSERT INTO EMp VALUES(@empno,@name,@dept,@desig,@basic)
END
GO

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='prcEmpAutoGen')
DROP PROC prcEmpAutoGen 
GO

CREATE PROC prcEmpAutoGen 
AS
BEGIN
	SELECT MAX(Empno)+1 FROM EMP 
END


IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME='prcEmpUpdate')
DROP PROC prcEmpUpdate 
GO

CREATE PROC prcEmpUpdate
					@Empno INT,
					@Nam varchar(30),
					@Dept varchar(30),
					@Desig varchar(30),
					@Basic INT
AS
BEGIN 
	UPDATE EMP SET Nam=ISNULL(@Nam,Nam),

				   Dept=ISNULL(@Dept,Dept),

				   Desig=ISNULL(@Desig,Desig),

				   Basic=ISNULL(@Basic,Basic)

	WHERE EMPNO=@Empno 

END

SP_HELPTEXT prcStudentauto

CREATE PROC [dbo].[prcEmpOut] 
					@empno INT,
					@Nam VARCHAR(30) OUTPUT,
					@Dept VARCHAR(30) OUTPUT,
					@Desig VARCHAR(30) OUTPUT,
					@Basic INT OUTPUT
AS
BEGIN
	IF EXISTS(SELECT * FROM EMP WHERE Empno=@empno) 
	BEGIN
		 SELECT @Nam=Nam,@Dept=Dept,@Desig=Desig,@Basic=BASIC
		 FROM EMP WHERE EMPNO=@empno
		 RETURN 1
	END
	ELSE 
	BEGIN
		RETURN 0
	END 
END


CREATE PROC prcEmpOutCall
					@empno INT
AS 
BEGIN 
	 DECLARE 
		@Nam VARCHAR(30),
		@Dept VARCHAR(30),
		@Desig VARCHAR(30),
		@Basic INT,
		@res INT
	BEGIN
		EXEC @res=prcEmpOut @empno,@Nam OUTPUT,@Dept OUTPUT,@Desig OUTPUT,
		                                   @Basic OUTPUT
		IF @res=1
		BEGIN 
			PRINT 'Name '+@Nam
			PRINT 'Department '+@Dept
			PRINT 'Designation '+@Desig
			PRINT 'Basic '+ CONVERT(VARCHAR(10),@basic)
	    END
		ELSE 
		BEGIN 
			PRINT'Record not Found '
		END
	END
END