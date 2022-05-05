-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** SCALE_CONSTRAINTS
CREATE VIEW SCALE_CONSTRAINTS AS

SELECT

COUNTDAYOFWEEK($start_date,$end_date,0) AS MODEL_SUNDAYS,

COUNTDAYOFWEEK($start_date,$end_date,1) AS MODEL_MONDAYS,

COUNTDAYOFWEEK($start_date,$end_date,2) AS MODEL_TUESDAYS,

COUNTDAYOFWEEK($start_date,$end_date,3) AS MODEL_WEDNESDAYS,

COUNTDAYOFWEEK($start_date,$end_date,4) AS MODEL_THURSDAYS,

COUNTDAYOFWEEK($start_date,$end_date,5) AS MODEL_FRIDAYS,

COUNTDAYOFWEEK($start_date,$end_date,6) AS MODEL_SATURDAYS,

countdays($start_date,$end_date,0) AS MODEL_WEEKDAYS,

--Subtract one day to make sure we don't include the extra day e.g. 1 month from 4/1 -> 5/1 -> 4/30

countdays($start_date, DATEADD(day,-1,DATEADD(month,1, $start_date)),0) AS MONTHLY_WEEKDAYS,

countdays($start_date, DATEADD(day,-1,DATEADD(month,1, $start_date)),1) AS MONTHLY_SATURDAYS,

countdays($start_date, DATEADD(day,-1,DATEADD(quarter,1, $start_date)),0) AS QTR_WEEKDAYS,

countdays($start_date, DATEADD(day,-1,DATEADD(quarter,1, $start_date)),1) AS QTR_SATURDAYS,

countdays($start_date, DATEADD(day,-1,DATEADD(year,1, $start_date)),0) AS YEARLY_WEEKDAYS,

countdays($start_date, DATEADD(day,-1,DATEADD(year,1, $start_date)),1) AS YEARLY_SATURDAYS,

(MODEL_WEEKDAYS + MODEL_SATURDAYS) AS DAILY_FACTOR,

(MODEL_WEEKDAYS + MODEL_SATURDAYS)/(MONTHLY_WEEKDAYS + MONTHLY_SATURDAYS) AS MONTHLY_FACTOR,

(MODEL_WEEKDAYS + MODEL_SATURDAYS)/(QTR_WEEKDAYS + QTR_SATURDAYS) AS QTR_FACTOR,

(MODEL_WEEKDAYS + MODEL_SATURDAYS)/(YEARLY_WEEKDAYS + YEARLY_SATURDAYS) AS YEARLY_FACTOR,

1 AS FACTOR;
