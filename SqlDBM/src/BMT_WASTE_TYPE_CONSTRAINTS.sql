-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** BMT_WASTE_TYPE_CONSTRAINTS
CREATE VIEW BMT_WASTE_TYPE_CONSTRAINTS as
select * from
(select
PKEY,
FAC_ID ||'_' ||case when FAC_TYPE = 'Transfer Station' then 'TS'
                when FAC_TYPE = 'MRF Recycling' then 'MRF'
                else FAC_TYPE end as FAC_ID,
               	case when FAC_TYPE = 'Transfer Station' then 'TS'
                when FAC_TYPE = 'MRF Recycling' then 'MRF'
                else FAC_TYPE end as FAC_TYPE,
WASTE_TYPE,
MIN_TONS,
MAX_TONS,
VOLUME_CONSTRAINT_TYPE,
VOLUME_TIME_UNIT,
NOTES,
LAST_UPDATED_DTM,
LAST_UPDATED_USER,
DATA_COLLCTION_ADD_DELETE_UPDATE,
row_number() over (partition by PKEY order by last_updated_dtm desc nulls last) as rnk
 from stg.FACILITY_WASTE_TYPE_CONSTRAINTS_BMT_DATA_COLLCTN
where FAC_TYPE != 'Collection')  where rnk=1;
