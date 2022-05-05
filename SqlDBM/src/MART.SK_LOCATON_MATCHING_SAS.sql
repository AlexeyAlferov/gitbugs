-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.SK_LOCATON_MATCHING_SAS
CREATE TABLE MART.SK_LOCATON_MATCHING_SAS
(
 HAULING_SITE_CD                      varchar(20),
 DISPOSAL_CODE                        varchar(20),
 LOC_NAME                             varchar(64),
 TONNAGE                              float,
 LOCATION_TYPE                        varchar(20),
 MATCHED_LOCATIONID_NAME              varchar(602),
 MATCHED_LOCATIONID_TYPE              varchar(623),
 MATCHED_LOCATION_CODE                varchar(602),
 MATCHED_LOCATION_NAME                varchar(602),
 MATCHING_LOGIC                       varchar(7),
 MODIFIED_DATE                        float,
 RNK                                  number(38,0),
 ORIGINAL_LOCATION_TYPE               varchar(20),
 ORIGINAL_MATCHED_LOCATIONID_TYPE     varchar(20),
 WBJ_ORIGINAL_LOCATION_TYPE           varchar(20),
 WBJ_ORIGINAL_MATCHED_LOCATIONID_TYPE varchar(20),
 WBJ_ORIGINAL_MATCHED_LOCATION_CODE   varchar(20)
);
