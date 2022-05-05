-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** FACILITY_LOCATION_DATA_MART_BMT_COMBINED_VIEW2
CREATE VIEW FACILITY_LOCATION_DATA_MART_BMT_COMBINED_VIEW2 as

select FAC_ID, FAC_NAME, FAC_TYPE, ACTIVE_FLAG, MARKET_AREA_NM, MARKET_AREA_CD, ADDRESS_1, ADDRESS_2, CITY_NM, STATE_CD, ZIP_CD, COUNTY_NM, COUNTRY_CD,

LATITUDE, LONGITUDE, CYCLE_MINUTE_CNT as TURN_TIME, MIN_VOLUME, MAX_VOLUME, UNIT_COST, FIXED_COST, WM_OWNED_FLAG, LAST_UPDATED_DTM, LAST_UPDATED_USER,

SOURCE AS DATA_SOURCE from LH_SITE;
