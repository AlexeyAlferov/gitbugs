-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** ENO_GREENFLOW_FLOW_CONTROL_CAPACITY
CREATE VIEW ENO_GREENFLOW_FLOW_CONTROL_CAPACITY AS
SELECT
	Z.ENO_ID
	,Z.ENO_RESULTSOURCE
	,Z.PKEY AS FLOW_CONTROL_RULE_ID
	,Z.FLOW_CONTROL_SOURCE
	,Z.FLOW_CONTROL_SOURCE_TYPE
	,Z.FLOW_CONTROL_DESTINATION
	,Z.FLOW_CONTROL_DESTINATION_TYPE
	,Z.WASTE_TYPE
	,Z.LOB
	,NVL(Z.MIN_TONS,0) AS MIN_TONS
	,NVL(Z.MAX_TONS,0) AS MAX_TONS
	,CASE WHEN (NVL(Z.MIN_TONS,0) - NVL(Z.THREEP_TONS,0)) < 0
				THEN 0
	 			ELSE (NVL(Z.MIN_TONS,0) - NVL(Z.THREEP_TONS,0))
		END AS MIN_TONS_EXCL_3P
	,CASE WHEN (NVL(Z.MAX_TONS,0) - NVL(Z.THREEP_TONS,0)) < 0
				THEN 0
	 			ELSE (NVL(Z.MAX_TONS,0) - NVL(Z.THREEP_TONS,0))
		END AS MAX_TONS_EXCL_3P
	,(NVL(Z.WM_TONS,0) + NVL(Z.THREEP_TONS,0)) AS SOLUTION_TOTAL_TONS
	,NVL(Z.WM_TONS,0) AS SOLUTION_WM_TONS
	,NVL(Z.THREEP_TONS,0) AS SOLUTION_3P_TONS
	,CASE WHEN (NVL(Z.MAX_TONS,0) - NVL(SOLUTION_TOTAL_TONS,0)) > 0 THEN (NVL(Z.MAX_TONS,0) - NVL(SOLUTION_TOTAL_TONS,0)) ELSE NULL END AS REMAINING_CAPACITY
	,CASE WHEN Z.MAX_TONS IS NULL THEN NULL ELSE (NVL(SOLUTION_TOTAL_TONS,0) - NVL(Z.MAX_TONS,0)) END AS OVER_USE
--	,CASE WHEN (NVL(SOLUTION_TOTAL_TONS,0) - NVL(Z.MAX_TONS,0)) > 0 THEN (NVL(SOLUTION_TOTAL_TONS,0) - NVL(Z.MAX_TONS,0)) ELSE NULL END AS OVER_USE
	,CASE WHEN (NVL(Z.MIN_TONS,0) - NVL(SOLUTION_TOTAL_TONS,0)) > 0 THEN (NVL(Z.MIN_TONS,0) - NVL(SOLUTION_TOTAL_TONS,0)) ELSE NULL END AS UNDERUSE
FROM
(
		SELECT EFC.PKEY
        ,EGS.ENO_ID
				,EGS.ENO_RESULTSOURCE
        ,EFC.COLLECTION_ENTITY AS FLOW_CONTROL_SOURCE
        ,EFC.RULE_SOURCE AS FLOW_CONTROL_SOURCE_TYPE
        ,EFC.DISPOSAL_ENTITY AS FLOW_CONTROL_DESTINATION
        ,EFC.RULE_DEST AS FLOW_CONTROL_DESTINATION_TYPE
        ,EFC.WASTE_TYPE AS WASTE_TYPE
        ,EFC.LOB AS LOB
        ,EFC.MIN_TONS AS MIN_TONS
        ,EFC.MAX_TONS AS MAX_TONS
				,SUM( CASE WHEN EGS.SUBLOB = '3PLOB' THEN TONS ELSE 0 END) AS THREEP_TONS
				,SUM( CASE WHEN EGS.SUBLOB = '3PLOB' THEN 0 ELSE TONS END) AS WM_TONS
    FROM MART.EXPLODED_FLOW_CONTROL_PERSISTENT EFC
    LEFT JOIN MART.MODEL_FLOW_CONTROL_DISPOSAL_PERSISTENT T2
    ON EFC.FC_RULE_NUMBER = T2.FC_RULE_NUMBER AND EFC.ENO_ID = T2.ENO_ID
    JOIN STG.ENO_GREENFLOW_SOLUTION_RESULTS EGS
    ON T2.ENO_ID = EGS.ENO_ID  AND T2.DISP_FAC_ID = EGS.DISP_FAC_ID
    WHERE EFC.METHOD_TYPE IN (2,3)
		GROUP BY
        EFC.PKEY
        ,EGS.ENO_ID
				,EGS.ENO_RESULTSOURCE
        ,EFC.PKEY
        ,EFC.COLLECTION_ENTITY
        ,EFC.RULE_SOURCE
        ,EFC.DISPOSAL_ENTITY
        ,EFC.RULE_DEST
        ,EFC.WASTE_TYPE
        ,EFC.LOB
        ,EFC.MIN_TONS
        ,EFC.MAX_TONS
) Z
;
