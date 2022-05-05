-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** VALIDATION_DETAIL
CREATE VIEW VALIDATION_DETAIL AS

SELECT VAL.VALIDATION_ID VALIDATION_ID,

VM.TABLE_NAME AS TABLE_NM,

VM.test_NAME AS test_NM,

VAL.DETAIL,

VM.SORT_ORDER,

VAL.SEQ,

VM.test_TYPE  AS test_TYPE,

VM.TARGET_LH_SCREEN AS TARGET_LH_SCREEN,

VAL.LH_PARM_1 as LH_PARM_1,

VAL.LH_PARM_2 as LH_PARM_2,

VAL.LH_PARM_3 as LH_PARM_3,

VAL.LH_PARM_4 as LH_PARM_4,

VAL.LH_PARM_5 as LH_PARM_5

FROM

(

	(

		SELECT 1 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY A.FAC_ID DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_COMPLETENESS_MODEL_FACILITIES A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 2 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY DEPOTFACID DESC NULLS LAST,OCS_DISPOSAL_CD DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_COMPLETENESS_MODEL_COLLECTION_POINTS A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 4 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY A.DEPOTFACID DESC NULLS LAST, A.OCS_DISPOSAL_CD DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_COMPLETENESS_MODEL_COLL_PTS_BAD_FAC_ID A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 5 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY FAC_ID DESC NULLS LAST, SUBLOB DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_HRS_CAP A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 6 VALIDATION_ID

		,ROW_NUMBER() OVER (ORDER BY FAC_ID DESC NULLS LAST, SUBLOB DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_LIMITED_TRUCK_CAPACITY A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 9 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY A.LANE_ORIGIN_FAC_ID DESC NULLS LAST, A.LANE_DESTINATION_FAC_ID DESC NULLS LAST, A.WASTE_TYPE DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_TRANSFER_LANE_NULL_LOAD_SIZE A

		ORDER BY SEQ

	)



	UNION All



	(

		SELECT 21 VALIDATION_ID

		,ROW_NUMBER() OVER (ORDER BY DETAIL DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,NULL AS LH_PARM_1

		,NULL AS LH_PARM_2

		,NULL AS LH_PARM_3

		,NULL as LH_PARM_4

		,NULL as LH_PARM_5

		FROM VALIDATION_DATA_CHECK_FLOW_CONTROL_MATERIAL_ACCEPTANCE A

		ORDER BY SEQ

	)



	UNION All



	(

		SELECT 22 VALIDATION_ID

		,ROW_NUMBER() OVER (ORDER BY DETAIL DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_TRANSFER_LANE_DESTINATION_MATERIAL_ACCEPTANCE A

		ORDER BY SEQ

	)



	UNION All



	(

		SELECT 8 VALIDATION_ID

		,ROW_NUMBER() OVER (ORDER BY FAC_ID DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_ORIGIN_TRANSFER_LANE_MATERIAL_ACCEPTANCE A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 19 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_CHECK_DISPOSAL_WASTE_TYPE_LEGALITY A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 3 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY A.DISPOSAL_FACILITY_ID DESC NULLS LAST, A.WASTE_TYPE DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_CHECK_EMPTY_WASTE_TYPE_ACCEPTANCE A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 10 VALIDATION_ID

		,ROW_NUMBER() OVER (ORDER BY GREAT_CIRCLE_MILES DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_SUSPICIOUS_LOC_MATCH A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 11 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_HRS_CAP_ACTIVE_FACILITIES A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 12 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_TRANSFER_LANES_LEGAL A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 7 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY DEPOTFACID DESC NULLS LAST, SUBLOB DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_FLEET_CAPACITY_EXISTS A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 18 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_CHECK_FAC_MAT_UNKNOWN_WASTE_TYPE A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 23 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_OMITTED_DCO_FROZEN_CPS A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 15 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_PRE_MODEL_NO_LONG_HAUL_COST A

		ORDER BY SEQ

	)





	UNION ALL



	(

		SELECT 13 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_PRE_MODEL_NO_UNIT_COST A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 14 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_PRE_MODEL_NO_UNIT_PRICE A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 17 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_PRE_MODEL_NO_TURN_TIME A

		ORDER BY SEQ

	)



	UNION ALL



	(

		SELECT 16 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY TOTAL_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_PRE_MODEL_NO_LOAD_SIZE A

		ORDER BY SEQ

	)



		UNION ALL



	(

		SELECT 25 VALIDATION_ID

		,ROW_NUMBER() OVER(ORDER BY CP_TONS DESC NULLS LAST) AS SEQ

		,A.DETAIL AS DETAIL

		,A.LH_PARM_1 as LH_PARM_1

		,A.LH_PARM_2 as LH_PARM_2

		,A.LH_PARM_3 as LH_PARM_3

		,A.LH_PARM_4 as LH_PARM_4

		,A.LH_PARM_5 as LH_PARM_5

		FROM VALIDATION_DATA_CPS_WITH_NO_TMS_HISTORICAL_TONNAGE A

		ORDER BY SEQ

	)



) VAL INNER JOIN VALIDATION_METADATA VM

ON VAL.VALIDATION_ID=VM.VALIDATION_ID

ORDER BY SORT_ORDER, SEQ;
