/****** Object:  Table [dbo].[Assets]  Create the Asset Table *****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assets](
	[assetID] int IDENTITY(1,1) PRIMARY KEY,
    [assetName] [nvarchar](50) NOT NULL,
    [assetType]  [nvarchar](50) NOT NULL,
    [locationName] [nvarchar](50) NULL,
    [locationLatitude] [int] NULL,
    [locationLongitude] [int] NULL,
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

