-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** THIRD_PARTY_CPS
CREATE VIEW THIRD_PARTY_CPS AS

WITH AVERAGE_DAILY_3P_FLOWS AS (

SELECT

    fac_id, waste_type, AVG(avg_third_party) * (COUNTDAYS($start_Date, $end_Date, 1) + COUNTDAYS($start_Date, $end_Date, 0)) AS tons  -- Counts the days and multiply it by the average

    FROM PMT_DISPOSAL_3P

    GROUP BY fac_Id, waste_type

    HAVING AVG(avg_third_party)  > 0

UNION ALL

    SELECT fac_id, waste_type, AVG(avg_third_party) * (COUNTDAYS($start_Date, $end_Date, 1) + COUNTDAYS($start_Date, $end_Date, 0)) AS tons

    FROM pmt_transfer_3p

    GROUP BY fac_id, waste_type

    HAVING AVG(avg_third_party)  > 0)

SELECT

    '3PGROUP' AS group_id

    , NULL AS route_id

    , '3PDEPOT' AS depotfacid

    , FAC_ID AS dispfacid

    , 0 AS wm_collection_flag

    , '3PLOB' AS lob

    , '3PLOB' AS sublob

    , waste_type

    , tons

    , 1 AS nbr_loads

    , 0 AS stemlegs

    , 0 AS disposallegs

    , -98.5696 AS longitude

    , 39.828 AS latitude

    , 1 AS load_seq

    , NULL AS house

    , NULL AS street_name

    , NULL AS city

    , NULL AS zip

    , 1 AS LAST_LOAD_FLAG

    , null AS GEO_COUNTY_NM

    , null AS GEO_CITY_NM

    , null AS GEO_STATE_CD

    , null AS GEO_ZIP_CD

    , NULL AS customer_name

    , NULL AS ocs_disposal_cd

    , NULL AS ocs_disposal_description

    , 0 AS return_legs

            , NULL AS DISPOSAL_TRIP_TYPE

        , 1 AS dco_frozen_flag

FROM AVERAGE_DAILY_3P_FLOWS

WHERE waste_type IN ( 'MSW', 'C&D', 'SPW' )  -- TODO: move all WASTE_TYPE filtering to the most upstream table (CO_EVENTS)

;
