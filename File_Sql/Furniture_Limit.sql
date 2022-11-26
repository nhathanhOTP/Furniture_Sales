USE [master]
GO
/****** Object:  Database [Furniture_Sales]    Script Date: 11/26/2022 1:23:27 AM ******/
CREATE DATABASE [Furniture_Sales]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Furniture_Sales', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Furniture_Sales.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Furniture_Sales_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Furniture_Sales_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Furniture_Sales] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Furniture_Sales].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Furniture_Sales] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Furniture_Sales] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Furniture_Sales] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Furniture_Sales] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Furniture_Sales] SET ARITHABORT OFF 
GO
ALTER DATABASE [Furniture_Sales] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Furniture_Sales] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Furniture_Sales] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Furniture_Sales] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Furniture_Sales] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Furniture_Sales] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Furniture_Sales] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Furniture_Sales] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Furniture_Sales] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Furniture_Sales] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Furniture_Sales] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Furniture_Sales] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Furniture_Sales] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Furniture_Sales] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Furniture_Sales] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Furniture_Sales] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Furniture_Sales] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Furniture_Sales] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Furniture_Sales] SET  MULTI_USER 
GO
ALTER DATABASE [Furniture_Sales] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Furniture_Sales] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Furniture_Sales] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Furniture_Sales] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Furniture_Sales] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Furniture_Sales] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Furniture_Sales] SET QUERY_STORE = OFF
GO
USE [Furniture_Sales]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](50) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[phone] [varchar](15) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [char](4) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conditions]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conditions](
	[IdConditions] [int] IDENTITY(1,1) NOT NULL,
	[MinSpend] [float] NULL,
	[QuantityRequest] [int] NULL,
	[NumberOfUses] [int] NULL,
 CONSTRAINT [PK_Conditons] PRIMARY KEY CLUSTERED 
(
	[IdConditions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[IdDiscount] [int] IDENTITY(1,1) NOT NULL,
	[ValueDecrease] [float] NOT NULL,
	[TitleDiscount] [nvarchar](100) NULL,
	[ContentDiscount] [nvarchar](100) NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[IdProduct] [int] NOT NULL,
	[ConditionsOfUse] [int] NOT NULL,
	[DiscountForm] [bit] NOT NULL,
	[codeDiscount] [varchar](200) NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[IdDiscount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Evaluate]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluate](
	[IdEvaluate] [int] IDENTITY(1,1) NOT NULL,
	[IdProduct] [int] NOT NULL,
	[Contents] [nvarchar](max) NOT NULL,
	[NumberStart] [int] NOT NULL,
	[statusEva] [bit] NULL,
	[username] [nvarchar](50) NULL,
	[createDate] [datetime] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[IdEvaluate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favourites]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favourites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[IdProduct] [int] NOT NULL,
	[DateCreate] [date] NOT NULL,
 CONSTRAINT [PK_Favorites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[status] [int] NULL,
	[note] [nvarchar](225) NULL,
	[Amount] [float] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderStatus]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](100) NOT NULL,
	[Price] [float] NOT NULL,
	[CreateDate] [date] NOT NULL,
	[Available] [bit] NOT NULL,
	[CategoryId] [char](4) NOT NULL,
	[Origin] [nvarchar](100) NULL,
	[Guarentee] [nvarchar](100) NULL,
	[MadeOf] [nvarchar](100) NULL,
	[Color] [nvarchar](100) NULL,
	[Size] [nvarchar](100) NULL,
	[soLuong] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheTimeUsed]    Script Date: 11/26/2022 1:23:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheTimeUsed](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[NumberOfUse] [int] NOT NULL,
	[AmountDiscount] [float] NOT NULL,
	[IdDiscount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'bangphin1', N'123Abc', N'Nguyễn Bằng Phi', N'bangphin1@gmail.com', N'bangphi.jpg', N'STA', N'0451384592')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'hoangdieu3', N'123Abc', N'Phạm Hoàng Diệu', N'hoangdieu@gmail.com', N'hoangdieu.jpg', N'CUS', N'0487514953')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'huhu', N'123456', N'Vo Thu Hoai', N'jhjh@gmailcom', N'a.jpg', N'CUS', NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'hung111', N'456', N'Tran Pham Khong Hung', N'hung@gmail.com', N'a.jpg', N'CUS', NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'huytuan2', N'123Abc', N'Trần Huy Tuấn', N'huytuan@gmail.com', N'huytuan.jpg', N'CUS', N'0578134855')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'minhchanh5', N'123Abc', N'Nguyễn Minh Chánh', N'chanhminh@gmail.com', N'chanhminh.jpg', N'CUS', N'0351147781')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'nha123', N'123456', N'Vo Thanh Nha', N'vothanhnha744@gmail.com', N'a.jpg', N'CUS', NULL)
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'quocminh6', N'123Abc', N'Trịnh Quốc Minh', N'quocminh@gmail.com', N'quocminh.jpg', N'STA', N'0548566926')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'tpph0503', N'1111', N'Trần Phạm Phi Hùng', N'2002dtn@gmail.com', N'phihung.jpg', N'ADM', N'0769628823')
INSERT [dbo].[Accounts] ([Username], [Password], [Fullname], [Email], [Photo], [Role], [phone]) VALUES (N'xuanthai4', N'123Abc', N'Mai Xuân Thái', N'xuanthai@gmail.com', N'xuanthai.jpg', N'CUS', N'0754856995')
GO
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'TL10', N'Thảm')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'TL3 ', N'Bàn ghế')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'TL4 ', N'Ghế Sofa')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (N'TL6 ', N'Kệ')
GO
SET IDENTITY_INSERT [dbo].[Conditions] ON 

INSERT [dbo].[Conditions] ([IdConditions], [MinSpend], [QuantityRequest], [NumberOfUses]) VALUES (1, 150000, 3, 10)
INSERT [dbo].[Conditions] ([IdConditions], [MinSpend], [QuantityRequest], [NumberOfUses]) VALUES (2, 100000, 2, 1)
INSERT [dbo].[Conditions] ([IdConditions], [MinSpend], [QuantityRequest], [NumberOfUses]) VALUES (6, 10000, 5, 4)
INSERT [dbo].[Conditions] ([IdConditions], [MinSpend], [QuantityRequest], [NumberOfUses]) VALUES (7, 120000, 2, 5)
INSERT [dbo].[Conditions] ([IdConditions], [MinSpend], [QuantityRequest], [NumberOfUses]) VALUES (8, 250000, 2, 5)
SET IDENTITY_INSERT [dbo].[Conditions] OFF
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 

INSERT [dbo].[Discount] ([IdDiscount], [ValueDecrease], [TitleDiscount], [ContentDiscount], [StartDate], [EndDate], [IdProduct], [ConditionsOfUse], [DiscountForm], [codeDiscount]) VALUES (1, 150000, N'Giam gia cuc manh cho mua he nay', N'Thich thi giam hoy co duoc hong!', CAST(N'2022-11-24' AS Date), CAST(N'2022-11-10' AS Date), 1, 1, 0, N'255C450F')
INSERT [dbo].[Discount] ([IdDiscount], [ValueDecrease], [TitleDiscount], [ContentDiscount], [StartDate], [EndDate], [IdProduct], [ConditionsOfUse], [DiscountForm], [codeDiscount]) VALUES (2, 12000, N'16000', N'asd asda sdas dasd', CAST(N'2022-11-20' AS Date), CAST(N'2022-11-20' AS Date), 2, 1, 0, N'255C450F1')
INSERT [dbo].[Discount] ([IdDiscount], [ValueDecrease], [TitleDiscount], [ContentDiscount], [StartDate], [EndDate], [IdProduct], [ConditionsOfUse], [DiscountForm], [codeDiscount]) VALUES (3, 100, N'Giảm giá cực mạnh', N'ádasd ád', CAST(N'2022-11-25' AS Date), CAST(N'2022-11-19' AS Date), 4, 1, 0, N'255C450F12222ed')
INSERT [dbo].[Discount] ([IdDiscount], [ValueDecrease], [TitleDiscount], [ContentDiscount], [StartDate], [EndDate], [IdProduct], [ConditionsOfUse], [DiscountForm], [codeDiscount]) VALUES (8, 120000, N'Giảm giá cho mùa hè này!', N'ád ád ádas dá dsa', CAST(N'2022-11-24' AS Date), CAST(N'2022-11-26' AS Date), 3, 1, 0, N'255C450F-A380-4FE5-9A3F-8025B6CBA423')
INSERT [dbo].[Discount] ([IdDiscount], [ValueDecrease], [TitleDiscount], [ContentDiscount], [StartDate], [EndDate], [IdProduct], [ConditionsOfUse], [DiscountForm], [codeDiscount]) VALUES (9, 500000, N'Giảm giá cực mạnh cho mùa Noel', N'Khuyến mãi sâu cho các mặt hàng của mùa Noel sắp tới!', CAST(N'2022-11-26' AS Date), CAST(N'2022-11-30' AS Date), 7, 2, 0, N'DB412A0C-83EB-453D-A7C5-B0F780DA116C')
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[Evaluate] ON 

INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (1, 1, N'Content Evaluate', 1, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (2, 1, N'Content Evaluate', 2, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (3, 1, N'Content Evaluate', 3, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (4, 2, N'Content Evaluate', 1, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (5, 2, N'Content Evaluate', 2, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (6, 2, N'Content Evaluate', 3, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (7, 3, N'Content Evaluate', 1, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (8, 3, N'Content Evaluate', 2, 0, N'bangphin1', NULL)
INSERT [dbo].[Evaluate] ([IdEvaluate], [IdProduct], [Contents], [NumberStart], [statusEva], [username], [createDate]) VALUES (9, 3, N'Content Evaluate', 3, 0, N'bangphin1', NULL)
SET IDENTITY_INSERT [dbo].[Evaluate] OFF
GO
SET IDENTITY_INSERT [dbo].[Favourites] ON 

INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (10, N'bangphin1', 2, CAST(N'2022-11-25' AS Date))
INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (12, N'bangphin1', 3, CAST(N'2022-11-25' AS Date))
INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (13, N'bangphin1', 7, CAST(N'2022-11-25' AS Date))
INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (14, N'bangphin1', 9, CAST(N'2022-11-25' AS Date))
INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (15, N'bangphin1', 10, CAST(N'2022-11-26' AS Date))
INSERT [dbo].[Favourites] ([Id], [Username], [IdProduct], [DateCreate]) VALUES (16, N'bangphin1', 1, CAST(N'2022-11-26' AS Date))
SET IDENTITY_INSERT [dbo].[Favourites] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (1, 1, 1, 4320000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (2, 2, 2, 4928000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (3, 3, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (4, 4, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (5, 5, 4, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (6, 6, 1, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (7, 7, 4, 7700000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (8, 8, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (9, 9, 1, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (10, 10, 2, 14784000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (11, 13, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (12, 13, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (13, 13, 7, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (14, 13, 5, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (15, 14, 8, 7700000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (16, 14, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (17, 14, 4, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (18, 15, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (19, 15, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (20, 15, 7, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (21, 15, 7, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (22, 15, 6, 4928000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (23, 15, 6, 4928000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (24, 17, 3, 18600000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (25, 17, 2, 98560000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (26, 17, 4, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (27, 18, 1, 86400000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (28, 18, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (29, 18, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (30, 18, 4, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (31, 18, 5, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (32, 19, 2, 197120000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (33, 19, 7, 9300000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (34, 20, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (35, 20, 7, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (36, 20, 5, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (37, 20, 8, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (38, 23, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (39, 23, 6, 4928000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (40, 23, 5, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (41, 23, 12, 5400000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (42, 24, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (43, 24, 6, 4928000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (44, 24, 8, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (45, 25, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (46, 25, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (47, 26, 14, 10800000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (48, 26, 13, 2300000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (49, 26, 15, 42240000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (50, 26, 16, 12000000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (51, 27, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (52, 27, 1, 21600000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (53, 27, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (54, 28, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (55, 28, 4, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (56, 30, 7, 9300000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (57, 30, 8, 7700000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (58, 30, 2, 295680000, 6)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (59, 31, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (60, 31, 7, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (61, 31, 8, 3850000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (62, 31, 9, 6500000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (63, 32, 11, 4600000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (64, 32, 12, 5400000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (65, 32, 10, 11000000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (66, 32, 9, 6500000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (67, 33, 4, 19250000, 5)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (68, 33, 2, 98560000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (69, 33, 3, 4650000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (70, 34, 3, 9300000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (71, 34, 5, 2160000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (72, 35, 3, 13950000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (73, 35, 5, 8640000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (74, 36, 9, 6500000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (75, 36, 2, 49280000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (76, 36, 3, 9300000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (77, 37, 8, 19250000, 5)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (78, 37, 9, 6500000, 1)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (79, 37, 7, 13950000, 3)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (80, 38, 2, 197120000, 4)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (81, 38, 3, 9300000, 2)
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Price], [Quantity]) VALUES (82, 38, 4, 3850000, 1)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (1, N'bangphin1', CAST(N'2022-10-17T00:00:00.000' AS DateTime), N'p.Trung Mỹ Tây, Quận 12, TPHCM', 3, N'Waiting for you', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (2, N'bangphin1', CAST(N'2022-10-17T00:00:00.000' AS DateTime), N'p.Trung Mỹ Tây, Quận 12, TPHCM', 2, N'Give it to me', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (3, N'bangphin1', CAST(N'2022-10-18T00:00:00.000' AS DateTime), N'p.Trung Mỹ Tây, Quận 12, TPHCM', 3, N'Like first times', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (4, N'huytuan2', CAST(N'2022-10-19T00:00:00.000' AS DateTime), N'Nguyễn Tất Thành, Quận 9, TPHCM', 4, N'Attention', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (5, N'huytuan2', CAST(N'2022-10-19T00:00:00.000' AS DateTime), N'Nguyễn Tất Thành, Quận 9, TPHCM', 3, N'Shape of you', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (6, N'hoangdieu3', CAST(N'2022-10-20T00:00:00.000' AS DateTime), N'Phạm Văn Chiêu, Quận 7, TPHCM', 2, N'Above the floor', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (7, N'xuanthai4', CAST(N'2022-10-22T00:00:00.000' AS DateTime), N'Nguyễn Trãi, Quận 8, TPHCM', 3, N'First love', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (8, N'xuanthai4', CAST(N'2022-10-23T00:00:00.000' AS DateTime), N'Nguyễn Trãi, Quận 8, TPHCM', 3, N'Alone star', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (9, N'xuanthai4', CAST(N'2022-10-23T00:00:00.000' AS DateTime), N'Nguyễn Trãi, Quận 8, TPHCM', 3, N'What month you love me', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (10, N'minhchanh5', CAST(N'2022-10-25T00:00:00.000' AS DateTime), N'Nguyễn Tri Phương, Quận 11, TPHCM', 4, N'April is your lie', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (13, N'tpph0503', CAST(N'2022-11-11T00:00:00.000' AS DateTime), N'Phường Trung Mỹ Tây Quận 12 TP HCM', 1, N'Black Ice Without Sugar', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (14, N'tpph0503', CAST(N'2022-11-11T00:00:00.000' AS DateTime), N'Phường Trung Mỹ Tây Quận 12 TP HCM', 4, N'Di den dau hem 37 thi goi vao sdt 0769628823', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (15, N'tpph0503', CAST(N'2022-11-12T00:00:00.000' AS DateTime), N'Quan 12 TPHCM', 4, N'SDT 0458562244', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (16, N'tpph0503', CAST(N'2022-11-12T00:00:00.000' AS DateTime), N'Quan 12 TPHCM', 4, N'SDT 0458562244', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (17, N'tpph0503', CAST(N'2022-11-21T13:08:56.157' AS DateTime), N'TP Đồng Nai, Nhơn Trạch, Xã Phú Hữu, Đường 319.', 1, N'ád áda sd', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (18, N'tpph0503', CAST(N'2022-11-21T15:52:35.210' AS DateTime), N'TP Hồ Chí Minh, Bình Thạnh, Phường 2, Đường 135.', 4, N'Hàng dễ vỡ xin hãy cẩn thận!', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (19, N'huytuan2', CAST(N'2022-11-21T21:25:23.857' AS DateTime), N'TP Hồ Chí Minh, Bình Thạnh, Phường 14, Đường 17.', 3, N'Hàng dễ vỡ~', NULL)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (20, N'hoangdieu3', CAST(N'2022-11-23T15:24:03.817' AS DateTime), N'TP Hồ Chí Minh, Cần Giờ, Phường Cần Thạnh , Đường An Thới Đông.', 4, N'Không comment!', 59820000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (21, N'hoangdieu3', CAST(N'2022-11-23T19:20:16.083' AS DateTime), N'TP Hồ Chí Minh, Bình Tân', 1, N'Hàng dễ vỡ vỡnh!', 17018000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (22, N'hoangdieu3', CAST(N'2022-11-23T19:20:30.997' AS DateTime), N'TP Hồ Chí Minh, Bình Tân', 1, N'Hàng dễ vỡ vỡnh!', 17018000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (23, N'hoangdieu3', CAST(N'2022-11-23T19:22:42.167' AS DateTime), N'TP Hồ Chí Minh, Bình Tân, Phường Bình Hưng Hòa, Đường 12.', 1, N'ád á d', 17018000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (24, N'bangphin1', CAST(N'2022-11-23T21:06:21.660' AS DateTime), N'TP Hồ Chí Minh, Cần Giờ, Phường Cần Thạnh , Đường 47.', 1, N'Hang de vo caution! Please!', 13308000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (25, N'bangphin1', CAST(N'2022-11-23T21:07:48.297' AS DateTime), N'TP Hà Nội, Cầu Giấy, Phường Mai Dịch, Đường Cầu vượt Mai Dịch.', 1, N'asd asd asd asd', 53810000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (26, N'bangphin1', CAST(N'2022-11-23T21:13:23.997' AS DateTime), N'TP Hồ Chí Minh, Bình Thạnh, Phường 12, Đường 1.', 1, N'Hang de vo nha ba con!', 67220000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (27, N'bangphin1', CAST(N'2022-11-23T21:19:36.093' AS DateTime), N'TP Hồ Chí Minh, Bình Thạnh, Phường 11, Đường 1.', 1, N'ads das asd asd', 75410000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (28, N'bangphin1', CAST(N'2022-11-23T21:22:39.983' AS DateTime), N'TP Bình Dương, Phú Giáo, Xã Phước Sang, Đường Bố Mua.', 1, N'asd asd asda sd', 53010000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (30, N'bangphin1', CAST(N'2022-11-24T00:52:12.380' AS DateTime), N'TP Hồ Chí Minh, Cần Giờ, Xã An Thới Đông, Đường 30/4.', 4, N'Hàng đễ vỡ mấy a ưi!', 312679900)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (31, N'bangphin1', CAST(N'2022-11-24T00:53:44.943' AS DateTime), N'TP Hồ Chí Minh, Cần Giờ, Xã Bình Khánh, Đường 47.', 4, N'Cẩn thận nha mấy anh trai!', 64279900)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (32, N'bangphin1', CAST(N'2022-11-24T00:56:31.240' AS DateTime), N'TP Hồ Chí Minh, Bình Tân, Phường An Lạc A, Đường 10A.', 4, N'Hàng thanh lý hải quan!', 27499900)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (33, N'bangphin1', CAST(N'2022-11-24T12:54:52.463' AS DateTime), N'TP Hà Nội, Gia Lâm, Xã Đông Dư, Đường An Đào D.', 4, N'asd asd ads asd', 122340000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (34, N'bangphin1', CAST(N'2022-11-24T14:38:17.460' AS DateTime), N'TP Hồ Chí Minh, Quận 12, Phường Trung Mỹ Tây, Đường Hà Huy Giáp.', 1, N'doikhien anh chang con nhieyu', 11460000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (35, N'bangphin1', CAST(N'2022-11-24T14:40:14.840' AS DateTime), N'TP Bình Dương, Dĩ An, Phường Dĩ An, Đường 17.', 1, N'rgdfgdgdgfdfgdfg', 22590000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (36, N'bangphin1', CAST(N'2022-11-24T15:18:14.053' AS DateTime), N'TP Đà Nẵng, Cẩm Lệ, Phường Hòa Phát, Đường 20.', 1, N'sad asd asd as', 64960000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (37, N'bangphin1', CAST(N'2022-11-25T12:46:26.097' AS DateTime), N'TP Hồ Chí Minh, Bình Chánh, Xã Hưng Long, Đường 13B.', 4, N'dá áda sd ád ád', 39700000)
INSERT [dbo].[Orders] ([Id], [Username], [CreateDate], [Address], [status], [note], [Amount]) VALUES (38, N'bangphin1', CAST(N'2022-11-25T13:02:56.010' AS DateTime), N'TP Hồ Chí Minh, Bình Chánh, Xã Hưng Long, Đường 10B.', 4, N'Hàng dễ vỡ!', 210150000)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[orderStatus] ON 

INSERT [dbo].[orderStatus] ([id], [name]) VALUES (1, N'Waiting for confirm')
INSERT [dbo].[orderStatus] ([id], [name]) VALUES (2, N'Processing')
INSERT [dbo].[orderStatus] ([id], [name]) VALUES (3, N'Done')
INSERT [dbo].[orderStatus] ([id], [name]) VALUES (4, N'Cancelled')
SET IDENTITY_INSERT [dbo].[orderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (1, N'Sofa phòng khách H9270-VP da thật 100%', N'lanpegh6gzsbtbg2qqk', 21600000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Macao', N'5 năm
', N'Da bò thật', N'#b06d6d+#c0c0c0+#0000ff+', N'2750 *1010*710mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (2, N'Sofa da nhập khẩu Malaysia H9176-VB', N'lanpdo0qrxfl374lu8', 49280000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Malaysia', N'5 năm
', N'Da bò thật', N'#6f1616+#917e7e+', N'2905*940*840mm', 15)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (3, N'Thảm trang trí Cal 101', N'lanpbtqfiyww7l6k9e9', 4650000, CAST(N'2022-11-02' AS Date), 1, N'TL10', N'Macao', N'1 năm', N'Polypropylene', N'#ce3b3b+#503434+', N'1600 x 2300', 6)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (4, N'Thảm Havana 421', N'lanpb7zgp3nu00d8cfb', 3850000, CAST(N'2022-11-02' AS Date), 1, N'TL10', N'Đức', N'1 năm', N'Sợi tổng hợp', N'#e25555+#711414+', N'1600 x 2300', 4)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (5, N'Kệ tivi đẹp cho phòng khách KTV917', N'lanpegh6gzsbtbg2qqk', 2160000, CAST(N'2022-11-02' AS Date), 1, N'TL6 ', N'Nhập Khẩu', N'1 năm', N'Gỗ + Mặt đá Marble', N'#653434+#b63535+', N'(1800-2400)x350x465', 0)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (6, N'Bàn ăn mặt đá hiện đại BA2114', N'lanpfsy5ebh4ddngukw', 4928000, CAST(N'2022-11-02' AS Date), 1, N'TL3 ', N'Macao', N'1 năm', N'Gỗ + Mặt đá Marble', N'#6f4444+#a76c6c+', N'850*420 và 700 *420 mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (7, N'Bàn trà mặt đá BT939', N'lanpgob5sxmq4tudrt', 4650000, CAST(N'2022-11-02' AS Date), 1, N'TL3 ', N'Malaysia', N'1 năm', N'Mặt đá cẩm thạch + khung inox mạ titan', N'#843939+#775050+', N'1600*800 mm', 2)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (8, N'Bộ bàn ghế ăn cơm BA19082', N'lanphhk2pruwrmjusbr', 3850000, CAST(N'2022-11-02' AS Date), 1, N'TL3 ', N'Malaysia', N'1 năm', N'Chân thép- mặt đá', N'#a21111+#833a3a+', N'1400*800*750 mm', 0)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (9, N'Sofa da H2210', N'lanpla1fg0b01fhnb5g', 6500000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Macao', N'5 năm
', N'Da bò thật', N'#9e1010+#923f3f+#744444+', N'2450*1600*1000 mm', 3)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (10, N'Sofa văng đẹp NTX7211', N'lanpkmauolpcccnxuu', 5500000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Macedonia, The Former Yugoslav Republic of', N'5 năm', N'Da Hàn cao cấp', N'#af6060+#a34848+', N'2200x900mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (11, N'Bàn ăn đẹp BA203', N'lanpjer5iaekp72mmk', 4600000, CAST(N'2022-11-02' AS Date), 1, N'TL3 ', N'Malta', N'1 năm', N'Gỗ tự nhiên - đá cẩm thạch', N'#a23939+#8b5b5b+#bea7a7+', N'1300*800 mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (12, N'Sofa da NTX2201', N'lanpi67ya6z6trto9xb', 5400000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Martinique', N'5 năm', N'Da hạng sang', N'#a88f8f+#9c6868+#2c1616+', N'2600*1600*900 mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (13, N'Thảm mashab 132', N'lanpn5d2jkc3ge3obu', 2300000, CAST(N'2022-11-02' AS Date), 1, N'TL10', N'Macao', N'1 năm', N'100% PP heatset', N'#b85656+#dd9898+', N'1600 x 2300', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (14, N'Kệ tivi mặt đá cao cấp mã KTV811', N'lanpi67ya6z6trto9xb', 10800000, CAST(N'2022-11-02' AS Date), 1, N'TL6 ', N'Nhập Khẩu', N'1 năm', N' Gỗ + mặt đá sang trọng', N'#a77272+#800000+', N'2000x430x430 mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (15, N'Sofa nhập khẩu Malaysia H91029-G', N'lanp61kf0h47grubqgj4', 42240000, CAST(N'2022-11-02' AS Date), 1, N'TL4 ', N'Malaysia', N'5 năm', N'Da Bò', N'#6f1b1b+#c34646+#b5b5b5+', N'2740 x 930 x 1110mm', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (16, N'Ghế sofa', N'lamxea15vfhcmv1ozf', 12000000, CAST(N'2022-11-19' AS Date), 0, N'TL4 ', N'Martinique', N'2 năm', N'Da', N'#a82929+#b12525+#008000+', N'1500x1600', 5)
INSERT [dbo].[Products] ([Id], [Name], [Image], [Price], [CreateDate], [Available], [CategoryId], [Origin], [Guarentee], [MadeOf], [Color], [Size], [soLuong]) VALUES (20, N'Table decor', N'lawsuhmztn2b1na2gvq', 25000000, CAST(N'2022-11-26' AS Date), 0, N'TL3 ', N'Malaysia', N'2 nam', N'Go cao cap', N'#ffff00+#008000+', N'1500x1600', 20)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'ADM', N'Admin')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'CUS', N'Customer')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'STA', N'Staff')
GO
SET IDENTITY_INSERT [dbo].[TheTimeUsed] ON 

INSERT [dbo].[TheTimeUsed] ([Id], [Username], [NumberOfUse], [AmountDiscount], [IdDiscount]) VALUES (1, N'bangphin1', 2, 8380000, 8)
INSERT [dbo].[TheTimeUsed] ([Id], [Username], [NumberOfUse], [AmountDiscount], [IdDiscount]) VALUES (20, N'bangphin1', 3, 8499900, 3)
SET IDENTITY_INSERT [dbo].[TheTimeUsed] OFF
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Customers_Photo]  DEFAULT (N'Photo.gif') FOR [Photo]
GO
ALTER TABLE [dbo].[Discount] ADD  DEFAULT (newid()) FOR [codeDiscount]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_OrderDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Image]  DEFAULT (N'Product.gif') FOR [Image]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_ProductDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Available]  DEFAULT ((1)) FOR [Available]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Roles] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_Conditions] FOREIGN KEY([ConditionsOfUse])
REFERENCES [dbo].[Conditions] ([IdConditions])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_Conditions]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_Product] FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_Product]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK_Evaluate_Account] FOREIGN KEY([username])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK_Evaluate_Account]
GO
ALTER TABLE [dbo].[Evaluate]  WITH CHECK ADD  CONSTRAINT [FK_Evaluation_Product] FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Evaluate] CHECK CONSTRAINT [FK_Evaluation_Product]
GO
ALTER TABLE [dbo].[Favourites]  WITH CHECK ADD  CONSTRAINT [FK_Favorite_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Favourites] CHECK CONSTRAINT [FK_Favorite_Account]
GO
ALTER TABLE [dbo].[Favourites]  WITH CHECK ADD  CONSTRAINT [FK_Favorite_Product] FOREIGN KEY([IdProduct])
REFERENCES [dbo].[Products] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Favourites] CHECK CONSTRAINT [FK_Favorite_Product]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [fk_orders_orderStatus] FOREIGN KEY([status])
REFERENCES [dbo].[orderStatus] ([id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [fk_orders_orderStatus]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK3ess0s7i9qs6sim1pf9kxhkpq] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK3ess0s7i9qs6sim1pf9kxhkpq]
GO
ALTER TABLE [dbo].[TheTimeUsed]  WITH CHECK ADD  CONSTRAINT [FK_TheTimeUsed_Accounts] FOREIGN KEY([Username])
REFERENCES [dbo].[Accounts] ([Username])
GO
ALTER TABLE [dbo].[TheTimeUsed] CHECK CONSTRAINT [FK_TheTimeUsed_Accounts]
GO
ALTER TABLE [dbo].[TheTimeUsed]  WITH CHECK ADD  CONSTRAINT [FK_TheTimeUsed_Discount] FOREIGN KEY([IdDiscount])
REFERENCES [dbo].[Discount] ([IdDiscount])
GO
ALTER TABLE [dbo].[TheTimeUsed] CHECK CONSTRAINT [FK_TheTimeUsed_Discount]
GO
/****** Object:  StoredProcedure [dbo].[checkUserOrdered]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserOrdered]      
    @username nvarchar(50),
	@productId int
AS   
select count(d.id) from Accounts a 
inner join Orders o on a.Username = o.Username 
inner join OrderDetails d on o.id = d.OrderId 
where a.Username = @username and d.ProductId = @productId
GROUP BY a.username
GO
/****** Object:  StoredProcedure [dbo].[find_Order_id]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[find_Order_id]
@username nvarchar(20),
@statusId int

as
begin

select top 1 * from orders where username = @username and status = @statusId order by CreateDate desc

end
GO
/****** Object:  StoredProcedure [dbo].[findProductByConditions]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[findProductByConditions]
@DieuKien nvarchar(200)
as
begin
select * from products pr where pr.name like '%'+@DieuKien+'%' or pr.price like '%'+@DieuKien+'%'
or pr.MadeOf like '%'+@DieuKien+'%' or pr.size like '%'+@DieuKien+'%' or pr.Origin like '%'+@DieuKien+'%'
end
GO
/****** Object:  StoredProcedure [dbo].[getAllProducts]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getAllProducts]
as
begin
SELECT * FROM products
ORDER BY NEWID()
end
GO
/****** Object:  StoredProcedure [dbo].[report_products]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[report_products]
as
begin
select top 5 count(quantity)as'Number of orders', pr.Name ,pr.Price,pr.CreateDate from OrderDetails ordel inner join 
Products pr on ordel.ProductId = pr.Id 
group by  pr.Name ,pr.Price,pr.CreateDate order by  count(quantity) DESC
end
GO
/****** Object:  StoredProcedure [dbo].[sp_discountAvali]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_discountAvali]
as
begin
select * from discount where enddate >= GETDATE()
end
GO
/****** Object:  StoredProcedure [dbo].[sp_findByUsernameAndDiscount]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_findByUsernameAndDiscount]
@DieuKien1 nvarchar (50),@DieuKien2 int
as
begin
select * from TheTimeUsed where username=@DieuKien1 and idDiscount = @DieuKien2
end
GO
/****** Object:  StoredProcedure [dbo].[sp_findDiscount]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_findDiscount] 
@DieuKien varchar(200)
as
begin
	select * from discount where codeDiscount =@DieuKien
end
GO
/****** Object:  StoredProcedure [dbo].[sp_findTheTimeOfUser]    Script Date: 11/26/2022 1:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_findTheTimeOfUser] 
@DieuKien varchar(200)
as
begin
	select * from TheTimeUsed where username =@DieuKien
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã khách hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mật khẩu đăng nhập' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Họ và tên' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'COLUMN',@level2name=N'Fullname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hình ảnh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Accounts', @level2type=N'COLUMN',@level2name=N'Photo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã loại' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Categories', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên tiếng Việt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Categories', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã chi tiết' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OrderDetails', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã hóa đơn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OrderDetails', @level2type=N'COLUMN',@level2name=N'OrderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OrderDetails', @level2type=N'COLUMN',@level2name=N'ProductId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn giá bán' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OrderDetails', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số lượng mua' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OrderDetails', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã hóa đơn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã khách hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày đặt hàng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Địa chỉ nhận' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Orders', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên hàng hóa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hình ảnh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Image'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn giá' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sản xuất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đang kinh doanh ?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'Available'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã loại, FK' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Products', @level2type=N'COLUMN',@level2name=N'CategoryId'
GO
USE [master]
GO
ALTER DATABASE [Furniture_Sales] SET  READ_WRITE 
GO
