-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_LIST_LOB_ALL
CREATE VIEW LH_LIST_LOB_ALL as

select  * from LH_LIST_LOB 

union all select 'All LOBs';
