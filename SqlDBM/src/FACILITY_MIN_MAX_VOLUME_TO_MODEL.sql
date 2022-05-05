-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** FACILITY_MIN_MAX_VOLUME_TO_MODEL
CREATE VIEW FACILITY_MIN_MAX_VOLUME_TO_MODEL AS 
select volume_day_lvl.FAC_ID,
       volume_day_lvl.FAC_TYPE,
       MIN_TONS * nvl(FACILITY_OPERATIONAL_DAYS_IN_SCOPE,1) MIN_TONS, 
       MAX_TONS * nvl(FACILITY_OPERATIONAL_DAYS_IN_SCOPE,1) MAX_TONS
from                    
(select
lhs.FAC_ID, 
lhs.FAC_TYPE,
MIN_TONS/volume_adjust_factor MIN_TONS, 
MAX_TONS/volume_adjust_factor MAX_TONS
from mart.LH_SITE lhs
left join mart.FACILITY_VOLUME_CONSTRAINT_ADJUST_FACTOR adj 
on adj.FAC_ID =lhs.FAC_ID
and adj.FAC_TYPE=lhs.FAC_TYPE
) volume_day_lvl
left join FACILITY_OPERATION_DAYS_IN_SCOPE oprntl_days
on volume_day_lvl.FAC_ID = oprntl_days.FAC_ID
and volume_day_lvl.FAC_TYPE = oprntl_days.FAC_TYPE;
