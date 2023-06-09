USE master
GO

USE restaurantManagement
GO


CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000)
AS
BEGIN
	IF @strInput IS NULL RETURN @strInput
	IF @strInput = '' RETURN @strInput

	DECLARE @RT NVARCHAR(4000)
	DECLARE @SIGN_CHARS NCHAR(136)
	DECLARE @UNSIGN_CHARS NCHAR (136)

	SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272)+ NCHAR(208)
	SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
	
	DECLARE @COUNTER int
	DECLARE @COUNTER1 int
	SET @COUNTER = 1

	WHILE (@COUNTER <= LEN(@strInput))
	BEGIN
		SET @COUNTER1 = 1
		WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
			BEGIN
				IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
				BEGIN
					IF @COUNTER=1
						SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)
					ELSE
						SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)
					BREAK
				END
					SET @COUNTER1 = @COUNTER1 +1
			END
			SET @COUNTER = @COUNTER +1
	END
	SET @strInput = replace(@strInput,' ','-')
	RETURN @strInput
END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [varchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Password] [varchar](500) NOT NULL,
	[TypeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CheckIn] [date] NOT NULL,
	[CheckOut] [date] NULL,
	[TableID] [int] NOT NULL,
	[Discount] [int] NOT NULL,
	[TotalPrice] [int] NULL,
	[Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BillID] [int] NOT NULL,
	[FoodID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFood](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Name') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [CheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[CategoryFood] ADD  DEFAULT (N'Chưa đặt tên') FOR [Name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [Name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Table] ADD  DEFAULT (N'Chưa đặt tên') FOR [Name]
GO
ALTER TABLE [dbo].[Table] ADD  DEFAULT (N'Trống') FOR [Status]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([TypeID])
REFERENCES [dbo].[AccountType] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([TableID])
REFERENCES [dbo].[Table] ([ID])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([ID])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([FoodID])
REFERENCES [dbo].[Food] ([ID])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CategoryFood] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[GetUnCheckBillIDByTableID]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetUnCheckBillIDByTableID]
@TableID INT
AS
	SELECT * FROM dbo.Bill WHERE TableID = @TableID AND Status = 0

GO
/****** Object:  StoredProcedure [dbo].[USP_CheckOut]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_CheckOut]
@ID INT, @Discount INT, @TotalPrice INT
AS
	UPDATE dbo.Bill SET Status = 1, Discount = @Discount, TotalPrice = @TotalPrice WHERE ID = @ID

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAccount]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_DeleteAccount]
@UserName VARCHAR(100)
AS
	DELETE dbo.Account WHERE UserName = @UserName

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteBill]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_DeleteBill]
@ID INT
AS
	DELETE dbo.Bill WHERE ID = @ID

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteBillInfoByBillID]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_DeleteBillInfoByBillID]
@BillID INT
AS
	DELETE dbo.BillInfo WHERE BillID = @BillID

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteCategory]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[USP_DeleteCategory]
@ID int
as
begin
	declare @FoodCount int = 0
	select @FoodCount = COUNT(*) from Food where CategoryID = @ID

	if (@FoodCount = 0)
		delete CategoryFood where ID = @ID
end

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_DeleteFood]
@FoodID INT
AS
BEGIN
	DECLARE @BillIDCount INT = 0
	SELECT @BillIDCount = COUNT(*) FROM Bill AS b, BillInfo AS bi WHERE FoodID = @FoodID AND b.ID = bi.BillID AND b.Status = 0

	IF (@BillIDCount = 0)
	BEGIN
		DELETE BillInfo WHERE FoodID = @FoodID
		DELETE Food WHERE ID = @FoodID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteTableFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- TableFood's procedure
create proc [dbo].[USP_DeleteTableFood]
@ID int
as begin
	declare @count int = 0
	select @count = COUNT(*) from TableCoffee where ID = @ID and Status = N'Trống'

	if (@count <> 0)
	begin
		declare @BillID int
		select @BillID = b.ID from Bill as b, TableCoffee as t where b.TableID = t.ID

		delete BillInfo where BillID = @BillID
		delete Bill where ID = @BillID
		delete TableCoffee where ID = @ID
	end
end

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@UserName VARCHAR(100)
AS
	SELECT *
	FROM dbo.Account
	WHERE UserName = @UserName

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllAccount]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAllAccount]
AS
	SELECT UserName, DisplayName, TypeID FROM dbo.Account

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- end Account's procedure

-- Food's procedure
CREATE PROC [dbo].[USP_GetAllFood]
AS
	SELECT * FROM dbo.Food

GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAllTable]
AS
	SELECT ID, Name FROM dbo.TableCoffee

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDay]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDay]
@FromDate DATE, @ToDate DATE
AS
BEGIN
	SELECT b.ID, t.Name, CheckIn, discount, TotalPrice
	FROM Bill AS b, TableCoffee AS t
	WHERE CheckIn >= @FromDate AND CheckIn <= @ToDate AND b.status = 1 AND t.ID = b.TableID
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDayForReport]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[USP_GetListBillByDayForReport]
@FromDate Date, @ToDate Date
as
begin
	select t.Name, CheckIn, Discount, TotalPrice
	from Bill as b, TableCoffee as t
	where CheckIn >= @FromDate and CheckIn <= @ToDate and b.status = 1 and t.ID = b.TableID
end

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListFoodByCategoryID]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListFoodByCategoryID]
@CategoryID INT
AS
	SELECT ID, Name, Price FROM dbo.Food WHERE CategoryID = @CategoryID

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListTable]
AS
	SELECT * FROM dbo.TableCoffee

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListTempBillByTableID]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- end TableCoffee's procedure

CREATE PROC [dbo].[USP_GetListTempBillByTableID]
@TableID INT
AS
	SELECT f.Name, bi.Amount, f.Price, f.Price * bi.Amount AS totalPrice
	FROM dbo.BillInfo bi, dbo.Bill b, dbo.Food f
	WHERE b.ID = bi.BillID AND bi.FoodID = f.ID AND b.Status = 0 AND b.TableID = @TableID

GO
/****** Object:  StoredProcedure [dbo].[USP_GetMaxBillID]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetMaxBillID]
AS
	SELECT MAX(ID) FROM dbo.Bill

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertAccount]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertAccount]
@UserName VARCHAR(100), @DisplayName NVARCHAR(100), @TypeID INT
AS
	INSERT dbo.Account ( UserName, DisplayName, TypeID )
	VALUES  ( @UserName, @DisplayName, @TypeID )

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- end Food's procedure

-- Bill's procedure
CREATE PROC [dbo].[USP_InsertBill]
@TableID INT
AS
	INSERT dbo.Bill (CheckIn, TableID, status, discount) VALUES (GETDATE(), @TableID, 0, 0)

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- end Bill's procedure

-- Bill Info's procedure
CREATE PROC [dbo].[USP_InsertBillInfo]
@BillID int, @FoodID int, @Amount int
as
begin
	declare @isExistBillInfo int
	declare @foodAmount int = 1

	select @isExistBillInfo = ID, @foodAmount = Amount
	from BillInfo
	where BillID = @BillID and FoodID = @FoodID

	if (@isExistBillInfo > 0)
	begin
		declare @newAmount int = @foodAmount + @Amount
		if (@newAmount > 0)
			update BillInfo set Amount = @newAmount where FoodID = @FoodID
		ELSE IF (@newAmount <= 0)
			delete BillInfo where BillID = @BillID and FoodID = @FoodID
	end
	else
		IF (@Amount > 0)
			INSERT into BillInfo (BillID, FoodID, Amount) values (@BillID, @FoodID, @Amount)
end

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertFood]
@Name NVARCHAR(100), @CategoryID INT, @Price INT
AS
	INSERT dbo.Food( Name, CategoryID, Price )
	VALUES  ( @Name, @CategoryID, @Price )

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertTable]
@Name NVARCHAR(100)
AS
	INSERT dbo.TableCoffee ( Name )
	VALUES  ( @Name )

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Account's procedure
CREATE PROC [dbo].[USP_Login]
@UserName NVARCHAR(100), @Password NVARCHAR(100)
AS
	SELECT *
	FROM dbo.Account
	WHERE UserName = @UserName AND Password = @Password

GO
/****** Object:  StoredProcedure [dbo].[USP_MergeTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_MergeTable]
@TableID1 INT, @TableID2 INT
AS
	BEGIN
		DECLARE @UnCheckBillID1 INT = -1
		DECLARE @UnCheckBillID2 INT = -1
		SELECT @UnCheckBillID1 = ID FROM dbo.Bill WHERE TableID = @TableID1 AND Status = 0
		SELECT @UnCheckBillID2 = ID FROM dbo.Bill WHERE TableID = @TableID2 AND Status = 0

		IF (@UnCheckBillID1 != -1 AND @UnCheckBillID2 != -1)
			BEGIN
				DECLARE @BillInfoID INT
				SELECT @BillInfoID = ID FROM dbo.BillInfo WHERE BillID = @UnCheckBillID1

				UPDATE dbo.BillInfo SET BillID = @UnCheckBillID2 WHERE ID = @BillInfoID
				DELETE dbo.Bill WHERE ID = @UnCheckBillID1

				UPDATE dbo.TableCoffee SET STATUS = N'Trống' WHERE ID = @TableID1
			END
    END

GO
/****** Object:  StoredProcedure [dbo].[USP_ResetPassword]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_ResetPassword]
@UserName VARCHAR(100)
AS
	UPDATE dbo.Account SET Password = '0' WHERE UserName = @UserName

GO
/****** Object:  StoredProcedure [dbo].[USP_SearchAccountByUserName]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchAccountByUserName]
@UserName VARCHAR(100)
AS
	SELECT * FROM dbo.Account WHERE dbo.fuConvertToUnsign1(UserName) LIKE N'%' + dbo.fuConvertToUnsign1(@UserName) + '%'

GO
/****** Object:  StoredProcedure [dbo].[USP_SearchFoodByName]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchFoodByName]
@Name NVARCHAR(100)
AS
	SELECT * FROM dbo.Food WHERE dbo.fuConvertToUnsign1(Name) LIKE N'%' + dbo.fuConvertToUnsign1(@Name) + '%'

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SwitchTable]
@TableID1 INT, @TableID2 INT
AS
BEGIN
	DECLARE @isTable1Null INT = 0
	DECLARE @isTable2Null INT = 0
	SELECT @isTable1Null = ID FROM dbo.Bill WHERE TableID = @TableID1 AND Status = 0
	SELECT @isTable2Null = ID FROM dbo.Bill WHERE TableID = @TableID2 AND Status = 0

	IF (@isTable1Null = 0 AND @isTable2Null > 0)
		BEGIN
			UPDATE dbo.Bill SET TableID = @TableID1 WHERE ID = @isTable2Null
			UPDATE dbo.TableCoffee SET Status = N'Có người' WHERE ID = @TableID1
			UPDATE dbo.TableCoffee SET Status = N'Trống' WHERE ID = @TableID2
        END
	ELSE IF (@isTable1Null > 0 AND @isTable2Null = 0)
		BEGIN
			UPDATE dbo.Bill SET TableID = @TableID2 WHERE Status = 0 AND ID = @isTable1Null
			UPDATE dbo.TableCoffee SET Status = N'Có người' WHERE ID = @TableID2
			UPDATE dbo.TableCoffee SET Status = N'Trống' WHERE ID = @TableID1
        END
    ELSE IF (@isTable1Null > 0 AND @isTable2Null > 0)
		BEGIN
			UPDATE dbo.Bill SET TableID = @TableID2 WHERE ID = @isTable1Null
			UPDATE dbo.Bill SET TableID = @TableID1 WHERE ID = @isTable2Null
        END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccount]
@UserName VARCHAR(100), @DisplayName NVARCHAR(100), @Password VARCHAR(100), @NewPassword VARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	SELECT @isRightPass = COUNT(*) FROM Account WHERE UserName = @UserName and Password = @Password
	IF (@isRightPass = 1)
	BEGIN
		IF (@NewPassword = null or @NewPassword = '')
			UPDATE Account SET DisplayName = @DisplayName WHERE UserName = @UserName
		ELSE
			UPDATE Account SET DisplayName = @DisplayName, Password = @NewPassword WHERE UserName = @UserName
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateFood]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateFood]
@ID INT, @Name NVARCHAR(100), @CategoryID INT, @Price INT
AS
	DECLARE @BillIDCount INT = 0
	SELECT @BillIDCount = COUNT(*) FROM Bill AS b, BillInfo AS bi WHERE FoodID = @ID AND b.ID = bi.BillID AND b.Status = 0

	IF (@BillIDCount = 0)
		UPDATE dbo.Food SET Name = @Name, CategoryID = @CategoryID, Price = @Price WHERE ID = @ID

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateTable]    Script Date: 6/17/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateTable]
@ID INT, @Name NVARCHAR(100)
AS
	UPDATE dbo.TableCoffee SET Name = @Name WHERE ID = @ID

GO
USE [master]
GO
ALTER DATABASE [restaurantManagement] SET  READ_WRITE 
GO
