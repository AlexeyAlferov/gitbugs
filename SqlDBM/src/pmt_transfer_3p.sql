-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** pmt_transfer_3p
CREATE VIEW pmt_transfer_3p AS

WITH filtered_rollup AS

( SELECT *

FROM stg.pmt_transfer_rollup

WHERE data_dt BETWEEN 

        get_3p_start_date(

              $num_weeks_3p

            , $start_date

            , $end_date

            , get_3p_end_date($num_weeks_3p, $start_date, $end_date,

                           (SELECT MAX(data_dt) FROM stg.pmt_transfer_rollup))

            ) AND

            get_3p_end_date($num_weeks_3p, $start_date, $end_date,

                            (SELECT MAX(data_dt) FROM stg.pmt_transfer_rollup))

    AND (tons_ext_msw + tons_ext_cd + tons_ext_oth + tons_ext_rms) > 0

    AND UPPER(ROLLUP_TYPE)='W' --Use weekly totals only, E is cumulative and M is monthly



),

    pmt_transfer_exploded AS

(

    SELECT *

    FROM filtered_rollup

    UNPIVOT(third_party FOR waste_type 

        IN (tons_ext_msw, tons_ext_cd, tons_ext_oth, tons_ext_rms)

    )

)

SELECT fac_idu || '_TS' AS fac_id

    , DATE_PART('weekday', data_dt) AS day_of_week

    , CASE

        WHEN waste_type = 'TONS_EXT_CD' THEN 'C&D'

        ELSE UPPER(REGEXP_SUBSTR(waste_type, 'tons_ext_\([[:alnum:]]+\)', 1, 1, 'i',1))

      END AS waste_type

    , AVG(third_party)/6 AS avg_third_party --Average across the weeks and divide the average by 6 (excludes Sundays) to get a daily

FROM pmt_transfer_exploded

GROUP BY fac_id, day_of_week, waste_type

ORDER BY fac_id, day_of_week, waste_type;
