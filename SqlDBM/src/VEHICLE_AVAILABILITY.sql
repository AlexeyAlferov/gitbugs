-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** VEHICLE_AVAILABILITY
CREATE VIEW VEHICLE_AVAILABILITY as (SELECT 
  "FAC_ID", 
  "SUBLOB", 
  "TRUCK_CNT" 
FROM (WITH COMPASS AS
--
--	Get the core data from COMPASS.  Only interested in Active Trucks.  This gives us our counts but the act_code is often
--	incorrect or sometimes missing.
--	Append Canada and the US together.  There is no overlapping data between the two
--
(
SELECT t1.using_dept_no AS depotfacid, t1.unit_no AS vehicle_id, t4.sublob, t1.act_code,t1.status, t6.description, t1.unit_type
	FROM 		   	DEV_COMPASS_USA.ODS.unit_main t1
	INNER JOIN 		DEV_COMPASS_USA.ODS.view_udc_main t2 ON t1.unit_id = t2.unit_id
	LEFT JOIN 		DEV_COMPASS_USA.ODS.activity t3 ON t1.act_code = t3.act_code
	LEFT JOIN 		DEV_ONEWM.MART.SUBLOB_HIERARCHY t4 ON t1.act_code = CAST(t4.essbase_sublob_key AS varchar(4))
	LEFT JOIN DEV_COMPASS_USA.ODS.UNITDIS t5 ON t1.unit_id = t5.UNIT_ID
	LEFT JOIN DEV_COMPASS_USA.ODS.DISPOSAL_REASON t6 on t6.disposal_reason = t5.disposal_reason
	WHERE  
	--t1.status='A' and t1.unit_type = 'U'   -- drop flagged (e.g. maintenance) , inactive and sold trucks - only consider active.
	t1.class2 in ('COLL')					  -- Collection only
	and category_class in ('COLL')				  -- Collection only
	and (t1.Using_dept_no like '%S0%' or t1.using_dept_no LIKE '%S1%')
	--or (t1.status !='A' AND T6.description in ('COVID 19' , 'SEASONAL'))
UNION ALL
SELECT t1.using_dept_no AS depotfacid, t1.unit_no AS vehicle_id, t4.sublob, t1.act_code,t1.status, t6.description, t1.unit_type
	FROM 		   	DEV_COMPASS_CAN.ODS.unit_main t1
	INNER JOIN 		DEV_COMPASS_CAN.ODS.view_udc_main t2 ON t1.unit_id = t2.unit_id
	LEFT JOIN 		DEV_COMPASS_CAN.ODS.activity t3 ON t1.act_code = t3.act_code
	LEFT JOIN 		DEV_ONEWM.MART.SUBLOB_HIERARCHY t4 ON t1.act_code = CAST(t4.essbase_sublob_key AS varchar(4))
	LEFT JOIN DEV_COMPASS_CAN.ODS.UNITDIS t5 ON t1.unit_id = t5.UNIT_ID
	LEFT JOIN DEV_COMPASS_CAN.ODS.DISPOSAL_REASON t6 on t6.disposal_reason = t5.disposal_reason
	WHERE  
	--t1.status='A' and t1.unit_type = 'U'   -- drop flagged (e.g. maintenance) , inactive and sold trucks - only consider active.
	t1.class2 in ('COLL')					  -- Collection Trucks only
	and category_class in ('COLL')				  -- Collection Trucks only
	and (t1.Using_dept_no like '%S0%' or t1.using_dept_no LIKE '%S1%')
	--or (t1.status !='A' AND T6.description in ('COVID 19' , 'SEASONAL'))
						  ),

OCS_SOURCED AS
--
--			Look in OCS and determine over the past few weeks the total number of routes for each vehicle, sublob combo at a hauling station
--			We give extra emphasis to primary routes since a truck may do multiple routes in the same day
--			One of the routes in primary and the other is secondary.  The primary route is more likely to be the correct sublob
(
SELECT 	depotfacid, sublob, vehicle_id, max(service_dt) AS last_service_dt	,				 -- Get the last service date
		sum(CASE WHEN isprimaryroute IN ('X','C') THEN 1 ELSE 0 end) AS primary_route_cnt,	 -- Count the primary routes
		sum(1) AS all_route_cnt																 -- Count all routes
FROM DEV_ONEWM.MART.route_fact WHERE service_dt > current_date-31											 -- arbitrarily go back 2 weeks.
GROUP BY depotfacid, sublob, vehicle_id),

OCS_ASSIGNMENT AS
(
--
--			Choose one record per combination of depot and vehicle.  The sublob assigned
--			is that with the highest primary route count - or if those are equal then the total route count
--			Also - a truck can be associated with multiple hauling sites.  In this case we prefer the combination of truck/hauling site
--			which exits in compass - if not then get the most recent - not sure that will ever be applied tho
--
SELECT depotfacid, vehicle_id, sublob from
	(SELECT t1.depotfacid, t1.vehicle_id, t1.sublob,
			row_number() OVER (partition BY t1.depotfacid, t1.vehicle_id ORDER BY primary_route_cnt DESC, all_route_cnt DESC,t1.sublob) AS sublob_rnk,
			row_number() OVER (partition BY t1.vehicle_id ORDER BY t2.depotfacid DESC NULLS LAST, last_service_dt desc) AS HAULING_SITE_rnk
	FROM ocs_sourced t1
	LEFT JOIN  compass t2 ON t1.depotfacid= t2.depotfacid AND t1.vehicle_id = t2.vehicle_id)
	WHERE sublob_rnk=1 AND HAULING_SITE_rnk=1)
--
-- So now lets coalesce the 2 tables.  Drive from compass but prefer the sublob from OCS - if available
--

SELECT t1.depotfacid AS fac_id, coalesce(t2.sublob, t1.sublob) AS sublob, count(*) AS truck_cnt
FROM compass t1 LEFT JOIN ocs_assignment t2 ON t1.depotfacid = t2.depotfacid AND t1.vehicle_id = t2.vehicle_id
WHERE coalesce(t2.sublob, t1.sublob) IS NOT null
GROUP BY fac_id, coalesce(t2.sublob, t1.sublob)
) AS "v_0000017686_0000133439");
