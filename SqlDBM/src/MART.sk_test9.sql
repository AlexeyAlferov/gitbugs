-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.sk_test9
CREATE TABLE MART.sk_test9
(
 ROWNUMBER                number(18,0),
 GROUP_ID                 varchar(16777216),
 ROUTEID                  varchar(10),
 DEPOTFACID               varchar(12),
 DISPFACID                varchar(27),
 WM_COLLECTION_FLAG       number(1,0),
 LOB                      varchar(40),
 SUBLOB                   varchar(5),
 WASTE_TYPE               varchar(16777216),
 TONS                     float,
 NBRLOADS                 number(18,0),
 STEMLEGS                 number(7,6),
 DISPOSALLEGS             number(1,0),
 LONGITUDE                float,
 LATITUDE                 float,
 LOAD_SEQ                 number(14,0),
 LAST_LOAD_FLAG           number(1,0),
 GEO_COUNTY_NM            varchar(256),
 GEO_CITY_NM              varchar(256),
 GEO_STATE_CD             varchar(256),
 GEO_ZIP_CD               varchar(256),
 CUSTOMER_NAME            varchar(40),
 OCS_DISPOSAL_CD          varchar(16777216),
 OCS_DISPOSAL_DESCRIPTION varchar(16777216),
 RETURN_LEGS              number(1,0)
);
