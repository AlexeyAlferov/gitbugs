-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MBP_DISPOSAL_COST
CREATE VIEW MBP_DISPOSAL_COST AS

SELECT 

  SUBSTR(MD.ACTIVE_LANDFILL_MRF_3P_SITE,1,6) AS FAC_ID,

  CASE WHEN SUBSTR(MD.ACTIVE_LANDFILL_MRF_3P_SITE,10,1) = '_' THEN 

       CASE WHEN SUBSTR(MD.ACTIVE_LANDFILL_MRF_3P_SITE,8,2) = 'LF' THEN 'Disposal' ELSE SUBSTR(MD.ACTIVE_LANDFILL_MRF_3P_SITE,8,2)  END  

      ELSE SUBSTR(MD.ACTIVE_LANDFILL_MRF_3P_SITE,8,3) END AS FAC_TYPE ,

  MWM.INFERRED_WASTETYPE AS WASTE_TYPE,

  AVG(MD.COLUMN__EXPERT_CUST_PRICE) AS DISPOSAL_COST

FROM 

(

  SELECT DISTINCT ACTIVE_LANDFILL_MRF_3P_SITE,REPLACE(COLUMN__EXPERT_CUST_PRICE,',','')  AS COLUMN__EXPERT_CUST_PRICE, WASTE_STREAM_DS FROM 

  DEV_ONEWM.STG.MBP_DIRECT 



) MD

JOIN DEV_ONEWM.MART.MBP_WASTETYPE_MAPPING MWM

    ON MD.WASTE_STREAM_DS = MWM.WASTE_STREAM_DS WHERE FAC_ID != 'All' and FAC_TYPE IN ('TS','MRF','Disposal') AND WASTE_TYPE != 'OTHER'

GROUP BY 1,2,3 having AVG(MD.COLUMN__EXPERT_CUST_PRICE) > 0;
