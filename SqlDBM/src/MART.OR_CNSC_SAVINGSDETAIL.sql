-- ***************************** SqlDBM: Snowflake ****************************
-- * Generated by SqlDBM: MART SCHEMA, v18 by lesya.rylova+standard@gmail.com *


-- ************************************** MART.OR_CNSC_SAVINGSDETAIL
CREATE TABLE MART.OR_CNSC_SAVINGSDETAIL
(
 SOLUTION_ID         number(38,0),
 SCOPE_ID            varchar(50),
 CASE_ID             number(38,0),
 FAC_ID              varchar(50),
 CASE_NAME           varchar(50),
 FAC_TYPE            varchar(50),
 FAC_NAME            varchar(100),
 WM_DIRECT_TONS      number(20,4),
 WM_XFER_TONS        number(20,4),
 THIRD_PARTY_TONS    number(20,4),
 SHORTFALL_TONS      number(20,4),
 VAR_COST            number(20,4),
 TIP_FEES            number(20,4),
 POST_PROC_REV       number(20,4),
 TOTAL_VAR           number(20,4),
 FIXED_COST          number(20,4),
 TOTAL_FAC           number(20,4),
 WM_DISP_TRIP_HRS    number(20,10),
 DIRECT_FLOW_COST    number(20,4),
 XFER_FLOW_COST      number(20,4),
 TOTAL_FLOW_COST     number(20,4),
 TOTAL_FAC_PLUS_FLOW number(20,4),
 OWNERSHIP           varchar(20),
 PENALTY_COST        number(20,4)
);
