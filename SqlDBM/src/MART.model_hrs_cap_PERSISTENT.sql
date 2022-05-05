-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.model_hrs_cap_PERSISTENT
CREATE TABLE MART.model_hrs_cap_PERSISTENT
(
 ENO_ID               varchar(100),
 HRS_CAP_ID           number(38,0),
 CASE_ID              number(38,0),
 FAC_ID               varchar(16777216),
 SUBLOB               varchar(16777216),
 MIN_HRS              float,
 TRUCK_CAPACITY       float,
 TOTAL_COLLECTION_HRS float,
 MAX_HRS              float
);
