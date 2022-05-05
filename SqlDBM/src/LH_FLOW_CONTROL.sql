-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_FLOW_CONTROL
CREATE VIEW LH_FLOW_CONTROL as
 select 
 PKEY ,
 RULE_TYPE ,
 LOB ,
 WASTE_TYPE ,
 METHOD_TYPE ,
 TIME_HORIZON_NM ,
 NOTES ,
 SRC_HAULING_SITE_ID ,
 SRC_COUNTY_NM ,
 SRC_CITY_NM ,
 SRC_CUSTOMER_NM ,
 SRC_MARKET_AREA_CD ,
 substring(DEST_DISPOSAL_SITE_ID,1,6) as DEST_DISPOSAL_SITE_ID,
CASE when substring(DEST_DISPOSAL_SITE_ID,8) = 'TS' then 'Transfer Station'
     when substring(DEST_DISPOSAL_SITE_ID,8) = 'MRF' then 'MRF Recycling' else
                substring(DEST_DISPOSAL_SITE_ID,8) end  as DEST_DISPOSAL_SITE_TYPE,
 DEST_COUNTY_NM ,
 DEST_CITY_NM     ,
 DEST_MARKET_AREA_CD ,
 CUSTOMER_NM ,
 MIN_TONS ,
 MAX_TONS ,
 SPECIAL_RATE_AMT ,
 LAST_UPDATED_DTM ,
 LAST_UPDATED_USER,
 ACTIVE_FLAG,
 SRC_STATE_CD,
 DEST_STATE_CD,
 SRC_HAULING_SITE_NM,
 DEST_DISPOSAL_SITE_NM,
 SRC_OCS_DISPOSAL_CD,            
 SRC_STATE_NM,      
 DEST_STATE_NM,       
 SRC_OCS_DISPOSAL_NM
 from FLOW_CONTROL;
