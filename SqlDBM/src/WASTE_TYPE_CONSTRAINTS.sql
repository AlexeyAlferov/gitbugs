-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** WASTE_TYPE_CONSTRAINTS
CREATE VIEW WASTE_TYPE_CONSTRAINTS AS SELECT * FROM BMT_WASTE_TYPE_CONSTRAINTS 
where nvl(DATA_COLLCTION_ADD_DELETE_UPDATE,'A') != 'D';
