/***** This Script will map data using the Calendar **********/

/***** Creates a min Calendar for the Task Week **********/
SELECT [dateTimeUTC]
      ,[summerWinter]
      ,[dateTimeLocal]
      ,[year]
      ,[monthNum]
      ,[monthName]
      ,[weekNumber]
      ,[dayOfWeek]
      ,[dayOfWeekNumber]
      ,[hourText]
      ,[hourNumber]
      ,[settlementPeriod]
      ,[timeOfDayLocal]
      ,[bankHoliday]
      ,[workingDay]
  INTO    task0ForecastCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeLocal] => '2018-07-23' AND [dateTimeLocal] < '2018-07-30'
  GO


/***** Creates a Calendar for the Training Data **********/
SELECT [dateTimeUTC]
      ,[summerWinter]
      ,[dateTimeLocal]
      ,[year]
      ,[monthNum]
      ,[monthName]
      ,[weekNumber]
      ,[dayOfWeek]
      ,[dayOfWeekNumber]
      ,[hourText]
      ,[hourNumber]
      ,[settlementPeriod]
      ,[timeOfDayLocal]
      ,[bankHoliday]
      ,[workingDay]
  INTO    task0TrainingCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeLocal] < '2018-07-23'
  GO

/***** Convert the Weather Data to Half Hourly **********/
CREATE VIEW viewHHWeather_train_set0 AS
SELECT b.dateTimeUTC
	, ISNULL(a.[temp_location3],0) AS 'temp_location3'
      ,ISNULL(a.[temp_location6],0) AS 'temp_location6'
      ,ISNULL(a.[temp_location2],0) AS 'temp_location2'
      ,ISNULL(a.[temp_location4],0) AS 'temp_location4'
      ,ISNULL(a.[temp_location5],0) AS 'temp_location5'
      ,ISNULL(a.[temp_location1],0) AS 'temp_location1'
      ,ISNULL(a.[solar_location3],0) AS 'solar_location3'
      ,ISNULL(a.[solar_location6],0) AS 'solar_location6'
      ,ISNULL(a.[solar_location2],0) AS 'solar_location2'
      ,ISNULL(a.[solar_location4],0) AS 'solar_location4'
      ,ISNULL(a.[solar_location5],0) AS 'solar_location5'
      ,ISNULL(a.[solar_location1],0) AS 'solar_location1'
FROM [dbo].[CalendarMap] b
JOIN dbo.weather_train_set0 a
ON CAST(b.dateTimeUTC AS Date) = CAST(a.dateTimeUTC AS Date)
AND DATEPART(HOUR,b.dateTimeUTC) = DATEPART(HOUR,a.dateTimeUTC)
GO
SELECT  *
INTO    weather_train_set0_HH
FROM    viewHHWeather_train_set0
DROP VIEW [dbo].[viewHHWeather_train_set0]
GO


/***** Add the Weather Data into the Training Calendar **********/

CREATE VIEW viewtask0TrainingCalendarWeather_train_set0_HH AS
SELECT a.[dateTimeUTC]
      ,[temp_location3]
      ,[temp_location6]
      ,[temp_location2]
      ,[temp_location4]
      ,[temp_location5]
      ,[temp_location1]
      ,[solar_location3]
      ,[solar_location6]
      ,[solar_location2]
      ,[solar_location4]
      ,[solar_location5]
      ,[solar_location1]
	  ,[summerWinter]
      ,[dateTimeLocal]
      ,[year]
      ,[monthNum]
      ,[monthName]
      ,[weekNumber]
      ,[dayOfWeek]
      ,[dayOfWeekNumber]
      ,[hourText]
      ,[hourNumber]
      ,[settlementPeriod]
      ,[timeOfDayLocal]
      ,[bankHoliday]
      ,[workingDay]
	  
FROM  [dbo].[weather_train_set0_HH] a, [dbo].[pv_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task0TrainingCalendarWeather_train_set0_HH
FROM    viewtask0TrainingCalendarWeather_train_set0_HH
DROP VIEW [dbo].[viewtask0TrainingCalendarWeather_train_set0_HH]
GO


/***** Add the PV Data into the Weather Training Calendar **********/
CREATE VIEW viewtask0TrainingCalendarPVWeather_train_set0_HH AS
SELECT a.[dateTimeUTC]
	   ,[rawPV_power_mw]
      ,[temp_location3]
      ,[temp_location6]
      ,[temp_location2]
      ,[temp_location4]
      ,[temp_location5]
      ,[temp_location1]
      ,[solar_location3]
      ,[solar_location6]
      ,[solar_location2]
      ,[solar_location4]
      ,[solar_location5]
      ,[solar_location1]
	  ,[summerWinter]
      ,[dateTimeLocal]
      ,[year]
      ,[monthNum]
      ,[monthName]
      ,[weekNumber]
      ,[dayOfWeek]
      ,[dayOfWeekNumber]
      ,[hourText]
      ,[hourNumber]
      ,[settlementPeriod]
      ,[timeOfDayLocal]
      ,[bankHoliday]
      ,[workingDay]
FROM  task0TrainingCalWeatherHH a, [dbo].[pv_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC

SELECT  *
INTO    task0TrainingCalendarPVWeatherHH
FROM    [dbo].[viewtask0TrainingCalendarPVWeather_train_set0_HH]
DROP VIEW [dbo].[viewtask0TrainingCalendarPVWeather_train_set0_HH]
GO







CREATE VIEW viewCalDemand_train_set0 AS
SELECT rawDemand_MW, a.dateTimeUTC,dateTimeLocal,"year",monthName,dayOfWeek,hourNumber,settlementPeriod,timeofDayLocal,bankHoliday, workingDay    
FROM  [dbo].[CalendarMap] a, [dbo].[demand_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC


SELECT  *
INTO    calDemand_train_set0
FROM    viewCalDemand_train_set0


CREATE VIEW viewPVCalDemand_train_set0 AS
SELECT rawDemand_MW, rawIrradiance_Wm_2, raPV_power_mw,rawPanel_temp_C,  a.dateTimeUTC,dateTimeLocal,"year","monthName","dayOfWeek",hourNumber,settlementPeriod,timeofDayLocal,bankHoliday, workingDay    
FROM  [dbo].[calDemand_train_set0] a, [dbo].[pv_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC

SELECT  *
INTO    calPVDemand_train_set0
FROM    viewPVCalDemand_train_set0


CREATE VIEW viewWeatherPVCalDemand_train_set0 AS
SELECT rawDemand_MW, rawIrradiance_Wm_2, raPV_power_mw,rawPanel_temp_C,  a.dateTimeUTC,dateTimeLocal,"year","monthName","dayOfWeek",hourNumber,settlementPeriod,timeofDayLocal,bankHoliday, workingDay,[rawTemp_location3]
      ,[rawTemp_location6]
      ,[rawTemp_location2]
      ,[rawTemp_location4]
      ,[rawTemp_location5]
      ,[rawTemp_location1]
      ,[rawTolar_location3]
      ,[rawSolar_location6]
      ,[rawSolar_location2]
      ,[rawSolar_location4]
      ,[rawSolar_location5]
      ,[rawSolar_location1]    
FROM  [dbo].[calPVDemand_train_set0] a, [dbo].[weather_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    WeatherPVCalDemand_train_set0
FROM    viewWeatherPVCalDemand_train_set0


/***** This query wil conver weather forecasts into half hourly data **********/
CREATE VIEW viewHHWeather_train_set0 AS
SELECT b.dateTimeUTC
	, ISNULL(a.[rawTemp_location3],0) AS 'rawTemp_location3'
      ,ISNULL(a.[rawTemp_location6],0) AS 'rawTemp_location6'
      ,ISNULL(a.[rawTemp_location2],0) AS 'rawTemp_location2'
      ,ISNULL(a.[rawTemp_location4],0) AS 'rawTemp_location4'
      ,ISNULL(a.[rawTemp_location5],0) AS 'rawTemp_location5'
      ,ISNULL(a.[rawTemp_location1],0) AS 'rawTemp_location1'
      ,ISNULL(a.[rawTolar_location3],0) AS 'rawSolar_location3'
      ,ISNULL(a.[rawSolar_location6],0) AS 'rawSolar_location6'
      ,ISNULL(a.[rawSolar_location2],0) AS 'rawSolar_location2'
      ,ISNULL(a.[rawSolar_location4],0) AS 'rawSolar_location4'
      ,ISNULL(a.[rawSolar_location5],0) AS 'rawSolar_location5'
      ,ISNULL(a.[rawSolar_location1],0) AS 'rawSolar_location1'
FROM dbo.CalendarMap b
JOIN dbo.weather_train_set0 a
ON CAST(b.dateTimeUTC AS Date) = CAST(a.dateTimeUTC AS Date)
AND DATEPART(HOUR,b.dateTimeUTC) = DATEPART(HOUR,a.dateTimeUTC)
GO
SELECT  *
INTO    HHWeather_train_set0
FROM    viewHHWeather_train_set0

