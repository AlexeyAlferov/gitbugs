-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MODEL_COLLECTION_POINTS_AFTERFIX_2232
CREATE VIEW MODEL_COLLECTION_POINTS_AFTERFIX_2232 as 
WITH eq_hauls AS (
    SELECT
        depotfacid
        , COUNT(*) AS eq_hauls
    FROM QAT_ONEWM.MART.ROLLOFF_FACT ro_fact
    WHERE
        waste_type IN ( 'MSW', 'C&D', 'SPW' )  -- TODO: move all WASTE_TYPE filtering to the most upstream table (CO_EVENTS)
        AND service_dt BETWEEN $start_date AND $end_date
        AND ( ro_fact.depotfacid IN (SELECT fac_id
                             FROM   QAT_ONEWM.mart.HAULING_SITE
                             WHERE  market_area_cd = $market_area) )
    GROUP BY depotfacid
),
COLLATED_CPS AS
 (SELECT
      group_id
    , NULL                          AS routeid
    , ro_fact.depotfacid||'_Depot'  AS depotfacid
    , dispfacid
    , ANY_VALUE(wm_collection_flag)       AS wm_collection_flag
    , ANY_VALUE(lob)                      AS lob
    , ANY_VALUE(sublob)                   AS sublob
    , waste_type
    , SUM(tons)                     AS tons
    , COUNT(*)                      AS nbrloads
    , 2 / COALESCE(ANY_VALUE(eq_hauls.eq_hauls), 1) AS stemlegs
    , ANY_VALUE(disposallegs)             AS disposallegs
    , ANY_VALUE(longitude)                AS longitude
    , ANY_VALUE(latitude)                 AS latitude
    , 1                             AS load_seq
    , NULL AS house --TODO join in relevant customer information in ROLLOFF_FACT and choose any here
    , NULL AS street_name
    , NULL AS city
    , NULL AS zip
    , 1                             AS LAST_LOAD_FLAG
    , NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',1),'AAA') AS GEO_COUNTY_NM
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',2),'AAA') AS GEO_STATE_CD
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',3),'AAA') AS GEO_CITY_NM
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',4),'AAA') AS GEO_ZIP_CD
    , ANY_VALUE(customer_name)            AS customer_name
    , LISTAGG(DISTINCT ocs_disposal_cd,',')          AS ocs_disposal_cd
    , LISTAGG(DISTINCT ocs_disposal_nm,',')          AS ocs_disposal_description
    , MAX(returnlegs)               AS return_legs
    , DISPOSAL_TRIP_TYPE_cd
    , CASE WHEN DISPOSAL_TRIP_TYPE_cd != 'ER' AND DISPOSAL_TRIP_TYPE_cd IS NOT NULL -- comres is always null
    		AND $optimize_eandr_only = 'Y' THEN 1 ELSE 0 END AS DCO_FROZEN_FLAG	-- Set as frozen if Optimize E&R only flag is set or 3P CP
  FROM   QAT_ONEWM.MART.ROLLOFF_FACT ro_fact
    LEFT JOIN eq_hauls ON eq_hauls.depotfacid = ro_fact.depotfacid
  WHERE
     waste_type IN ( 'MSW', 'C&D', 'SPW' )  -- TODO: move all WASTE_TYPE filtering to the most upstream table (CO_EVENTS)
     AND service_dt BETWEEN $start_date AND $end_date
     AND ( ro_fact.depotfacid IN (SELECT fac_id
                             FROM   QAT_ONEWM.mart.HAULING_SITE
                             WHERE  market_area_cd = $market_area) )
     AND (DISPOSAL_TRIP_TYPE_CD != 'EFO' AND dispfacid in (select fac_id from DISPOSAL_SITE where active_flag='A'))
      GROUP  BY
        group_id
        , ro_fact.depotfacid
        , waste_type
        , dispfacid
        , DISPOSAL_TRIP_TYPE_cd
  UNION ALL
  SELECT
      comres.group_id
    , comres.routeid
    , comres.depotfacid||'_Depot'
    , comres.dispfacid
    , comres.wm_collection_flag
    , comres.lob
    , comres.sublob
    , comres.waste_type
    , SUM(comres.tons) AS tons
    , COUNT(comres.tons) AS nbrloads  -- there is only 1 non-null tons value per loadseq
    , comres.stemlegs
    , comres.disposallegs
    , AVG(comres.longitude) AS longitude
    , AVG(comres.latitude) AS latitude
    , comres.loadseq
    , NULL AS house
    , NULL AS street_name
    , NULL AS city
    , NULL AS zip
    , comres.LAST_LOAD_FLAG
    , NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',1),'AAA') AS GEO_COUNTY_NM
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',2),'AAA') AS GEO_STATE_CD
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',3),'AAA') AS GEO_CITY_NM
	, NULLIF(SPLIT_PART(max(nvl(GEO_COUNTY_NM,'AAA')||'~'||nvl(GEO_STATE_CD,'AAA')||'~'||nvl(GEO_CITY_NM,'AAA')||'~'||nvl(GEO_ZIP_CD,'AAA')) ,'~',4),'AAA') AS GEO_ZIP_CD
    , NULL AS customer_name
    , LISTAGG(DISTINCT OCS_DISPOSAL_cd,',') as OCS_DISPOSAL_cd
    , LISTAGG(DISTINCT OCS_DISPOSAL_NM,',') as OCS_DISPOSAL_NM
    , comres.returnlegs AS return_legs
    , NULL AS DISPOSAL_TRIP_TYPE_cd
    , 0 AS dco_frozen_flag
  FROM QAT_ONEWM.MART.COMRES_FACT comres
  WHERE
     waste_type IN ( 'MSW', 'C&D', 'SPW' )  -- TODO: move all WASTE_TYPE filtering to the most upstream table (CO_EVENTS)
     AND service_dt BETWEEN $start_date AND $end_date
     AND comres.depotfacid IN
            (SELECT fac_id FROM QAT_ONEWM.mart.HAULING_SITE WHERE market_area_cd = $market_area)
  GROUP  BY
    comres.group_id
    , comres.routeid
    , comres.depotfacid
    , dispfacid
    , wm_collection_flag
    , comres.lob
    , comres.sublob
    , waste_type
    , stemlegs
    , disposallegs
    , loadseq
    , LAST_LOAD_FLAG
    , return_legs
)
SELECT
    ROW_NUMBER() OVER (ORDER BY --TODO: elaborate sort order to ensure consistent ROWNUMBER
    GROUP_ID,
    ROUTEID,
    DEPOTFACID,
    DISPFACID,
    WM_COLLECTION_FLAG,
    LOB,
    SUBLOB,
    WASTE_TYPE,
    TONS, --this should be sufficient2
    NBRLOADS,
    LOAD_SEQ) AS ROWNUMBER
    , *
 FROM (
        SELECT * FROM COLLATED_CPS
   -- WHERE (DISPOSAL_TRIP_TYPE_cd != 'EFO' AND dispfacid in (select fac_id from QAT_ONEWM.MART.DISPOSAL_SITE where active_flag='A'))
 
        UNION ALL
        SELECT * FROM THIRD_PARTY_CPS  -- filter 3rd party by the disposal facilities from the regular COLLATED_CPS
        WHERE dispfacid IN (SELECT DISTINCT dispfacid FROM COLLATED_CPS)
		AND dispfacid in (select fac_id from DISPOSAL_SITE where active_flag='A')
  );
