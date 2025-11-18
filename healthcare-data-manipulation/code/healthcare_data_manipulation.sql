-- ----------------------------------------------
-- healthcare_data_manipulation.sql
--
-- This program manipulates synthetic healthcare data in various ways.
--
-- Written by Stephen Lew
-- ----------------------------------------------

-- JOIN DATA
-- Bring in descriptions of ICD-10 codes into the claims data.
-- Rename the new field from "description" to "diagnosis description".
DROP TABLE IF EXISTS tab_claim_data;
SELECT cd.*,
	icd.[description] AS diagnosis_description
INTO tab_claim_data
FROM SyntheticHealthcareData.dbo.claim_data cd
LEFT JOIN SyntheticHealthcareData.dbo.icd_codes icd
ON cd.diagnosis_code = icd.icd_code;

-- CREATE VARIABLE AND AGGREGATE DATA
-- Create a new table that has, for each insurance type, the rate at which claims are denied.
DROP TABLE IF EXISTS tab_denial_rate;
WITH work_denial_rate AS (
	SELECT *,
		(CASE
			WHEN claim_status = 'Denied' THEN 100.0
			ELSE 0.0
		 END) AS denial_rate
	FROM tab_claim_data
)
SELECT insurance_type,
	AVG(denial_rate) AS denial_rate
INTO tab_denial_rate
FROM work_denial_rate
GROUP BY insurance_type;

-- FILTER DATA
-- Subset the data to only records with a diagnosis code of A05.4 (Foodborne Bacillus cereus intoxication).
DROP TABLE IF EXISTS tab_filter;
SELECT *
INTO tab_filter
FROM tab_claim_data
WHERE diagnosis_code = 'A05.4';

-- SORT DATA
-- Sort data by date of service then claim ID.
SELECT *
FROM tab_claim_data
ORDER BY date_of_service,
	claim_id;

-- KEEP SELECT FIELDS
-- Keep only the fields for claim ID, procedure code, and diagnosis code.
DROP TABLE IF EXISTS tab_select;
SELECT claim_id,
	procedure_code,
	diagnosis_code
INTO tab_select
FROM tab_claim_data;