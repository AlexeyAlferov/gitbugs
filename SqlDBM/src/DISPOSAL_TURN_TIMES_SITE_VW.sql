-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** DISPOSAL_TURN_TIMES_SITE_VW
CREATE VIEW DISPOSAL_TURN_TIMES_SITE_VW as 
SELECT A.DISPFACID DISPFACID,  AVG(NET_TURN_TIME) TURN_TIME 
FROM MART.DISPOSAL_TURN_TIMES_SITE_MA_LEVEL_VW  A
GROUP BY A.DISPFACID
;
