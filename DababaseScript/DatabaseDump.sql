USE [master]
GO
/****** Object:  Database [MyTestingDatabase]    Script Date: 5/1/2014 4:57:41 PM ******/
CREATE DATABASE [MyTestingDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyTestingDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyTestingDatabase.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MyTestingDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyTestingDatabase_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MyTestingDatabase] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyTestingDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyTestingDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MyTestingDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyTestingDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyTestingDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyTestingDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyTestingDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [MyTestingDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [MyTestingDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyTestingDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyTestingDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyTestingDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MyTestingDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyTestingDatabase', N'ON'
GO
USE [MyTestingDatabase]
GO
/****** Object:  User [vspractive]    Script Date: 5/1/2014 4:57:41 PM ******/
CREATE USER [vspractive] FOR LOGIN [vspractive] WITH DEFAULT_SCHEMA=[TST]
GO
ALTER ROLE [db_owner] ADD MEMBER [vspractive]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [vspractive]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [vspractive]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [vspractive]
GO
ALTER ROLE [db_datareader] ADD MEMBER [vspractive]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [vspractive]
GO
/****** Object:  Schema [TST]    Script Date: 5/1/2014 4:57:41 PM ******/
CREATE SCHEMA [TST]
GO
/****** Object:  Table [TST].[CardData]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TST].[CardData](
	[CardID] [bigint] IDENTITY(1,1) NOT NULL,
	[CardNumber] [varchar](50) NULL,
	[CardUser] [bigint] NULL,
	[ExpiryDate] [date] NULL,
	[CVV2Number] [int] NULL,
 CONSTRAINT [PK_CardData] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [TST].[tblCustomer]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TST].[tblCustomer](
	[CustID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Address] [varchar](200) NULL,
	[ContactNo] [varchar](20) NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [TST].[tblOrder]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TST].[tblOrder](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[Price] [float] NULL,
	[CustomerID] [int] NULL,
	[ContactNo] [varchar](20) NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [TST].[tblProduct]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TST].[tblProduct](
	[ProductID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[UnitPrice] [float] NULL,
	[CatID] [int] NULL,
	[EntryDate] [datetime] NULL CONSTRAINT [DF_Product_EntryDate]  DEFAULT (getdate()),
	[ExpiryDate] [datetime] NULL CONSTRAINT [DF_Product_ExpiryDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [TST].[UserDetials]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TST].[UserDetials](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[First_Name] [varchar](50) NULL,
	[Last_Name] [varchar](50) NULL,
 CONSTRAINT [PK_UserDetials] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [TST].[CardData]  WITH CHECK ADD  CONSTRAINT [FK_CardData_UserDetials] FOREIGN KEY([CardUser])
REFERENCES [TST].[UserDetials] ([ID])
GO
ALTER TABLE [TST].[CardData] CHECK CONSTRAINT [FK_CardData_UserDetials]
GO
ALTER TABLE [TST].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblCustomer] FOREIGN KEY([CustomerID])
REFERENCES [TST].[tblCustomer] ([CustID])
GO
ALTER TABLE [TST].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblCustomer]
GO
/****** Object:  StoredProcedure [TST].[AutheticateUser]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TST].[AutheticateUser]
(
	@username VARCHAR(50),
	@password VARCHAR(50)
)
AS
BEGIN
	SELECT [Email] AS TOKEN FROM [TST].[UserDetials] WHERE [UserName]=@username AND Password=@password
END

GO
/****** Object:  StoredProcedure [TST].[someproc]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TST].[someproc]
AS
BEGIN
SELECT * FROM TST.TBLCUSTOMER
END
GO
/****** Object:  StoredProcedure [TST].[SP_CheckAuthenticateTranscation]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TST].[SP_CheckAuthenticateTranscation]
(
	@authtoken varchar(50),
	@cardNumber varchar(50),
	@cvv int,
	@dateOfExpiry DateTime
)
AS
BEGIN
	DECLARE @ID AS INTEGER

	SET @ID=(SELECT [ID] FROM [TST].[UserDetials] WHERE Email=@authtoken)
	print @ID
	DECLARE @NUMCUNT AS INTEGER
	SET @NUMCUNT=(SELECT COUNT(*) FROM [TST].[CardData] 
	WHERE [CardNumber]=@cardNumber AND CardUser=@ID AND CVV2Number=@cvv
	AND CONVERT(VARCHAR(10),@dateOfExpiry,111)=CONVERT(VARCHAR(10),ExpiryDate,111)
	)
	

	IF(@NUMCUNT>0)
		BEGIN
			SELECT 'Passed'
		END
	ELSE
		BEGIN
			SELECT 'fail'
		END
END
GO
/****** Object:  StoredProcedure [TST].[SP_GetAllCustomer]    Script Date: 5/1/2014 4:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TST].[SP_GetAllCustomer]
(
     @ID AS	INT	
)
AS
BEGIN
	SELECT * FROM [TST].[tblCustomer] WHERE CustID=@ID
END
GO
USE [master]
GO
ALTER DATABASE [MyTestingDatabase] SET  READ_WRITE 
GO
