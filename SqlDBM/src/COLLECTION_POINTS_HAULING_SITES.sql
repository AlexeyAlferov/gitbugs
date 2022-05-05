-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** COLLECTION_POINTS_HAULING_SITES
CREATE VIEW COLLECTION_POINTS_HAULING_SITES as 

  select    t1.DepotFacID from MART.COMRES_FACT t1 

            where  waste_Type in ('MSW','C&D','SPW') 

            and dispfacid is not null

            union 

  select    t1.DepotFacID from MART.ROLLOFF_FACT t1 

            where  waste_Type in ('MSW','C&D','SPW') 

            and dispfacid is not null;
