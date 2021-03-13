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
  INTO    task4ForecastCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeUTC] >= '2020-07-3' AND [dateTimeUTC] < '2020-07-10'
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
  INTO    task4TrainingCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeLocal] < '2020-07-3'
  GO

/***** Convert the Weather Data to Half Hourly **********/
CREATE VIEW viewHHWeather_train_set4 AS
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
JOIN dbo.weather_train_set4 a
ON CAST(b.dateTimeUTC AS Date) = CAST(a.[datetime] AS Date)
AND DATEPART(HOUR,b.dateTimeUTC) = DATEPART(HOUR,a.[datetime])
GO
SELECT  *
INTO    weather_train_set4_HH
FROM    viewHHWeather_train_set4
DROP VIEW [dbo].[viewHHWeather_train_set4]
GO

/***** Add the Weather Forecast into the Task 3 Forecast Calendar **********/
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
  FROM [dbo].[task4ForecastCalendarMap] a, weather_train_set4_HH b
  WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task4ForecastCalendarMapWithForecastWeatherHH
FROM    temp
DROP VIEW temp
GO



/***** Add the Weather Forecast into the Task Training Calendar **********/
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
  FROM [dbo].[task4TrainingCalendarMap] a, weather_train_set4_HH b
  WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task4TrainingCalWeatherHH
FROM    temp
DROP VIEW temp
GO


/***** Add the PV Data into the Weather Training Calendar **********/
CREATE VIEW viewtask4TrainingCalendarPVWeather_train_set4_HH AS
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
FROM  [dbo].[task4TrainingCalWeatherHH] a, [dbo].[pv_train_set4] b
WHERE a.dateTimeUTC = b.[datetime]
GO
SELECT  *
INTO    task4TrainingCalendarPVWeatherHH
FROM    [dbo].[viewtask4TrainingCalendarPVWeather_train_set4_HH]
DROP VIEW [dbo].[viewtask4TrainingCalendarPVWeather_train_set4_HH]
GO


/***** Add the Demand Data into the Weather Training Calendar **********/
CREATE VIEW viewtask4TrainingCalendarDemandWeather_train_set4_HH AS
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
FROM  task4TrainingCalWeatherHH a, [dbo].[demand_train_set4] b
WHERE a.dateTimeUTC = b.[datetime]
GO
SELECT  *
INTO    task4TrainingCalendarDemandWeatherHH
FROM    [dbo].[viewtask4TrainingCalendarDemandWeather_train_set4_HH]
DROP VIEW [dbo].[viewtask4TrainingCalendarDemandWeather_train_set4_HH]
GO


/***** Consolidate the Forecasts Inputs by Tasks  **********/
INSERT INTO  [dbo].[10FORECASTInputsByTask] ([dateTimeUTC]
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
      ,[workingDay])
	SELECT   [dateTimeUTC]
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
  FROM task4ForecastCalendarMapWithForecastWeatherHH
  GO

  /***** Creates a Task 4 back test Week **********/
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
  INTO    task4BackTestCalendarMap
  FROM [dbo].[CalendarMap]
  WHERE [dateTimeUTC] >= '2020-06-26' AND [dateTimeUTC] < '2020-07-03'
  GO

  /***** Add the Weather Forecast into the Task 4 Back Test Calendar **********/
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
  FROM [dbo].[task4BackTestCalendarMap] a, weather_train_set4_HH b
  WHERE a.dateTimeUTC = b.dateTimeUTC
GO
SELECT  *
INTO    task4BackTestCalendarMapWithForecastWeatherHH
FROM    temp
DROP VIEW temp
GO
