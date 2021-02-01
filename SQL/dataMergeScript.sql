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
GO
SELECT  *
INTO    task0TrainingCalendarPVWeatherHH
FROM    [dbo].[viewtask0TrainingCalendarPVWeather_train_set0_HH]
DROP VIEW [dbo].[viewtask0TrainingCalendarPVWeather_train_set0_HH]
GO

/***** Add the Demand Data into the Weather Training Calendar **********/
CREATE VIEW viewtask0TrainingCalendarDemandWeather_train_set0_HH AS
SELECT a.[dateTimeUTC]
	   ,[rawDemand_mw]
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
FROM  task0TrainingCalWeatherHH a, [dbo].[demand_train_set0] b
WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task0TrainingCalendarDemandWeatherHH
FROM    [dbo].[viewtask0TrainingCalendarDemandWeather_train_set0_HH]
DROP VIEW [dbo].[viewtask0TrainingCalendarDemandWeather_train_set0_HH]
GO

