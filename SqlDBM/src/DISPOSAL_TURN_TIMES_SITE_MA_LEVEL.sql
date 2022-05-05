-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** DISPOSAL_TURN_TIMES_SITE_MA_LEVEL
CREATE VIEW DISPOSAL_TURN_TIMES_SITE_MA_LEVEL as
SELECT LH_MATCHING.DISPFACID DISPFACID , LH_MATCHING.DISPFAC_TYPE,
       S.MA_ID ,L."NAME" LOB , DATEDIFF(MINUTE , ROL.ARRIVE,ROL.DEPART) TURN_TIME, 
DATEDIFF(MINUTE , ROD.DOWNSTART,ROD.DOWNEND) OVERLAP_DOWNTIME,
DATEDIFF(MINUTE , RLUNCH.LUNCHSTART,RLUNCH.LUNCHEND) OVERLAP_MEALTIME,

CASE WHEN (DOWNSTART BETWEEN LUNCHSTART AND LUNCHEND) AND (DOWNEND BETWEEN LUNCHSTART AND LUNCHEND)
     THEN OVERLAP_MEALTIME - NVL(OVERLAP_DOWNTIME, 0)
     ELSE OVERLAP_MEALTIME 
END NET_MEAL_TIME,
CASE WHEN (LUNCHSTART BETWEEN DOWNSTART AND DOWNEND) AND (LUNCHEND BETWEEN DOWNSTART AND DOWNEND)
	 THEN OVERLAP_DOWNTIME - NVL(OVERLAP_MEALTIME,0) 
	 ELSE OVERLAP_DOWNTIME
END NET_DOWN_TIME,
TURN_TIME - NVL(NET_DOWN_TIME,0) -  NVL(NET_MEAL_TIME,0) NET_TURN_TIME,
ROL.ARRIVE,ROL.DEPART, RLUNCH.LUNCHSTART,RLUNCH.LUNCHEND
FROM STG.TP_RO_LANDFILL ROL
JOIN STG.TP_ROUTEORDER  RO 
ON RO.PKEY =ROL.FK_ROUTEORDER 
AND Ro.statuscode = 'CONFIRMED'
AND ROL.FK_VEHICLE IS NULL 
AND ro.ORDERDATE  BETWEEN dateadd('DAY' , -366, GETDATE()) AND dateadd('DAY' , -1, GETDATE())
JOIN STG.TP_ROUTE R 
ON R.PKEY = RO.FK_ROUTE 
JOIN STG.TP_LOB L 
ON L.PKEY = R.FK_LOB 
AND L.NAME IN ('COMMERCIAL', 'RESIDENTIAL', 'ROLLOFF')
JOIN STG.TP_LANDFILL LND 
ON LND.PKEY =ROL.FK_LANDFILL 
JOIN STG.TP_SITE S
ON S.PKEY = LND.FK_SITE 

JOIN
(SELECT DISTINCT HAULING_SITE_ID, OCS_DISPOSAL_CD, 
 SUBSTR(MATCHED_LOCATIONID_TYPE , 0, REGEXP_INSTR(MATCHED_LOCATIONID_TYPE , '_') -1) DISPFACID,
 SUBSTR(MATCHED_LOCATIONID_TYPE ,REGEXP_INSTR(MATCHED_LOCATIONID_TYPE , '_') + 1) DISPFAC_TYPE
FROM  MART.LOCATION_MATCHING) LH_MATCHING
ON LH_MATCHING.HAULING_SITE_ID = S.UNIQUEID
AND LND.ID=LH_MATCHING.OCS_DISPOSAL_CD

LEFT JOIN DEV_ONEWM.STG.TP_RO_DOWNTIME ROD
ON ROD.FK_ROUTEORDER = RO.PKEY 
AND ROD.FK_VEHICLE IS NULL 
AND ROD.DOWNSTART  BETWEEN ROL.ARRIVE AND ROL.DEPART
AND ROD.DOWNEND  BETWEEN ROL.ARRIVE AND ROL.DEPART 
LEFT JOIN DEV_ONEWM.STG.TP_RO_LUNCH RLUNCH
ON RLUNCH.FK_ROUTEORDER = RO.PKEY 
AND RLUNCH.LUNCHSTART BETWEEN ROL.ARRIVE AND ROL.DEPART 
AND RLUNCH.LUNCHEND  BETWEEN ROL.ARRIVE AND ROL.DEPART
AND RLUNCH.FK_VEHICLE IS NULL 
;
