-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MODEL_GOVERNING_CONSTRAINTS
CREATE VIEW MODEL_GOVERNING_CONSTRAINTS AS

SELECT

    SRC,

    FAC_ID,

    WASTE_TYPE,

    MIN(GOVERNING_MAX) AS MAX_TONS_GOVERNING_SCALED,

    MAX(GOVERNING_MIN) AS MIN_TONS_GOVERNING_SCALED

FROM MODEL_ALL_CONSTRAINTS

WHERE GOVERNING_MIN_FLAG=1 OR GOVERNING_MAX_FLAG=1

GROUP BY

    SRC,

    FAC_ID,

    WASTE_TYPE

;
