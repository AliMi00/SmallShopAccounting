USE [master]
GO
/****** Object:  Database [Acounting]    Script Date: 7/31/2019 6:05:18 PM ******/
CREATE DATABASE [Acounting]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Acounting', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Acounting.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Acounting_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Acounting_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Acounting] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Acounting].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Acounting] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Acounting] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Acounting] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Acounting] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Acounting] SET ARITHABORT OFF 
GO
ALTER DATABASE [Acounting] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Acounting] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Acounting] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Acounting] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Acounting] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Acounting] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Acounting] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Acounting] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Acounting] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Acounting] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Acounting] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Acounting] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Acounting] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Acounting] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Acounting] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Acounting] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Acounting] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Acounting] SET RECOVERY FULL 
GO
ALTER DATABASE [Acounting] SET  MULTI_USER 
GO
ALTER DATABASE [Acounting] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Acounting] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Acounting] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Acounting] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Acounting] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Acounting] SET QUERY_STORE = OFF
GO
USE [Acounting]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Acounting]
GO
/****** Object:  Schema [HR]    Script Date: 7/31/2019 6:05:19 PM ******/
CREATE SCHEMA [HR]
GO
/****** Object:  Schema [Production]    Script Date: 7/31/2019 6:05:19 PM ******/
CREATE SCHEMA [Production]
GO
/****** Object:  Schema [Sales]    Script Date: 7/31/2019 6:05:19 PM ******/
CREATE SCHEMA [Sales]
GO
/****** Object:  Schema [Stats]    Script Date: 7/31/2019 6:05:19 PM ******/
CREATE SCHEMA [Stats]
GO
/****** Object:  Table [HR].[Employees]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HR].[Employees](
	[EmpId] [int] IDENTITY(1,1) NOT NULL,
	[Company] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NOT NULL,
	[titleofcourtesy] [nvarchar](25) NULL,
	[birthdate] [datetime] NULL,
	[HireDate] [datetime] NOT NULL,
	[address] [nvarchar](60) NULL,
	[city] [nvarchar](15) NULL,
	[region] [nvarchar](15) NULL,
	[postalcode] [nvarchar](10) NULL,
	[country] [nvarchar](15) NULL,
	[phone] [nvarchar](24) NULL,
	[mgrid] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HR].[Login]    Script Date: 7/31/2019 6:05:19 PM ******/
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
/****** Object:  Table [Production].[Categories]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Production].[Products]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProuductCode] [nvarchar](50) NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[UnitPriceSales] [int] NOT NULL,
	[UnitPriceBuy] [int] NOT NULL,
	[Discount] [float] NOT NULL,
	[Qty] [int] NOT NULL,
	[Tax] [float] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Production].[Suppliers]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Suppliers](
	[SupplierId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[contactname] [nvarchar](30) NULL,
	[contacttitle] [nvarchar](30) NULL,
	[address] [nvarchar](60) NULL,
	[city] [nvarchar](15) NULL,
	[region] [nvarchar](15) NULL,
	[postalcode] [nvarchar](10) NULL,
	[country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NOT NULL,
	[fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[Customers]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[Customers](
	[CustId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[contactname] [nvarchar](30) NULL,
	[contacttitle] [nvarchar](30) NULL,
	[address] [nvarchar](60) NULL,
	[city] [nvarchar](15) NULL,
	[region] [nvarchar](15) NULL,
	[PostCode] [nvarchar](10) NULL,
	[country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[OrderDetails]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[OrderDetails](
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[UnitPriceSale] [money] NOT NULL,
	[UnitPriceBuy] [money] NOT NULL,
	[qty] [smallint] NOT NULL,
	[discount] [numeric](4, 3) NOT NULL,
	[Tax] [float] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[Orders]    Script Date: 7/31/2019 6:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustId] [int] NULL,
	[EmpId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Profit] [money] NOT NULL,
	[AmountSell] [money] NOT NULL,
	[AmountBuy] [money] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_lastname]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_lastname] ON [HR].[Employees]
(
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_postalcode]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_postalcode] ON [HR].[Employees]
(
	[postalcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [categoryname]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [categoryname] ON [Production].[Categories]
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_categoryid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_categoryid] ON [Production].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_productname]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_productname] ON [Production].[Products]
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_supplierid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_supplierid] ON [Production].[Products]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_companyname]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_companyname] ON [Production].[Suppliers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_postalcode]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_postalcode] ON [Production].[Suppliers]
(
	[postalcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_city]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_city] ON [Sales].[Customers]
(
	[city] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_companyname]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_companyname] ON [Sales].[Customers]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_postalcode]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_postalcode] ON [Sales].[Customers]
(
	[PostCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nc_region]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_region] ON [Sales].[Customers]
(
	[region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_orderid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_orderid] ON [Sales].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_productid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_productid] ON [Sales].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_custid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_custid] ON [Sales].[Orders]
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_empid]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_empid] ON [Sales].[Orders]
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_nc_orderdate]    Script Date: 7/31/2019 6:05:20 PM ******/
CREATE NONCLUSTERED INDEX [idx_nc_orderdate] ON [Sales].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Production].[Products] ADD  CONSTRAINT [DFT_Products_unitprice]  DEFAULT ((0)) FOR [UnitPriceSales]
GO
ALTER TABLE [Production].[Products] ADD  CONSTRAINT [DFT_Products_unitpriceBuy]  DEFAULT ((0)) FOR [UnitPriceBuy]
GO
ALTER TABLE [Production].[Products] ADD  CONSTRAINT [DFT_Products_discontinued]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [Production].[Products] ADD  DEFAULT ((1)) FOR [Qty]
GO
ALTER TABLE [Production].[Products] ADD  DEFAULT ((0)) FOR [Tax]
GO
ALTER TABLE [Sales].[OrderDetails] ADD  CONSTRAINT [DFT_OrderDetails_unitprice]  DEFAULT ((0)) FOR [UnitPriceSale]
GO
ALTER TABLE [Sales].[OrderDetails] ADD  CONSTRAINT [DFT_OrderDetails_unitpriceBuy]  DEFAULT ((0)) FOR [UnitPriceBuy]
GO
ALTER TABLE [Sales].[OrderDetails] ADD  CONSTRAINT [DFT_OrderDetails_qty]  DEFAULT ((1)) FOR [qty]
GO
ALTER TABLE [Sales].[OrderDetails] ADD  CONSTRAINT [DFT_OrderDetails_discount]  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [Sales].[OrderDetails] ADD  DEFAULT ((0)) FOR [Tax]
GO
ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_freight]  DEFAULT ((0)) FOR [Profit]
GO
ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_comefreightcard]  DEFAULT ((0)) FOR [AmountSell]
GO
ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_comefreightcash]  DEFAULT ((0)) FOR [AmountBuy]
GO
ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([mgrid])
REFERENCES [HR].[Employees] ([EmpId])
GO
ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [HR].[Login]  WITH CHECK ADD  CONSTRAINT [FK_Login_Employees] FOREIGN KEY([empid])
REFERENCES [HR].[Employees] ([EmpId])
GO
ALTER TABLE [HR].[Login] CHECK CONSTRAINT [FK_Login_Employees]
GO
ALTER TABLE [Production].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryId])
REFERENCES [Production].[Categories] ([CategoryId])
GO
ALTER TABLE [Production].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [Production].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierId])
REFERENCES [Production].[Suppliers] ([SupplierId])
GO
ALTER TABLE [Production].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [Sales].[Orders] ([OrderId])
GO
ALTER TABLE [Sales].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [Production].[Products] ([ProductId])
GO
ALTER TABLE [Sales].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustId])
REFERENCES [Sales].[Customers] ([CustId])
GO
ALTER TABLE [Sales].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [Sales].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmpId])
REFERENCES [HR].[Employees] ([EmpId])
GO
ALTER TABLE [Sales].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_birthdate] CHECK  (([birthdate]<=getdate()))
GO
ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [CHK_birthdate]
GO
ALTER TABLE [Production].[Products]  WITH CHECK ADD  CONSTRAINT [CHK_Products_unitprice] CHECK  (([unitpriceBuy]>=(0)))
GO
ALTER TABLE [Production].[Products] CHECK CONSTRAINT [CHK_Products_unitprice]
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [CHK_discount] CHECK  (([discount]>=(0) AND [discount]<=(1)))
GO
ALTER TABLE [Sales].[OrderDetails] CHECK CONSTRAINT [CHK_discount]
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [CHK_qty] CHECK  (([qty]>(0)))
GO
ALTER TABLE [Sales].[OrderDetails] CHECK CONSTRAINT [CHK_qty]
GO
ALTER TABLE [Sales].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [CHK_unitprice] CHECK  (([UnitPriceSale]>=(0)))
GO
ALTER TABLE [Sales].[OrderDetails] CHECK CONSTRAINT [CHK_unitprice]
GO
/****** Object:  StoredProcedure [HR].[GetEMP]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [HR].[GetEMP]
	-- Add the parameters for the stored procedure here
	@username nvarchar(32)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select *
		from HR.Employees
		where empid = (Select top(1) empid
				from HR.Login
				where username = @username )

			

END
GO
/****** Object:  StoredProcedure [HR].[loginSP]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [HR].[loginSP]
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
/****** Object:  StoredProcedure [Production].[decreaseproduct]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[decreaseproduct] 
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
GO
/****** Object:  StoredProcedure [Production].[deleteCategory]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[deleteCategory]
	-- Add the parameters for the stored procedure here
	@catId int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

	delete 
	from Production.Categories 
	where CategoryId = @catId

END
GO
/****** Object:  StoredProcedure [Production].[deleteProduct]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[deleteProduct] 
	-- Add the parameters for the stored procedure here
	@productid int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

	delete 
	from Production.Products 
	where ProductId = @productid

END
GO
/****** Object:  StoredProcedure [Production].[deleteSupplier]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[deleteSupplier] 
	-- Add the parameters for the stored procedure here
	@supId int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

	delete 
	from Production.Suppliers 
	where SupplierId = @supId

END
GO
/****** Object:  StoredProcedure [Production].[getcategory]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[getcategory] 
	-- Add the parameters for the stored procedure here
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select * 
	from Production.Categories 
END
GO
/****** Object:  StoredProcedure [Production].[getproduct]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[getproduct] 
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
/****** Object:  StoredProcedure [Production].[getsupliers]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[getsupliers] 
	-- Add the parameters for the stored procedure here
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select * 
	from Production.Suppliers 
END
GO
/****** Object:  StoredProcedure [Production].[setcategory]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[setcategory] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(50),
	@desc nvarchar(50)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	insert into Production.Categories (CategoryName,description) values (@name,@desc)

END
GO
/****** Object:  StoredProcedure [Production].[setproduct]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Production].[setproduct] 
	-- Add the parameters for the stored procedure here
	@code nvarchar(50),
	@name nvarchar(40),
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
	

	insert into Production.Products(ProuductCode,ProductName,SupplierId,CategoryId,UnitPriceSales,UnitPriceBuy
	,Discount,Tax,Qty)values(@code,@name,@supli,@category,@unitpricesale,@unitpricebuy,
	@discount,@tax,@qty)

END
GO
/****** Object:  StoredProcedure [Production].[setsuplier]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Production].[setsuplier] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(50),
	@phone nvarchar(50)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	insert into Production.Suppliers(Companyname,Phone) values (@name,@phone)

END
GO
/****** Object:  StoredProcedure [Production].[updateProduct]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Production].[updateProduct] 
	-- Add the parameters for the stored procedure here
	@productid int,
	@code nvarchar(50),
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
	

	update  Production.Products
	 set ProuductCode = @code,ProductName = @name,SupplierId=@supli,CategoryId=@category,UnitPriceSales=@unitpricesale,UnitPriceBuy=@unitpricebuy,Discount=@discount,Tax=@tax,Qty=@qty
	 where Products.ProductId = @productid

END
GO
/****** Object:  StoredProcedure [Sales].[deleteorder]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[deleteorder] 
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
	
		UPDATE Production.Products 
	SET Qty += (SELECT  top(1)OD.qty 
						from Sales.OrderDetails AS OD
						where OD.OrderId = @orderid)
	WHERE productid = (SELECT  top(1)OD.ProductId 
						from Sales.OrderDetails AS OD
						where OD.OrderId = @orderid);

	delete 
	from Sales.OrderDetails
	where Sales.OrderDetails.OrderId = @orderid

commit tran;

END
GO
/****** Object:  StoredProcedure [Sales].[dvgOrderDetailsAll]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[dvgOrderDetailsAll]
	-- Add the parameters for the stored procedure here
	@date1 datetime ,
	@date2 datetime,
	@empId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@empId =-1)
	BEGIN
	SELECT c.CompanyName as customer, e.FirstName as emp, o.OrderDate  , p.ProductName , p.ProuductCode ,od.UnitPriceBuy ,od.UnitPriceSale ,od.qty
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
	WHERE O.OrderDate BETWEEN @date1 AND @date2
	END
	ELSE 
	BEGIN
		SELECT c.CompanyName , e.FirstName , o.OrderDate , p.ProductName , p.ProuductCode ,od.UnitPriceBuy ,od.UnitPriceSale ,od.qty
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
	WHERE O.OrderDate BETWEEN @date1 AND @date2 
	AND O.EmpId = @empId
	
	END

END
GO
/****** Object:  StoredProcedure [Sales].[dvgOrderDetailsGroupCat]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[dvgOrderDetailsGroupCat]
	-- Add the parameters for the stored procedure here
	@date1 datetime ,
	@date2 datetime,
	@empId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@empId =-1)
	BEGIN
	SELECT cat.CategoryName ,SUM(od.UnitPriceBuy) as sumBuy ,SUM(od.UnitPriceSale)as sumSell ,SUM(od.qty) as sumQty 
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
		JOIN Production.Categories AS cat
		on cat.CategoryId = p.CategoryId
	WHERE O.OrderDate BETWEEN @date1 AND @date2
	GROUP BY P.CategoryId ,cat.CategoryName

	END
	ELSE 
	BEGIN
	SELECT cat.CategoryName , SUM(od.UnitPriceBuy) as sumBuy ,SUM(od.UnitPriceSale)as sumSell ,SUM(od.qty) as sumQty 
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
		JOIN Production.Categories AS cat
		on cat.CategoryId = p.CategoryId
	WHERE O.OrderDate BETWEEN @date1 AND @date2
	and o.EmpId = @empId
	GROUP BY P.CategoryId ,cat.CategoryName
	
	END

END
GO
/****** Object:  StoredProcedure [Sales].[dvgOrderDetailsGroupCode]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[dvgOrderDetailsGroupCode]
	-- Add the parameters for the stored procedure here
	@date1 datetime ,
	@date2 datetime,
	@empId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@empId =-1)
	BEGIN
	SELECT p.ProductName,SUM(od.UnitPriceBuy) as sumBuy ,SUM(od.UnitPriceSale)as sumSell ,SUM(od.qty) as sumQty 
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
	WHERE O.OrderDate BETWEEN @date1 AND @date2
	GROUP BY P.ProuductCode ,p.ProductName

	END
	ELSE 
	BEGIN
	SELECT p.ProductName,SUM(od.UnitPriceBuy) as sumBuy ,SUM(od.UnitPriceSale)as sumSell ,SUM(od.qty) as sumQty
		FROM Sales.OrderDetails as od
		JOIN Sales.Orders as o
		on od.OrderId = o.OrderId
		JOIN Production.Products as p
		ON od.ProductId = p.ProductId
		JOIN Sales.Customers AS C
		ON o.CustId = c.CustId
		JOIN HR.Employees as e
		ON e.EmpId = o.EmpId
	WHERE O.OrderDate BETWEEN @date1 AND @date2
		AND O.EmpId = @empId
	GROUP BY P.ProuductCode ,p.ProductName
	
	END

END
GO
/****** Object:  StoredProcedure [Sales].[dvgSumOrders]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[dvgSumOrders] 
	-- Add the parameters for the stored procedure here
	@date1 datetime ,
	@date2 datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select SUM(o.AmountBuy) as sumBuy,SUM(o.AmountSell)as sumSell,SUM(o.Profit) as sumProfit ,'SumAll','0'
	from Sales.Orders as o
	where o.OrderDate between @date1 and @date2

	UNION ALL

	select SUM(o.AmountBuy) as sumBuy,SUM(o.AmountSell)as sumSell,SUM(o.Profit) as sumProfit ,(select e.FirstName	
																									from HR.Employees as e
																									where e.EmpId =o.EmpId) as NameOfEmp , o.EmpId
	from Sales.Orders as o
	where o.OrderDate between @date1 and @date2
	group by o.EmpId 


END
GO
/****** Object:  StoredProcedure [Sales].[getcustomers]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[getcustomers] 
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
GO
/****** Object:  StoredProcedure [Sales].[getcustomersbyid]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Sales].[getcustomersbyid] 
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
GO
/****** Object:  StoredProcedure [Sales].[getorder]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Sales].[getorder] 
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
/****** Object:  StoredProcedure [Sales].[getorderbytime]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[getorderbytime] 
	-- Add the parameters for the stored procedure here
	
	@time1 datetime,
	@time2 datetime,
	@empid int

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	select * 
	from Orders 
	where Orders.OrderDate between @time1 and @time2 and Orders.EmpId = @empid

commit tran;

END
GO
/****** Object:  StoredProcedure [Sales].[getOrderDetails]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [Sales].[getOrderDetails] 
	-- Add the parameters for the stored procedure here
	
	@OrderId int

AS
begin
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	select * 
	from OrderDetails 
	where OrderDetails.OrderId = @OrderId

commit tran;

END
GO
/****** Object:  StoredProcedure [Sales].[setcustomer]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
Create PROCEDURE [Sales].[setcustomer] 
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
/****** Object:  StoredProcedure [Sales].[setorder]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[setorder] 
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

	declare @orderid as int;

	insert into Sales.Orders(CustId,EmpId,OrderDate,Profit,AmountSell,AmountBuy)
	values (@custid,@empid,@orderDate,@profit,@amountsell,@amountbuy)

	 SET @orderid = SCOPE_IDENTITY();


	select * 
	from Sales.Orders as orders
	where orders.OrderId = @orderid

commit tran;

END
GO
/****** Object:  StoredProcedure [Sales].[setorderdetails]    Script Date: 7/31/2019 6:05:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ali
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Sales].[setorderdetails] 
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
BEGIN tran;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	insert into Sales.OrderDetails(OrderId,ProductId,UnitPriceSale,UnitPriceBuy,discount,qty,Tax)
	values (@orderid,@productid,@unitpricesales,@unitpricebuy,@discount,@qty,@tax)
	
	UPDATE Production.Products 
	SET Qty -= @qty 
	WHERE productid = @productId;

commit tran;
END
GO
USE [master]
GO
ALTER DATABASE [Acounting] SET  READ_WRITE 
GO
