/****** Object:  Table [dbo].[Assets]  Create the Asset Table *****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[Assets]
GO
CREATE TABLE [dbo].[Assets](
	[assetID] int IDENTITY(1,1) PRIMARY KEY,
    [assetName] [nvarchar](50) NOT NULL,
    [assetType]  [nvarchar](50) NOT NULL,
    [locationName] [nvarchar](50) NULL,
    [locationLatitude] [decimal](10, 3) NULL,
    [locationLongitude] [decimal](10, 3) NULL,
    [capacityMWh] [decimal](10, 3) NULL,
    [powerMW] [decimal](10, 3) NULL,
   	[createdDate] [datetime] NOT NULL default CURRENT_TIMESTAMP,
	[createdBy] [nvarchar](255) NOT NULL DEFAULT CURRENT_USER
)

GO

/****** Object:  Table [dbo].[Assets]  Populate the Asset Table - Battery *****/
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude, capacityMWh, powerMW)
VALUES ('BATTERY_DEVON_FARM','BATTERY', 'Devon Solar Farm',50.33,-4.034,6.000,2.500);
GO

/****** Object:  Table [dbo].[Assets]  Populate the Asset Table - Solar*****/
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude, powerMW)
VALUES ('PV_DEVON_FARM','SOLAR', 'Devon Solar Farm',50.33,-4.034, 5);
GO


/****** Object:  Table [dbo].[Assets]  Populate the Asset Table - Substation*****/
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude, powerMW)
VALUES ('SUBSTATION_STENWAY','SUBSTATION', 'Plymouth',50.364,-4.086, 999);
GO

/****** Object:  Table [dbo].[Assets]  Populate the Asset Table  - Weather Stations*****/
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_01','WEATHERSTATION', 'Weather Sation 1',50.5,-4.375)
GO
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_02','WEATHERSTATION', 'Weather Sation 2',50.5,-3.75)
GO
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_03','WEATHERSTATION', 'Weather Sation 3',51,-3.75)
GO
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_04','WEATHERSTATION', 'Weather Sation 4',51.5,-2.5)
GO
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_05','WEATHERSTATION', 'Weather Sation 5',50,-4.375)
GO
INSERT INTO [dbo].[Assets](assetName, assetType, locationName, locationLatitude, locationLongitude)
VALUES ('WEATHERSTATION_06','WEATHERSTATION', 'Weather Sation 6',50,-3.75)
GO


/****** Object:  Table [dbo].[Tasks]  Populate the Task List*****/
DROP TABLE [dbo].[Tasks]
GO
CREATE TABLE [dbo].[Tasks](
	[taskID] int IDENTITY(1,1) PRIMARY KEY,
    [taskName] [nvarchar](50) NOT NULL,
    [fromDate] [date] NOT NULL,
    [toDate]  [date] NOT NULL,
   	[createdDate] [datetime] NOT NULL default CURRENT_TIMESTAMP,
	[createdBy] [nvarchar](255) NOT NULL DEFAULT CURRENT_USER
)

GO

INSERT INTO [dbo].[Tasks](taskName, fromDate, toDate)
VALUES ('task0','2018-07-23','2018-07-29')
GO
INSERT INTO [dbo].[Tasks](taskName, fromDate, toDate)
VALUES ('task1','2018-10-16','2018-10-22')
GO
INSERT INTO [dbo].[Tasks](taskName, fromDate, toDate)
VALUES ('task2','2019-03-10','2019-03-16')
GO
INSERT INTO [dbo].[Tasks](taskName, fromDate, toDate)
VALUES ('task3','2019-12-18','2019-12-24')
GO
INSERT INTO [dbo].[Tasks](taskName, fromDate, toDate)
VALUES ('task4','2020-07-23','2020-07-09')
GO

/****** Object:  Table [dbo].[rawDemand]  Populate the Raw Demand Data*****/
CREATE TABLE [dbo].[rawDemand]
(
    [rawDemandRecordID] int IDENTITY(1,1) PRIMARY KEY,
    [rawDemandDateTimeUTC] [datetime] NOT NULL,
    [rawDemandMW] [decimal](10, 3) NULL,
    [sourceTask] [nvarchar](50) NOT NULL,
    [createdDate] [datetime] NOT NULL default CURRENT_TIMESTAMP,
	[createdBy] [nvarchar](255) NOT NULL DEFAULT CURRENT_USER
)
GO