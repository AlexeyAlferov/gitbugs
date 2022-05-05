-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** VALIDATION_DATA_TRANSFER_LANE_NULL_LOAD_SIZE
CREATE VIEW VALIDATION_DATA_TRANSFER_LANE_NULL_LOAD_SIZE AS
SELECT LANE_ORIGIN_FAC_ID,LANE_DESTINATION_FAC_ID,WASTE_TYPE,
 'Transfer lane with origin ' ||LANE_ORIGIN_FAC_ID||', destination '
 							  ||LANE_DESTINATION_FAC_ID||' and waste_type '
 							  ||WASTE_TYPE|| ' has a Cost Per Load but NULL Load Size' AS DETAIL
	  ,SUBSTR(LANE_ORIGIN_FAC_ID,1,6) AS LH_PARM_1
	  ,LH_FAC_TYPE(LANE_ORIGIN_FAC_ID)  AS LH_PARM_2
	  ,WASTE_TYPE AS LH_PARM_3
      ,SUBSTR(LANE_DESTINATION_FAC_ID,1,6) AS LH_PARM_4
	  ,LH_FAC_TYPE(LANE_DESTINATION_FAC_ID)  AS LH_PARM_5
  FROM PRE_MODEL_TRANSFER_COSTS --Use distinct? Or We want to get the total count with out distinct
  	WHERE LONG_HAUL_COST_PER_TON IS NULL
    AND LONG_HAUL_COST_PER_LOAD IS NOT NULL
  	AND LOAD_SIZE IS NULL
;
