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
  INTO    task1ForecastCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeLocal] >= '2018-10-16' AND [dateTimeLocal] < '2018-10-23'
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


/***** Add the Weather Forecast into the Task 0 Forecast Calendar **********/
CREATE VIEW temp AS 
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
  FROM [dbo].[task1ForecastCalendarMap] a, weather_train_set1_HH b
  WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task1ForecastCalendarMapWithForecastWeatherHH
FROM    temp
DROP VIEW temp
GO



/***** Add the Weather Forecast into the Task Forecast Calendar **********/
CREATE VIEW temp AS 
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
  FROM [dbo].[task1TrainingCalendarMap] a, weather_train_set1_HH b
  WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task1TrainingCalWeatherHH
FROM    temp
DROP VIEW temp
GO


/***** Add the PV Data into the Weather Training Calendar **********/
CREATE VIEW viewtask1TrainingCalendarPVWeather_train_set1_HH AS
SELECT a.[dateTimeUTC]
	   ,[pv_power_mw]
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
FROM  [dbo].[task1TrainingCalWeatherHH] a, [dbo].[pv_train_set1] b
WHERE a.dateTimeUTC = b.[datetime]
GO
SELECT  *
INTO    task1TrainingCalendarPVWeatherHH
FROM    [dbo].[viewtask1TrainingCalendarPVWeather_train_set1_HH]
DROP VIEW [dbo].[viewtask1TrainingCalendarPVWeather_train_set1_HH]
GO


/***** Add the Demand Data into the Weather Training Calendar **********/
CREATE VIEW viewtask1TrainingCalendarDemandWeather_train_set1_HH AS
SELECT a.[dateTimeUTC]
	   ,[demand_mw]
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
FROM  task1TrainingCalWeatherHH a, [dbo].[demand_train_set1] b
WHERE a.dateTimeUTC = b.[datetime]
GO
SELECT  *
INTO    task1TrainingCalendarDemandWeatherHH
FROM    [dbo].[viewtask1TrainingCalendarDemandWeather_train_set1_HH]
DROP VIEW [dbo].[viewtask1TrainingCalendarDemandWeather_train_set1_HH]
GO


