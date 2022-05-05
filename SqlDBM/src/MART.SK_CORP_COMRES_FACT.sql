-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.SK_CORP_COMRES_FACT
CREATE TABLE MART.SK_CORP_COMRES_FACT
(
 GROUP_ID           varchar(21),
 ROUTEID            varchar(10),
 DISPFACID          varchar(623),
 DEPOTFACID         varchar(6),
 FAC_NM             varchar(100),
 OCS_DISPOSAL_NM    varchar(40),
 OCS_DISPOSAL_CD    varchar(10),
 INTERCOMPANY       varchar(1),
 INACTIVE           varchar(1),
 SUBLOB             varchar(5),
 SERVICE_DT         timestamp_ntz(9),
 LATITUDE           float,
 LONGITUDE          float,
 LOADSEQ            number(13,0),
 LOADCOUNT          number(13,0),
 LAST_LOAD_FLAG     number(1,0),
 TONS               float,
 COST               float,
 WM_COLLECTION_FLAG number(1,0),
 LOB                varchar(40),
 WASTE_TYPE         varchar(20),
 STEMLEGS           number(5,4),
 DISPOSALLEGS       number(1,0),
 RETURNLEGS         number(1,0),
 VEHICLE_ID         varchar(10)
)
CLUSTER BY ( DEPOTFACID, SERVICE_DT );
