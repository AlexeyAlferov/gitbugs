-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** ROLLOFF_FACT_ADJUSTED
CREATE VIEW ROLLOFF_FACT_ADJUSTED as 

select

LOAD_SEQ

,TONS

,NBRLOADS

,COST

,GROUP_ID

,ACCOUNTNBR

,HOUSE

,STREET_NAME

,CITY

,ZIP

,LONGITUDE

,LATITUDE

,t1.DEPOTFACID

,SUBLOB

,CUSTOMER_NAME

,WASTE_TYPE

,t1.OCS_DISPOSAL_NM

,t1.OCS_DISPOSAL_CD

,INTERCOMPANY

,INACTIVE

,STATE

,t2.MATCHED_LOCATIONID_TYPE as DispFacId

,WM_COLLECTION_FLAG

,LOB

,DISPOSALLEGS

,RETURNLEGS

,CP_ID

,SERVICE_DT

,VEHICLE_ID from 

ROLLOFF_FACT t1 LEFT JOIN LOCATION_MATCHING t2 on t1.DEPOTFACID = t2.HAULING_SITE_ID and t1.OCS_DISPOSAL_CD = t2.OCS_DISPOSAL_CD and t1.OCS_DISPOSAL_NM = t2.OCS_DISPOSAL_NM;
