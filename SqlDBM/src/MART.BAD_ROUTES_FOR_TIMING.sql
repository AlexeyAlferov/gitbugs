-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.BAD_ROUTES_FOR_TIMING
CREATE TABLE MART.BAD_ROUTES_FOR_TIMING
(
 HAULING_SITE varchar(6),
 SUBLOB       varchar(5),
 RO_KEY       number(38,0),
 SERVICE_DT   timestamp_ntz(9)
);
