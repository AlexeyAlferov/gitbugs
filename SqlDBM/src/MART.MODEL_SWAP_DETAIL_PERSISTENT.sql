-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.MODEL_SWAP_DETAIL_PERSISTENT
CREATE TABLE MART.MODEL_SWAP_DETAIL_PERSISTENT
(
 ENO_ID         varchar(100),
 SWAP_HEADER_ID number(38,0),
 SWAP_NAME      varchar(16777216),
 DEPOT_FAC_ID   varchar(16777216),
 DISP_FAC_ID    varchar(16777216),
 LOB            varchar(16777216),
 WASTE_TYPE     varchar(16777216)
);
