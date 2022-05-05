-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** COMRES_FACT
CREATE VIEW COMRES_FACT as
select
      GROUP_ID
    , t2.MATCHED_LOCATIONID_TYPE as DispFacId
    , t1.DepotFacID
    , hs.FAC_NAME AS FAC_NM
    , t1.OCS_DISPOSAL_NM
    , t1.OCS_DISPOSAL_CD
    , INACTIVE
--    , loc_match.matched_location_code || '_' || loc_match.location_type as DISP_FAC_ID_HIST
    , sublob
    , service_dt
    , LoadSeq
    , LAST_LOAD_FLAG
    , Route_id AS ROUTEID
    , t1.LATITUDE
    , t1.LONGITUDE
    , tons
    , COST
    , yards
    , homes
    , WM_Collection_Flag
    , LOB
    , WASTE_TYPE
    , StemLegs
    , DisposalLegs
    , ReturnLegs
    , VEHICLE_ID
    , t3.GEO_COUNTY_NM
    , t3.GEO_CITY_NM
    , t3.GEO_STATE_CD
    , t3.GEO_ZIP_CD
    , actl_trvl_to_dspsl_tm
    , LANDFILL_PKEY
    , INTERCOMPANY
from MART.CORP_COMRES_FACT t1
LEFT JOIN HAULING_SITE hs on hs.FAC_ID = t1.DepotFacID
LEFT JOIN LOCATION_MATCHING t2 on t1.DEPOTFACID = t2.HAULING_SITE_ID and t1.OCS_DISPOSAL_CD = t2.OCS_DISPOSAL_CD
LEFT JOIN GEOCODE_RESULTS t3 on truncate(t1.LONGITUDE,6) = t3.longitude and truncate(t1.latitude,6) = t3.latitude
;
