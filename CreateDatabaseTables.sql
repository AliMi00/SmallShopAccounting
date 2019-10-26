USE [Acounting]
GO

/****** Object:  Table [HR].[Employees]    Script Date: 7/31/2019 5:56:25 PM ******/
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

ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([mgrid])
REFERENCES [HR].[Employees] ([EmpId])
GO

ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO

ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_birthdate] CHECK  (([birthdate]<=getdate()))
GO

ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [CHK_birthdate]
GO

USE [Acounting]
GO

/****** Object:  Table [HR].[Login]    Script Date: 7/31/2019 5:56:54 PM ******/
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

ALTER TABLE [HR].[Login]  WITH CHECK ADD  CONSTRAINT [FK_Login_Employees] FOREIGN KEY([empid])
REFERENCES [HR].[Employees] ([EmpId])
GO

ALTER TABLE [HR].[Login] CHECK CONSTRAINT [FK_Login_Employees]
GO


USE [Acounting]
GO

/****** Object:  Table [Production].[Categories]    Script Date: 7/31/2019 5:57:20 PM ******/
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

USE [Acounting]
GO

/****** Object:  Table [Production].[Products]    Script Date: 7/31/2019 5:57:40 PM ******/
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

ALTER TABLE [Production].[Products]  WITH CHECK ADD  CONSTRAINT [CHK_Products_unitprice] CHECK  (([unitpriceBuy]>=(0)))
GO

ALTER TABLE [Production].[Products] CHECK CONSTRAINT [CHK_Products_unitprice]
GO

USE [Acounting]
GO

/****** Object:  Table [Production].[Suppliers]    Script Date: 7/31/2019 5:58:10 PM ******/
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

USE [Acounting]
GO

/****** Object:  Table [Sales].[Customers]    Script Date: 7/31/2019 5:58:24 PM ******/
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

USE [Acounting]
GO

/****** Object:  Table [Sales].[OrderDetails]    Script Date: 7/31/2019 5:58:34 PM ******/
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

USE [Acounting]
GO

/****** Object:  Table [Sales].[Orders]    Script Date: 7/31/2019 5:58:47 PM ******/
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

ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_freight]  DEFAULT ((0)) FOR [Profit]
GO

ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_comefreightcard]  DEFAULT ((0)) FOR [AmountSell]
GO

ALTER TABLE [Sales].[Orders] ADD  CONSTRAINT [DFT_Orders_comefreightcash]  DEFAULT ((0)) FOR [AmountBuy]
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

-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
--STORED PROCEDURES
