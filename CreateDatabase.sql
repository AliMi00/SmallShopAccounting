USE master;

-- Drop database
IF DB_ID('Acounting') IS NOT NULL DROP DATABASE Acounting;

-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR('Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE Acounting;
GO

USE Acounting;
GO



CREATE SCHEMA HR AUTHORIZATION dbo;
GO
CREATE SCHEMA Production AUTHORIZATION dbo;
GO
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO
CREATE SCHEMA Stats AUTHORIZATION dbo;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

-- Create table HR.Employees
CREATE TABLE HR.Employees
(
  EmpId           INT          NOT NULL IDENTITY,
  Company		  NVARCHAR(50) NOT NULL,
  LastName        NVARCHAR(20) NOT NULL,
  FirstName       NVARCHAR(10) NOT NULL,
  Title           NVARCHAR(30) NOT NULL,
  titleofcourtesy NVARCHAR(25)  NULL,
  birthdate       DATETIME      NULL,
  HireDate        DATETIME     NOT NULL,
  address         NVARCHAR(60)  NULL,
  city            NVARCHAR(15)  NULL,
  region          NVARCHAR(15) NULL,
  postalcode      NVARCHAR(10) NULL,
  country         NVARCHAR(15)  NULL,
  phone           NVARCHAR(24)  NULL,
  mgrid           INT          NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid),
  CONSTRAINT FK_Employees_Employees FOREIGN KEY(mgrid)
    REFERENCES HR.Employees(empid),
  CONSTRAINT CHK_birthdate CHECK(birthdate <= CURRENT_TIMESTAMP)
);

CREATE NONCLUSTERED INDEX idx_nc_lastname   ON HR.Employees(lastname);
CREATE NONCLUSTERED INDEX idx_nc_postalcode ON HR.Employees(postalcode);

-- Create table Production.Suppliers
CREATE TABLE Production.Suppliers
(
  SupplierId   INT          NOT NULL IDENTITY,
  Companyname  NVARCHAR(40) NOT NULL,
  contactname  NVARCHAR(30)  NULL,
  contacttitle NVARCHAR(30)  NULL,
  address      NVARCHAR(60)  NULL,
  city         NVARCHAR(15)  NULL,
  region       NVARCHAR(15) NULL,
  postalcode   NVARCHAR(10) NULL,
  country      NVARCHAR(15)  NULL,
  Phone        NVARCHAR(24) NOT NULL,
  fax          NVARCHAR(24) NULL,
  CONSTRAINT PK_Suppliers PRIMARY KEY(supplierid)
);

CREATE NONCLUSTERED INDEX idx_nc_companyname ON Production.Suppliers(companyname);
CREATE NONCLUSTERED INDEX idx_nc_postalcode  ON Production.Suppliers(postalcode);

-- Create table Production.Categories
CREATE TABLE Production.Categories
(
  CategoryId   INT           NOT NULL IDENTITY,
  CategoryName NVARCHAR(15)  NOT NULL,
  description  NVARCHAR(200) NOT NULL,
  CONSTRAINT PK_Categories PRIMARY KEY(categoryid)
);

CREATE INDEX categoryname ON Production.Categories(categoryname);

-- Create table Production.Products
CREATE TABLE Production.Products
(
  ProductId    INT          NOT NULL IDENTITY,
  ProuductCode  INT          NOT NULL,
  ProductName  NVARCHAR(40) NOT NULL,
  SupplierId   INT          NOT NULL,
  CategoryId   INT          NOT NULL,
  UnitPriceSales    INT        NOT NULL
    CONSTRAINT DFT_Products_unitprice DEFAULT(0),
  UnitPriceBuy    INT        NOT NULL
    CONSTRAINT DFT_Products_unitpriceBuy DEFAULT(0),
  Discount float          NOT NULL 
    CONSTRAINT DFT_Products_discontinued DEFAULT(0),
  Qty int not null default(1),
  Tax float not null default(0),
  CONSTRAINT PK_Products PRIMARY KEY(productid),
  CONSTRAINT FK_Products_Categories FOREIGN KEY(categoryid)
    REFERENCES Production.Categories(categoryid),
  CONSTRAINT FK_Products_Suppliers FOREIGN KEY(supplierid)
    REFERENCES Production.Suppliers(supplierid),
  CONSTRAINT CHK_Products_unitprice CHECK(unitpriceBuy >= 0)
);

CREATE NONCLUSTERED INDEX idx_nc_categoryid  ON Production.Products(categoryid);
CREATE NONCLUSTERED INDEX idx_nc_productname ON Production.Products(productname);
CREATE NONCLUSTERED INDEX idx_nc_supplierid  ON Production.Products(supplierid);

-- Create table Sales.Customers
CREATE TABLE Sales.Customers
(
  CustId       INT          NOT NULL IDENTITY,
  CompanyName  NVARCHAR(40) NOT NULL,
  contactname  NVARCHAR(30)  NULL,
  contacttitle NVARCHAR(30)  NULL,
  address      NVARCHAR(60)  NULL,
  city         NVARCHAR(15)  NULL,
  region       NVARCHAR(15) NULL,
  PostCode   NVARCHAR(10) NULL,
  country      NVARCHAR(15)  NULL,
  Phone        NVARCHAR(24)  NULL,
  fax          NVARCHAR(24) NULL,
  CONSTRAINT PK_Customers PRIMARY KEY(custid)
);

CREATE NONCLUSTERED INDEX idx_nc_city        ON Sales.Customers(city);
CREATE NONCLUSTERED INDEX idx_nc_companyname ON Sales.Customers(companyname);
CREATE NONCLUSTERED INDEX idx_nc_postalcode  ON Sales.Customers(PostCode);
CREATE NONCLUSTERED INDEX idx_nc_region      ON Sales.Customers(region);

-- Create table Sales.Shippers
--CREATE TABLE Sales.Shippers
--(
--  shipperid   INT          NOT NULL IDENTITY,
--  companyname NVARCHAR(40) NOT NULL,
--  phone       NVARCHAR(24) NOT NULL,
--  CONSTRAINT PK_Shippers PRIMARY KEY(shipperid)
--);

-- Create table Sales.Orders
CREATE TABLE Sales.Orders
(
  OrderId        INT          NOT NULL IDENTITY,
  CustId         INT          NULL,
  EmpId          INT          NOT NULL,
  OrderDate      DATETIME     NOT NULL,
  --requireddate   DATETIME      NULL,
  --shippeddate    DATETIME     NULL,
  --shipperid      INT           NULL,
  Profit        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_freight DEFAULT(0),
  AmountSell        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_comefreightcard DEFAULT(0),
  AmountBuy        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_comefreightcash DEFAULT(0),
  --shipname       NVARCHAR(40)  NULL,
  --shipaddress    NVARCHAR(60)  NULL,
  --shipcity       NVARCHAR(15)  NULL,
  --shipregion     NVARCHAR(15) NULL,
  --shippostalcode NVARCHAR(10) NULL,
  --shipcountry    NVARCHAR(15)  NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid),
  CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
    REFERENCES Sales.Customers(custid),
  CONSTRAINT FK_Orders_Employees FOREIGN KEY(empid)
    REFERENCES HR.Employees(empid),
  --CONSTRAINT FK_Orders_Shippers FOREIGN KEY(shipperid)
  --  REFERENCES Sales.Shippers(shipperid)
);

CREATE NONCLUSTERED INDEX idx_nc_custid         ON Sales.Orders(custid);
CREATE NONCLUSTERED INDEX idx_nc_empid          ON Sales.Orders(empid);
--CREATE NONCLUSTERED INDEX idx_nc_shipperid      ON Sales.Orders(shipperid);
CREATE NONCLUSTERED INDEX idx_nc_orderdate      ON Sales.Orders(orderdate);
--CREATE NONCLUSTERED INDEX idx_nc_shippeddate    ON Sales.Orders(shippeddate);
--CREATE NONCLUSTERED INDEX idx_nc_shippostalcode ON Sales.Orders(shippostalcode);

-- Create table Sales.OrderDetails
CREATE TABLE Sales.OrderDetails
(
  OrderId   INT           NOT NULL,
  ProductId INT           NOT NULL,
  UnitPriceSale MONEY         NOT NULL
    CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
  UnitPriceBuy MONEY         NOT NULL
    CONSTRAINT DFT_OrderDetails_unitpriceBuy DEFAULT(0),

  qty       SMALLINT      NOT NULL
    CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
  discount  float NOT NULL
    CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
	Tax float not null default(0)
  CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
  CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid)
    REFERENCES Sales.Orders(orderid),
  CONSTRAINT FK_OrderDetails_Products FOREIGN KEY(productid)
    REFERENCES Production.Products(productid),
  CONSTRAINT CHK_discount  CHECK (discount BETWEEN 0 AND 1),
  CONSTRAINT CHK_qty  CHECK (qty > 0),
  CONSTRAINT CHK_unitprice CHECK (UnitPriceSale >= 0)
);

CREATE NONCLUSTERED INDEX idx_nc_orderid   ON Sales.OrderDetails(orderid);
CREATE NONCLUSTERED INDEX idx_nc_productid ON Sales.OrderDetails(productid);

GO

/****** Object:  Table [HR].[Login]    Script Date: 7/8/2019 11:26:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [HR].[Login](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[empid] [int] NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE Acounting
GO

/****** Object:  StoredProcedure [dbo].[AddToEmpData]    Script Date: 7/8/2019 11:54:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE HR.loginSP
	-- Add the parameters for the stored procedure here
	@username nvarchar(32), 
	@password nvarchar(32) 


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	Select empid
		from HR.Login
	where username = @username and password = @password;

END
GO

--==================================================================


USE Acounting
GO

/****** Object:  StoredProcedure [dbo].[AddToEmpData]    Script Date: 7/8/2019 11:54:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE HR.GetEMP
	-- Add the parameters for the stored procedure here
	@username nvarchar(32)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select empid,company,firstname,lastname,title,hiredate
		from HR.Employees
		where empid = (Select top(1) empid
				from HR.Login
				where username = @username )

			

END
GO


USE Acounting
GO
/****** Object:  StoredProcedure [dbo].[PriceSet]    Script Date: 7/19/2019 11:46:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.getcustomers 
	-- Add the parameters for the stored procedure here
	



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		select * --cust.custid as CustId , cust.companyname,cust.postcode,cust.phone
		from Sales.Customers as cust
END

--------------
GO
/****** Object:  StoredProcedure [dbo].[PriceSet]    Script Date: 7/19/2019 11:46:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.getcustomersbyid 
	-- Add the parameters for the stored procedure here
	
	@custid int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		select * --cust.custid as CustId , cust.companyname,cust.postcode,cust.phone
		from Sales.Customers as cust
		where cust.CustId = @custid
END
--------------------




GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Sales].[setcustomer] 
	-- Add the parameters for the stored procedure here
	
	@name nvarchar(50),
	@phone nvarchar(26)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	insert into Sales.Customers(companyname,phone)
	values (@name,@phone)
END




GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE Production.setproduct 
	-- Add the parameters for the stored procedure here
	@code int,
	@name nvarchar(50),
	@supli int,
	@category int,
	@unitpricesale money,
	@unitpricebuy money,
	@discount float,
	@tax float,
	@qty int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	insert into Production.Products(ProuductCode,productname,supplierid,categoryid ,UnitPriceSales,UnitPriceBuy,Discount,Tax ,Qty)
	values (@code,@name,@supli,@category,@unitpricesale,@unitpricebuy,@discount,@tax,@qty)
END



GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE Production.getproduct 
	-- Add the parameters for the stored procedure here
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select * 
	from Production.Products 
END


GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.setorderdetails 
	-- Add the parameters for the stored procedure here
	
	@orderid int,
	@productid int,
	@unitpricesales money,
	@unitpricebuy money,
	@discount float,
	@qty int,
	@tax float

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	insert into Sales.OrderDetails(OrderId,ProductId,UnitPriceSale,UnitPriceBuy,discount,qty,Tax)
	values (@orderid,@productid,@unitpricesales,@unitpricebuy,@discount,@qty,@tax)

END


GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.setorder 
	-- Add the parameters for the stored procedure here
	
	@custid int,
	@empid int,
	@amountsell money,
	@amountbuy money,
	@profit money,
	@orderDate datetime

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	insert into Sales.Orders(CustId,EmpId,OrderDate,Profit,AmountSell,AmountBuy)
	values (@custid,@empid,@orderDate,@profit,@amountsell,@amountbuy)

	declare @orderid as int;

	select * 
	from Sales.Orders as orders
	where orders.OrderId = @orderid

commit tran;

END


GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.deleteorder 
	-- Add the parameters for the stored procedure here
	
	@orderid int

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	delete 
	from Sales.Orders 
	where Sales.Orders.OrderId = @orderid
	
	delete 
	from Sales.OrderDetails
	where Sales.OrderDetails.OrderId = @orderid

commit tran;

END



GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.getorder 
	-- Add the parameters for the stored procedure here
	
	@orderid int

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	select * 
	from Orders 
	where Orders.OrderId = @orderid

commit tran;

END


GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE sales.getorderbytime 
	-- Add the parameters for the stored procedure here
	
	@time1 datetime,
	@time2 datetime

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	select * 
	from Orders 
	where Orders.OrderDate between @time1 and @time2

commit tran;

END




GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/20/2019 12:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE Production.decreaseproduct 
	-- Add the parameters for the stored procedure here
	@productId int,
	@qty int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	UPDATE Production.Products 
	SET Qty -= @qty 
	WHERE productid = @productId;

END
