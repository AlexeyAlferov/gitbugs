-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_LIST_WASTE_TYPE_ALL
CREATE VIEW LH_LIST_WASTE_TYPE_ALL

as select * from LH_LIST_WASTE_TYPE 

union all select 'ALL','All Waste Types';
