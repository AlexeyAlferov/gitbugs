-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** LH_LIST_METHOD_TYPE
CREATE VIEW LH_LIST_METHOD_TYPE as

select 'All collected waste must go' union all

select 'All collected waste must NOT go' union all

select 'Minimum collected waste must go (tons)' union all

select 'Maximum collected waste limited to (tons)' union all

select 'All collected waste has a special rate' union All

select 'Destination may only accept';
