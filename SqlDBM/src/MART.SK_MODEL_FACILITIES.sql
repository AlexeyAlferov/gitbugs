-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.SK_MODEL_FACILITIES
CREATE TABLE MART.SK_MODEL_FACILITIES
(
 FAC_ID        varchar(277),
 FAC_NAME      varchar(256),
 FAC_TYPE      varchar(277),
 ADDRESS_1     varchar(256),
 ADDRESS_2     varchar(256),
 GEO_CITY_NM   varchar(256),
 GEO_COUNTY_NM varchar(256),
 GEO_STATE_CD  varchar(256),
 GEO_ZIP_CD    varchar(256),
 LATITUDE      number(12,7),
 LONGITUDE     number(12,7),
 TURN_TIME     number(10,2),
 MIN_TONS      float,
 MAX_TONS      float,
 FIXED_COST    number(10,2),
 WM_OWNED_FLAG varchar(1),
 STATUS_IND    varchar(1)
);
