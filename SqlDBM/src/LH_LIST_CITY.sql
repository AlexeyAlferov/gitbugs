-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_LIST_CITY
CREATE VIEW LH_LIST_CITY AS

select CITY_NM, MARKET_AREA_CD, MARKET_AREA_NM from DISPOSAL_SITE where CITY_NM is not null and market_area_cd is not null

union 

select CITY_NM, MARKET_AREA_CD, MARKET_AREA_NM from HAULING_SITE  where CITY_NM is not null  and market_area_cd is not null;
