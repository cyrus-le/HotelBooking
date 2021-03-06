USE [master]
GO
/****** Object:  Database [Hotel]    Script Date: 10/10/2021 11:38:43 PM ******/
CREATE DATABASE [Hotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Hotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Hotel] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Hotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hotel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hotel] SET  MULTI_USER 
GO
ALTER DATABASE [Hotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hotel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hotel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hotel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Hotel] SET QUERY_STORE = OFF
GO
USE [Hotel]
GO
/****** Object:  Table [dbo].[tblCart]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCart](
	[userID] [varchar](100) NOT NULL,
	[hotelID] [int] NOT NULL,
	[roomType] [int] NOT NULL,
	[fromDate] [datetime] NOT NULL,
	[toDate] [datetime] NOT NULL,
	[cartQuantity] [int] NOT NULL,
	[itemStatus] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiscount]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscount](
	[codeId] [int] IDENTITY(1,1) NOT NULL,
	[codeName] [varchar](50) NOT NULL,
	[discountPercent] [int] NOT NULL,
	[dateCreate] [date] NOT NULL,
	[expiryDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFeedback]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedback](
	[feedbackID] [int] IDENTITY(1,1) NOT NULL,
	[point] [int] NULL,
	[orderDetailID] [int] NULL,
	[userID] [varchar](100) NULL,
	[hotelID] [int] NULL,
 CONSTRAINT [PK_tblFeedback] PRIMARY KEY CLUSTERED 
(
	[feedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHotel]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHotel](
	[hotelID] [int] IDENTITY(1,1) NOT NULL,
	[hotelName] [nvarchar](100) NOT NULL,
	[hotelAddress] [nvarchar](200) NOT NULL,
	[hotelImage] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[hotelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHotelDetails]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHotelDetails](
	[hotelID] [int] NOT NULL,
	[roomType] [int] NOT NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[hotelRoomStatus] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[userID] [varchar](100) NOT NULL,
	[orderID] [varchar](8) NOT NULL,
	[orderStatus] [bit] NOT NULL,
	[bookingDateTime] [datetime] NOT NULL,
	[discountCodeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetails](
	[orderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [varchar](8) NOT NULL,
	[fromDate] [datetime] NOT NULL,
	[toDate] [datetime] NOT NULL,
	[roomID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[roomPrice] [int] NOT NULL,
	[hotelID] [int] NOT NULL,
	[checkoutCode] [varchar](50) NULL,
 CONSTRAINT [PK__tblOrder__E4FEDE2A3277A610] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [int] NOT NULL,
	[roleName] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoom]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoom](
	[roomID] [int] IDENTITY(1,1) NOT NULL,
	[roomName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 10/10/2021 11:38:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[roleID] [int] NOT NULL,
	[userID] [varchar](100) NOT NULL,
	[userPassword] [varchar](64) NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[userAddress] [nvarchar](200) NOT NULL,
	[userEmail] [nvarchar](100) NOT NULL,
	[userCreateDate] [datetime] NOT NULL,
	[userStatus] [bit] NOT NULL,
	[userPhoneNumber] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 7, 1, CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 1, CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 7, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-06T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 6, 1, CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-06T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-06T23:59:00.000' AS DateTime), 3, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-10-25T00:00:00.000' AS DateTime), CAST(N'2020-11-27T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-10-22T00:00:00.000' AS DateTime), CAST(N'2020-10-26T23:59:00.000' AS DateTime), 11, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-30T23:59:00.000' AS DateTime), 11, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 1, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 7, 1, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 2, CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-29T23:59:00.000' AS DateTime), 8, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-29T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-25T23:59:00.000' AS DateTime), 11, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 7, 3, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 3, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 6, 2, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-16T23:59:00.000' AS DateTime), 13, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 2, CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(N'2020-11-13T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 7, 2, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 49, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'testuser', 4, 1, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'testuser', 4, 2, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 4, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-11-25T00:00:00.000' AS DateTime), CAST(N'2020-11-27T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 1, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 2, CAST(N'2020-10-31T00:00:00.000' AS DateTime), CAST(N'2020-11-02T23:59:00.000' AS DateTime), 30, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 3, CAST(N'2020-10-31T00:00:00.000' AS DateTime), CAST(N'2020-11-02T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 6, 1, CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 4, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 4, 1, CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 3, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 2, CAST(N'2020-11-10T00:00:00.000' AS DateTime), CAST(N'2020-11-20T23:59:00.000' AS DateTime), 5, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'testuser', 5, 1, CAST(N'2020-11-24T00:00:00.000' AS DateTime), CAST(N'2020-11-26T23:59:00.000' AS DateTime), 11, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-10-25T00:00:00.000' AS DateTime), CAST(N'2020-10-30T23:59:00.000' AS DateTime), 9, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 1, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 5, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 3, 2, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'nhatquang27', 5, 1, CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 6, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 3, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 4, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 5, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 3, 2, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 7, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 6, 1, CAST(N'2020-12-24T00:00:00.000' AS DateTime), CAST(N'2020-12-24T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'bangmaple', 7, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 1)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 5, 1, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 3, 1, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 7, 1, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 6, 1, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 3, 2, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'lanlnh', 5, 1, CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 7, 3, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 7, 1, CAST(N'2020-12-24T00:00:00.000' AS DateTime), CAST(N'2020-12-24T23:59:00.000' AS DateTime), 7, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 7, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 6, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'bangmaple', 3, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 20, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'bangmaple', 6, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 2, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'bangmaple', 3, 2, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 6, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 4, 1, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 4, 0)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'cyrusle', 3, 2, CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 2, 1)
INSERT [dbo].[tblCart] ([userID], [hotelID], [roomType], [fromDate], [toDate], [cartQuantity], [itemStatus]) VALUES (N'knightfxcker', 4, 1, CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[tblDiscount] ON 

INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (1, N'NOELSAPDEN', 50, CAST(N'2021-10-05' AS Date), CAST(N'2021-11-09' AS Date))
INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (4, N'FINALEXAM', 25, CAST(N'2021-10-05' AS Date), CAST(N'2021-11-07' AS Date))
INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (5, N'NGAYMAIDEADLINE', 10, CAST(N'2021-10-06' AS Date), CAST(N'2021-11-06' AS Date))
INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (6, N'TODAYISDEADLINIE', 20, CAST(N'2021-10-07' AS Date), CAST(N'2021-11-07' AS Date))
INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (7, N'BERT', 25, CAST(N'2021-10-07' AS Date), CAST(N'2021-12-30' AS Date))
INSERT [dbo].[tblDiscount] ([codeId], [codeName], [discountPercent], [dateCreate], [expiryDate]) VALUES (8, N'CHRISTMASISCOMMING', 20, CAST(N'2021-10-07' AS Date), CAST(N'2021-11-25' AS Date))
SET IDENTITY_INSERT [dbo].[tblDiscount] OFF
GO
SET IDENTITY_INSERT [dbo].[tblHotel] ON 

INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (3, N'Mường Thanh', N'Nha Trang', N'MuongThanh.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (4, N'Sheraton', N'Nha Trang', N'Sheraton.png')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (5, N'The imperial hotel', N'Vung Tau', N'ImperialHotel.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (6, N'Ana Villas Dalat Resort & Spa', N'Da Lat', N'AnaVillas.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (7, N'Grand Hotel Saigon', N'Saigon', N'GrandHotel.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (8, N'Sonata Resort & Spa', N'Phan Thiet', N'SonataResort&Spa.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (9, N'Haneda Excel Hotel Tokyu', N'3-4-2 Haneda Airport, Ota-ku, 144-0041, Tokyo, Japan', N'HanedaExcelHotelTokyu.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (11, N'The Royal Park Kyoto Shijo', N'668, NIJOHANJIKICHO, SHIMOGYO-KU, 600-8412, Kyoto, Japan', N'TheRoyalParkHotelKyoto.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (12, N'Yokohama Royal Park Hotel', N'
2-2-1-3 Minatomirai Nishi-Ku Yokohama, 220-8173, Yokohama, Japan', N'YokohamaRoyalParkHotel.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (14, N'Lotte Arai Resort', N'1966, Ryozenji, Myoko city, Niigata 944-0062, 944-0062, Myoko, Japan', N'LotteAraiResort.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (15, N'Nikko Princess Kyoto', N'Karasuma Takatsuji Higashi-iru, Shimogyo-ku, kyoto-shi, 600-8096, Kyoto, Japan', N'NikkoPrincessKyoto.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (16, N'Kaga Katayamazu Onsen Kasuikyo', N'1-72-1 Ushiozumachi, 922-0412, Kaga, Japan', N'KagaKatayamazuOnsenKasuikyo.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (17, N'The Atta Terrace Club Towers', N'1079 Afuso, Onna Village, Kunigami-gun, 904-0402, Okinawa, Japan', N'TheAttaTerraceClubTowers.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (18, N'Huis Ten Bosch Hotel Europe', N'7-7 Huis Ten Bosch, Sasebo, Nagasaki, 859-3293, Sasebo, Japan', N'HuisTenBoschHotelEurope.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (19, N'InterContinental - ANA Manza Beach Resort', N'2260 Seragaki Onna-son,Kunigami-gun, 904-0493, Onna, Japan', N'ANAManzaBeachResort.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (20, N'Loisir Living Suites Seragaki', N'1860-4 Seragaki, Onna-son, 904-0404, Onna, Japan', N'LoisirLivingSuitesSeragaki.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (21, N'The Celestine Ginza', N'8-4-22 Ginza, 104-0061, Tokyo, Japan', N'TheCelestineGinza.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (22, N'Hotel Dormy Inn Tomakomai', N'2-1-22 Nishikimachi, 053-0023, Tomakomai, Japan', N'HotelDormyInnTomakomai.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (23, N'Juhachiro', N'10 Minato-machi, Gifu-shi, 500-8009, Gifu, Japan', N'Juhachiro.jpg')
INSERT [dbo].[tblHotel] ([hotelID], [hotelName], [hotelAddress], [hotelImage]) VALUES (24, N'Chisun Inn Munakata', N'992-1 Mitsuoka, 811-3414, Munakata, Japan', N'ChisunInnMunakata.jpg')
SET IDENTITY_INSERT [dbo].[tblHotel] OFF
GO
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (3, 1, 100, 20, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (3, 2, 200, 20, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (3, 3, 300, 20, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (4, 1, 150, 30, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (4, 2, 250, 30, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (4, 3, 350, 30, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (5, 1, 450, 25, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (5, 1, 550, 10, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (5, 3, 650, 20, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (6, 1, 450, 25, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (6, 2, 550, 25, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (6, 3, 650, 25, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (7, 1, 400, 50, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (7, 2, 500, 50, 1)
INSERT [dbo].[tblHotelDetails] ([hotelID], [roomType], [price], [quantity], [hotelRoomStatus]) VALUES (7, 3, 600, 50, 0)
GO
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'0TzHP0ox', 1, CAST(N'2021-10-10T17:37:42.167' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'0VvMBMHY', 1, CAST(N'2021-10-10T05:29:21.523' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'1wWAMPBS', 1, CAST(N'2021-10-10T17:38:18.427' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'2dnBwoUK', 1, CAST(N'2021-10-10T05:14:44.530' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'3Id26SD6', 1, CAST(N'2021-10-10T16:06:39.773' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'3Rjp9BhI', 1, CAST(N'2021-10-10T05:25:56.200' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'3s6DJaqS', 1, CAST(N'2021-10-10T05:36:22.647' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'4x2jNet4', 1, CAST(N'2020-11-07T10:18:39.197' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'lanlnh', N'5N65cSIg', 1, CAST(N'2020-12-22T20:22:45.500' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'6ybo8bix', 1, CAST(N'2021-10-10T17:14:58.240' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'6ynALIBt', 1, CAST(N'2020-11-07T10:37:53.857' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'7rvazmrc', 1, CAST(N'2021-10-10T16:33:47.373' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'9RRRUlJm', 1, CAST(N'2021-10-10T16:16:02.070' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'9xVtUoKf', 1, CAST(N'2021-10-10T16:33:44.113' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'abcdefgh', 0, CAST(N'2020-11-01T18:08:35.163' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'bangmaple', N'ageog4Tt', 1, CAST(N'2020-12-25T04:20:53.087' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'aTD6wGEB', 0, CAST(N'2020-12-22T12:22:54.800' AS DateTime), 7)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'B9vToq1Q', 1, CAST(N'2021-10-10T15:46:33.473' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'bdDaexqx', 1, CAST(N'2021-10-10T15:29:24.337' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'bangmaple', N'BJ5rINzV', 1, CAST(N'2020-12-25T04:23:53.300' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'bangmaple', N'bOV3ZwvS', 1, CAST(N'2020-12-25T04:27:46.340' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'BPLOyGP5', 0, CAST(N'2020-11-06T22:05:08.670' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'c94QUdpK', 1, CAST(N'2020-11-07T10:59:05.877' AS DateTime), 7)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'cfonYzGy', 1, CAST(N'2020-11-07T10:39:20.783' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'CxE4XHOc', 1, CAST(N'2021-10-10T16:33:46.470' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'DFf4cYHN', 1, CAST(N'2020-12-22T17:35:13.770' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'dOYpaW1n', 1, CAST(N'2021-10-10T17:32:53.383' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'E4wa34US', 1, CAST(N'2021-10-10T05:36:52.190' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'eq6G5aJY', 1, CAST(N'2021-10-10T17:16:52.700' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'essR9lZ5', 1, CAST(N'2021-10-10T19:56:15.930' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'EXtL1ouQ', 1, CAST(N'2021-10-10T05:23:19.720' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'FMfxIRLI', 1, CAST(N'2021-10-10T16:06:40.500' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'g4nPIZHC', 1, CAST(N'2021-10-10T05:37:29.777' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'GAvvcMou', 1, CAST(N'2021-10-10T05:36:20.800' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'Ge510W2S', 1, CAST(N'2021-10-10T16:06:23.577' AS DateTime), 8)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'gXM5mER8', 1, CAST(N'2021-10-10T05:52:59.590' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'GZxnSQyC', 1, CAST(N'2021-10-10T16:15:58.853' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'HRgsfrlz', 0, CAST(N'2020-11-01T18:08:35.163' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'hz81J281', 1, CAST(N'2020-12-22T20:28:29.547' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'IaEbvpV1', 1, CAST(N'2021-10-10T16:33:48.023' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'k9r2tOyX', 1, CAST(N'2020-11-07T10:55:43.840' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'KHICm8Ok', 1, CAST(N'2020-11-01T18:08:35.163' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'kOYVjriD', 1, CAST(N'2021-10-10T19:17:19.717' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'KTzIPIjK', 0, CAST(N'2021-10-10T18:39:13.163' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'lOefKW1x', 1, CAST(N'2021-10-10T15:52:38.967' AS DateTime), 8)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'lUTxVCgJ', 1, CAST(N'2021-10-10T20:15:10.920' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'lzrbffbb', 1, CAST(N'2021-10-10T05:25:28.483' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'MibLhhdq', 1, CAST(N'2020-11-07T10:20:13.720' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'NBTuHPOs', 1, CAST(N'2021-10-10T19:37:53.263' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'nMjF6Fv2', 1, CAST(N'2021-10-10T19:16:29.873' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'of7tmLQy', 1, CAST(N'2020-12-22T13:40:33.890' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'OK31szKF', 1, CAST(N'2021-10-10T19:33:55.057' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'oLp5DCqI', 0, CAST(N'2021-10-10T18:54:42.590' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'PRmHolRj', 1, CAST(N'2020-12-22T14:12:52.417' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'QEU35Sa8', 1, CAST(N'2020-11-01T18:08:35.163' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'testuser', N'QOjprsOW', 1, CAST(N'2020-11-07T13:29:37.983' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'lanlnh', N'QrADemzN', 1, CAST(N'2020-12-22T20:14:50.703' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'QRuGTqIv', 0, CAST(N'2020-11-01T18:13:09.267' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'qVmfsxYQ', 1, CAST(N'2020-11-07T12:39:11.477' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'testuser', N'RJCx0jRa', 1, CAST(N'2020-11-07T13:39:37.747' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'RJGBEtQy', 1, CAST(N'2020-12-22T21:17:48.620' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'RKaF8P8F', 1, CAST(N'2021-10-10T20:19:43.707' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'rKkGSCDi', 1, CAST(N'2021-10-10T16:17:11.367' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'bangmaple', N's1VbJvHo', 1, CAST(N'2020-12-25T04:43:12.533' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'scarIRIE', 1, CAST(N'2021-10-10T20:21:03.123' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'T3LQowWM', 1, CAST(N'2020-11-07T14:05:27.113' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'TCpOHrIJ', 1, CAST(N'2021-10-10T15:46:30.210' AS DateTime), 4)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'ti8nn6tl', 0, CAST(N'2020-11-05T11:41:00.440' AS DateTime), 1)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'UC9SXRen', 1, CAST(N'2020-12-22T17:34:12.093' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'UMn2lQxi', 1, CAST(N'2021-10-10T19:23:42.230' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'uRGlPvev', 1, CAST(N'2021-10-10T19:29:23.853' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'uWURvR48', 1, CAST(N'2020-12-22T20:08:49.217' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'Uxz7VLwa', 1, CAST(N'2021-10-10T17:01:32.377' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'V9URYU6B', 0, CAST(N'2021-10-10T16:26:14.540' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'W66D5AW7', 1, CAST(N'2021-10-10T16:25:07.260' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'wicbLnqi', 1, CAST(N'2021-10-10T18:33:01.513' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'wiPCOBCA', 1, CAST(N'2021-10-10T16:33:47.693' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'cyrusle', N'WU8gI2Qi', 1, CAST(N'2020-12-22T19:29:13.743' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'wwuF1VAf', 1, CAST(N'2021-10-10T18:39:00.837' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'X2SN3vym', 1, CAST(N'2021-10-10T17:00:05.147' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'x9umWcaM', 1, CAST(N'2021-10-10T20:24:13.427' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'XGmxSMXo', 1, CAST(N'2021-10-10T16:59:29.360' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'xJTAcJkQ', 1, CAST(N'2021-10-10T17:01:51.527' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'xjyH7eMW', 1, CAST(N'2021-10-10T15:14:41.513' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'yFVJWCEe', 1, CAST(N'2021-10-10T16:33:47.137' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'YPdIDXgf', 1, CAST(N'2021-10-10T05:16:19.150' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'za6WP226', 1, CAST(N'2021-10-10T19:11:28.410' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'ZuyYCZZ5', 1, CAST(N'2021-10-10T20:40:31.993' AS DateTime), NULL)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'nhatquang27', N'ZY6PerUP', 1, CAST(N'2020-11-07T14:05:43.950' AS DateTime), 4)
INSERT [dbo].[tblOrder] ([userID], [orderID], [orderStatus], [bookingDateTime], [discountCodeId]) VALUES (N'knightfxcker', N'ZYAKb4cd', 1, CAST(N'2021-10-10T05:20:29.863' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[tblOrderDetails] ON 

INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (2, N'abcdefgh', CAST(N'2020-10-22T00:00:00.000' AS DateTime), CAST(N'2020-10-26T23:59:00.000' AS DateTime), 1, 10, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (5, N'KHICm8Ok', CAST(N'2020-11-01T17:59:39.233' AS DateTime), CAST(N'2020-11-01T17:59:39.233' AS DateTime), 2, 1, 1000, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (6, N'QEU35Sa8', CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 1, 1, 450, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (7, N'QEU35Sa8', CAST(N'2020-11-25T00:00:00.000' AS DateTime), CAST(N'2020-11-27T23:59:00.000' AS DateTime), 1, 2, 450, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (8, N'HRgsfrlz', CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 1, 1, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (9, N'QRuGTqIv', CAST(N'2020-11-01T00:00:00.000' AS DateTime), CAST(N'2020-11-01T23:59:00.000' AS DateTime), 1, 2, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (14, N'ti8nn6tl', CAST(N'2020-11-05T00:00:00.000' AS DateTime), CAST(N'2020-11-05T23:59:00.000' AS DateTime), 1, 1, 450, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (15, N'BPLOyGP5', CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-06T23:59:00.000' AS DateTime), 1, 2, 450, 6, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (16, N'4x2jNet4', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 2, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (17, N'4x2jNet4', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 400, 7, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (18, N'MibLhhdq', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 2, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (19, N'MibLhhdq', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 400, 7, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (20, N'6ynALIBt', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 400, 7, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (21, N'cfonYzGy', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (22, N'k9r2tOyX', CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-29T23:59:00.000' AS DateTime), 1, 8, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (23, N'c94QUdpK', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 3, 1, 600, 7, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (24, N'qVmfsxYQ', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 400, 7, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (25, N'qVmfsxYQ', CAST(N'2020-10-23T00:00:00.000' AS DateTime), CAST(N'2020-10-29T23:59:00.000' AS DateTime), 1, 1, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (26, N'qVmfsxYQ', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-16T23:59:00.000' AS DateTime), 2, 13, 550, 6, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (27, N'QOjprsOW', CAST(N'2020-11-24T00:00:00.000' AS DateTime), CAST(N'2020-11-26T23:59:00.000' AS DateTime), 1, 11, 450, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (28, N'RJCx0jRa', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 2, 4, 250, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (29, N'T3LQowWM', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(N'2020-11-13T23:59:00.000' AS DateTime), 2, 2, 550, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (30, N'ZY6PerUP', CAST(N'2020-11-07T00:00:00.000' AS DateTime), CAST(N'2020-11-07T23:59:00.000' AS DateTime), 1, 1, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (31, N'aTD6wGEB', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 450, 6, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (32, N'of7tmLQy', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 2, 450, 6, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (33, N'of7tmLQy', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 19, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (34, N'of7tmLQy', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (35, N'PRmHolRj', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 9, 450, 6, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (36, N'UC9SXRen', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 450, 5, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (37, N'UC9SXRen', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 100, 3, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (38, N'DFf4cYHN', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 150, 4, NULL)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (39, N'WU8gI2Qi', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 150, 4, N'399546')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (40, N'WU8gI2Qi', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 2, 1, 200, 3, N'098492')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (41, N'uWURvR48', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'963029')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (42, N'QrADemzN', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'167200')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (43, N'5N65cSIg', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'934882')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (44, N'hz81J281', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 1, 1, 150, 4, N'647036')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (45, N'RJGBEtQy', CAST(N'2020-12-22T00:00:00.000' AS DateTime), CAST(N'2020-12-22T23:59:00.000' AS DateTime), 2, 2, 200, 3, N'908330')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (46, N'ageog4Tt', CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 20, 100, 3, N'216222')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (47, N'BJ5rINzV', CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'112132')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (48, N'bOV3ZwvS', CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'942582')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (49, N's1VbJvHo', CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 2, 1, 200, 3, N'099556')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (50, N's1VbJvHo', CAST(N'2020-12-25T00:00:00.000' AS DateTime), CAST(N'2020-12-25T23:59:00.000' AS DateTime), 1, 2, 450, 6, N'411649')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (51, N'2dnBwoUK', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 1, 600, 7, N'909460')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (52, N'YPdIDXgf', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 1, 600, 7, N'010590')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (53, N'ZYAKb4cd', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 1, 600, 7, N'232907')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (54, N'EXtL1ouQ', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 1, 600, 7, N'417307')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (55, N'lzrbffbb', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 3, 1, 600, 7, N'181202')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (56, N'3Rjp9BhI', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'780797')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (57, N'0VvMBMHY', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'774727')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (58, N'GAvvcMou', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'118001')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (59, N'3s6DJaqS', CAST(N'2021-09-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'680402')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (60, N'E4wa34US', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'535370')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (61, N'g4nPIZHC', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'675177')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (62, N'gXM5mER8', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'873890')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (63, N'xjyH7eMW', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 100, 3, N'409267')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (64, N'bdDaexqx', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 1, 200, 3, N'029640')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (65, N'TCpOHrIJ', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'894731')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (66, N'B9vToq1Q', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'968094')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (67, N'lOefKW1x', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'337421')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (68, N'Ge510W2S', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'238183')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (69, N'3Id26SD6', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'041642')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (70, N'FMfxIRLI', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 2, 3, 200, 3, N'421158')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (71, N'GZxnSQyC', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'537694')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (72, N'9RRRUlJm', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'343392')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (73, N'rKkGSCDi', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'874420')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (74, N'W66D5AW7', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'597249')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (75, N'V9URYU6B', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'407204')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (76, N'9xVtUoKf', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'868541')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (77, N'CxE4XHOc', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'307701')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (78, N'yFVJWCEe', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'906438')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (79, N'7rvazmrc', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'897333')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (80, N'wiPCOBCA', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'417550')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (81, N'IaEbvpV1', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'468903')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (82, N'XGmxSMXo', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'478523')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (83, N'X2SN3vym', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'142323')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (84, N'Uxz7VLwa', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'744394')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (85, N'xJTAcJkQ', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'766792')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (86, N'6ybo8bix', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'701209')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (87, N'eq6G5aJY', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'724097')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (88, N'dOYpaW1n', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'429947')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (89, N'0TzHP0ox', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'832480')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (90, N'1wWAMPBS', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'232372')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (91, N'wicbLnqi', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'362341')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (92, N'wwuF1VAf', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'796545')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (93, N'KTzIPIjK', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'619237')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (94, N'oLp5DCqI', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'784523')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (95, N'za6WP226', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'670113')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (96, N'nMjF6Fv2', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'088370')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (97, N'kOYVjriD', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'799628')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (98, N'UMn2lQxi', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'615925')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (99, N'uRGlPvev', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'990143')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (100, N'OK31szKF', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'623688')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (101, N'NBTuHPOs', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'454811')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (102, N'essR9lZ5', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'267945')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (103, N'lUTxVCgJ', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'026154')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (104, N'RKaF8P8F', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 6, N'665400')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (105, N'scarIRIE', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 450, 5, N'538697')
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (106, N'x9umWcaM', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 150, 4, N'708463')
GO
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [orderID], [fromDate], [toDate], [roomID], [quantity], [roomPrice], [hotelID], [checkoutCode]) VALUES (107, N'ZuyYCZZ5', CAST(N'2021-10-10T00:00:00.000' AS DateTime), CAST(N'2021-10-10T23:59:00.000' AS DateTime), 1, 1, 150, 4, N'028781')
SET IDENTITY_INSERT [dbo].[tblOrderDetails] OFF
GO
INSERT [dbo].[tblRole] ([roleID], [roleName]) VALUES (1, N'Admin')
INSERT [dbo].[tblRole] ([roleID], [roleName]) VALUES (2, N'Member')
GO
SET IDENTITY_INSERT [dbo].[tblRoom] ON 

INSERT [dbo].[tblRoom] ([roomID], [roomName]) VALUES (1, N'Single')
INSERT [dbo].[tblRoom] ([roomID], [roomName]) VALUES (2, N'Double')
INSERT [dbo].[tblRoom] ([roomID], [roomName]) VALUES (3, N'Family')
SET IDENTITY_INSERT [dbo].[tblRoom] OFF
GO
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'', N'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', N'', N'', N'', CAST(N'2021-10-10T03:12:45.453' AS DateTime), 1, N'')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'bangmaple', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'BangMAple', N'HCMCCCC', N'bangmapleproject@gmail.com', CAST(N'2021-09-25T04:19:23.263' AS DateTime), 1, N'0961618601')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (1, N'cyrusle', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'Cyrus Le', N'Saigon', N'kazuocyrus@gmail.com', CAST(N'2021-09-22T11:56:31.430' AS DateTime), 1, N'0916344389')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'knightfxcker', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'Cyrus Le', N'Nha Trang City', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-10T04:33:45.230' AS DateTime), 1, N'1234567890')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'lanlnh', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'Cyrus Le', N'Saigon', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-09-22T20:14:38.183' AS DateTime), 1, N'0916344389')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'nhatquang27', N'df026d4714f12bac8069b9c12a0f65fc469dd6e5b01d369debcabc6b04c12eb9', N'Doan Nhat Quang', N'Shibuya, Tokyo, Japan', N'doannhatquang27@gmail.com', CAST(N'2021-09-21T08:04:52.483' AS DateTime), 1, N'0964433023')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'testuser', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Doan Nhat Quang', N'Shibuya, Tokyo, Japan', N'doannhatquang27@gmail.com', CAST(N'2021-09-20T18:49:51.197' AS DateTime), 1, N'0964433023')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (1, N'testuser2', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Test User', N'Shinjuku', N'abcdef@gmail.com', CAST(N'2021-10-05T07:58:13.400' AS DateTime), 1, N'0123456789')
INSERT [dbo].[tblUser] ([roleID], [userID], [userPassword], [username], [userAddress], [userEmail], [userCreateDate], [userStatus], [userPhoneNumber]) VALUES (2, N'testuser3', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Test User 3', N'Shinjuku', N'abcdef@gmail.com', CAST(N'2021-10-07T14:12:14.190' AS DateTime), 1, N'0123456789')
GO
ALTER TABLE [dbo].[tblCart]  WITH CHECK ADD FOREIGN KEY([hotelID])
REFERENCES [dbo].[tblHotel] ([hotelID])
GO
ALTER TABLE [dbo].[tblCart]  WITH CHECK ADD FOREIGN KEY([roomType])
REFERENCES [dbo].[tblRoom] ([roomID])
GO
ALTER TABLE [dbo].[tblCart]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblFeedback]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedback_tblHotel] FOREIGN KEY([hotelID])
REFERENCES [dbo].[tblHotel] ([hotelID])
GO
ALTER TABLE [dbo].[tblFeedback] CHECK CONSTRAINT [FK_tblFeedback_tblHotel]
GO
ALTER TABLE [dbo].[tblFeedback]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedback_tblOrderDetails] FOREIGN KEY([orderDetailID])
REFERENCES [dbo].[tblOrderDetails] ([orderDetailID])
GO
ALTER TABLE [dbo].[tblFeedback] CHECK CONSTRAINT [FK_tblFeedback_tblOrderDetails]
GO
ALTER TABLE [dbo].[tblFeedback]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedback_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblFeedback] CHECK CONSTRAINT [FK_tblFeedback_tblUser]
GO
ALTER TABLE [dbo].[tblHotelDetails]  WITH CHECK ADD FOREIGN KEY([hotelID])
REFERENCES [dbo].[tblHotel] ([hotelID])
GO
ALTER TABLE [dbo].[tblHotelDetails]  WITH CHECK ADD FOREIGN KEY([roomType])
REFERENCES [dbo].[tblRoom] ([roomID])
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblDiscount] FOREIGN KEY([discountCodeId])
REFERENCES [dbo].[tblDiscount] ([codeId])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblDiscount]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__order__4AB81AF0] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK__tblOrderD__order__4AB81AF0]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetails_tblHotel] FOREIGN KEY([hotelID])
REFERENCES [dbo].[tblHotel] ([hotelID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_tblOrderDetails_tblHotel]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
USE [master]
GO
ALTER DATABASE [Hotel] SET  READ_WRITE 
GO
