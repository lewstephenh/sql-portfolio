-- ----------------------------------------------
-- healthcare_data_manipulation.sql
--
-- This script represents a simplified ETL pipeline:
-- 1. Staging raw claims data
-- 2. Enriching with diagnosis metadata
-- 3. Producing analytic-ready tables and views for reporting
--
-- Written by Stephen Lew
-- ----------------------------------------------

-- STAGE DATA
-- Synthetic healthcare claims data
-- Source: https://www.kaggle.com/datasets/abuthahir1998/synthetic-healthcare-claims-dataset/data
DROP TABLE IF EXISTS claim_data;
CREATE TABLE claim_data (
	claim_id VARCHAR(10),
	provider_id VARCHAR(10),
	patient_id VARCHAR(10),
	date_of_service DATE,
	billed_amount FLOAT,
	procedure_code VARCHAR(5),
	diagnosis_code VARCHAR(8),
	allowed_amount FLOAT,
	paid_amount FLOAT,
	insurance_type VARCHAR(10),
	claim_status VARCHAR(12),
	reason_code VARCHAR(29),
	followup_required VARCHAR(3),
	ar_status VARCHAR(14),
	outcome VARCHAR(14)
);
BULK INSERT claim_data
FROM "C:\Users\Public\Documents\claim_data.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- ICD 10 code descriptions
-- Source: https://www.kaggle.com/datasets/mrhell/icd10cm-codeset-2023
DROP TABLE IF EXISTS icd_codes;
CREATE TABLE icd_codes (
	icd_code VARCHAR(8),
	[description] VARCHAR(228)
);
BULK INSERT icd_codes
FROM "C:\Users\Public\Documents\icd_codes.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- JOIN DATA
-- Bring in descriptions of ICD-10 codes into the claims data.
-- Rename the new field from "description" to "diagnosis description".
DROP TABLE IF EXISTS tab_claim_data;
SELECT cd.*,
	icd.[description] AS diagnosis_description
INTO tab_claim_data
FROM claim_data cd
LEFT JOIN icd_codes icd
ON cd.diagnosis_code = icd.icd_code;
GO

-- VALIDATE DATA
-- Check that all diagnosis codes successfully map to ICD-10.
CREATE OR ALTER VIEW vw_diagnosis_codes_check AS
SELECT COUNT(*) AS unmapped_codes
FROM tab_claim_data
WHERE diagnosis_description IS NULL
GO

-- CREATE VARIABLE AND AGGREGATE DATA
-- Create a new table that has, for each insurance type, the rate at which claims are denied.
DROP TABLE IF EXISTS tab_denial_rate;
WITH work_denial_rate AS (
	SELECT *,
		(CASE
			WHEN claim_status = 'Denied' THEN 100.0
            WHEN claim_status = 'Paid' THEN 0.0
		 END) AS denial_rate
	FROM tab_claim_data
)
SELECT insurance_type,
	AVG(denial_rate) AS denial_rate
INTO tab_denial_rate
FROM work_denial_rate
GROUP BY insurance_type;
GO

-- STORED PROCEDURE
-- FILTER AND SORT DATA
-- Subset the data to only records with a diagnosis code of A05.4 (Foodborne Bacillus cereus intoxication).
-- Sort data by date of service then claim ID.
DROP PROCEDURE IF EXISTS diagnosis_filter;
GO

CREATE PROCEDURE diagnosis_filter
	@p_diagnosis_code VARCHAR(8)
AS
BEGIN
	SELECT *
	FROM tab_claim_data
	WHERE diagnosis_code = @p_diagnosis_code
	ORDER BY date_of_service,
		claim_id;
END
GO

EXEC diagnosis_filter @p_diagnosis_code = 'A05.4';
GO

-- KEEP SELECT FIELDS
-- Keep only the fields for claim ID, procedure code, and diagnosis code.
CREATE OR ALTER VIEW vw_select AS
SELECT claim_id,
	procedure_code,
	diagnosis_code
FROM tab_claim_data;
GO