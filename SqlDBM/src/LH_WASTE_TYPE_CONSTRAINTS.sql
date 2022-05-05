-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_WASTE_TYPE_CONSTRAINTS
CREATE VIEW LH_WASTE_TYPE_CONSTRAINTS AS
select
PKEY,
substring(FAC_ID,1,6) as FAC_ID,
CASE when substring(FAC_ID,8) = 'TS' then 'Transfer Station'
     when substring(FAC_ID,8) = 'MRF' then 'MRF Recycling' else
                substring(FAC_ID,8) end  as FAC_TYPE,
WASTE_TYPE,
MIN_TONS,
MAX_TONS,
VOLUME_CONSTRAINT_TYPE,
VOLUME_TIME_UNIT,
NOTES,
LAST_UPDATED_DTM,
LAST_UPDATED_USER
from WASTE_TYPE_CONSTRAINTS;
