-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** VALIDATION_DATA_OMITTED_DCO_FROZEN_CPS
CREATE VIEW VALIDATION_DATA_OMITTED_DCO_FROZEN_CPS AS
SELECT
DEPOTFACID
,DISPFACID
,TONS
,'3P collection point of ' || TONS || ' tons to ' || DISPFACID || ' is omitted from the baseline because facility is inactive' as DETAIL
,SUBSTR(DISPFACID,1,6) AS LH_PARM_1
,LH_FAC_TYPE(DISPFACID)  AS LH_PARM_2
,NULL AS LH_PARM_3
,NULL AS LH_PARM_4
,NULL AS LH_PARM_5
FROM THIRD_PARTY_CPS
WHERE DISPFACID IN (select fac_id from MODEL_FACILITIES where status_ind!='A')

UNION ALL

SELECT
DEPOTFACID
,DISPFACID
,TONS
,'Non-3P collection point of ' || TONS || ' tons to ' || DISPFACID || ' is omitted from the baseline and optimized because facility is inactive' as DETAIL
,SUBSTR(DISPFACID,1,6) AS LH_PARM_1
,LH_FAC_TYPE(DISPFACID)  AS LH_PARM_2
,NULL AS LH_PARM_3
,NULL AS LH_PARM_4
,NULL AS LH_PARM_5
FROM COLLATED_CPS
WHERE DISPFACID IN (select fac_id from MODEL_FACILITIES where status_ind!='A')
 AND DCO_FROZEN_FLAG=1 AND LOB!='3PLOB'
;
