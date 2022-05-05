-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** VALIDATION_DATA_PRE_MODEL_NO_UNIT_PRICE
CREATE VIEW VALIDATION_DATA_PRE_MODEL_NO_UNIT_PRICE AS
SELECT
    FM.FAC_ID, FM.WASTE_TYPE AS WASTE_TYPE, TOTAL_TONS,
     'Unit price per ton not supplied for Facility '||FM.FAC_ID||' and waste type '||FM.WASTE_TYPE||'. A substitute price of $'||round(MFM.UNIT_PRICE,2)||' was applied.'||
     CASE WHEN TOTAL_RECORDS IS NULL THEN ' Facility and waste type have no collection points  ' ELSE
        ' Facility and waste type accounts for '||TOTAL_RECORDS ||' Collection Points and '||TOTAL_TONS||' Tons' END AS DETAIL
	,SUBSTR(FM.FAC_ID,1,6) AS LH_PARM_1
	,LH_FAC_TYPE(FM.FAC_ID) AS LH_PARM_2
    ,FM.WASTE_TYPE AS LH_PARM_3
	,NULL AS LH_PARM_4
	,NULL AS LH_PARM_5
FROM PRE_MODEL_FACILITIES_MATERIAL FM
LEFT JOIN
  (SELECT MCP.DISPFACID AS DISPFACID ,
          WASTE_TYPE ,
          COUNT(*) AS TOTAL_RECORDS ,
          SUM(TONS) AS TOTAL_TONS
   FROM MODEL_COLLECTION_POINTS MCP
   GROUP BY DISPFACID ,
            WASTE_TYPE) MP ON FM.FAC_ID = MP.DISPFACID
AND FM.WASTE_TYPE=MP.WASTE_TYPE
INNER JOIN MODEL_FACILITIES MF ON FM.FAC_ID=MF.FAC_ID AND MF.WM_OWNED_FLAG ='N'
INNER JOIN MODEL_FACILITIES_MATERIAL MFM ON MFM.FAC_ID = FM.FAC_ID AND MFM.WASTE_TYPE = FM.WASTE_TYPE
WHERE FM.UNIT_PRICE IS NULL
;
