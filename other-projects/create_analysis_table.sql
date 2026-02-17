-- ----------------------------------------------------------------------------
-- create_analysis_table.sql
--
-- This program creates a table that has one record per high school that can be
-- used to analyze distance from standard on math and ELA by percent of
-- students who are socioeconomically disadvantaged.
--
-- Written by Stephen Lew
-- ----------------------------------------------------------------------------

DROP TABLE IF EXISTS analysis;
CREATE TABLE analysis AS
-- Extract data on total enrollment and percent of students who are socioeconomically disadvantaged
-- The censusenrollratesdownload2024 is uniquely identified by cds, rtype, and studentgroup
WITH enrollment1 AS (
    SELECT *,
        -- Keep the record with data on socioeconomically disadvantaged students if possible.
        -- Schools that do not have any socioeconomically disadvantaged students do not
        -- have such a record. For those schools, keep the first record and then set the
        -- percentage of socioeconomically disadvantaged students to zero.
        (CASE
            WHEN studentgroup = "SED" THEN 1
            ELSE 0
         END) AS sed_record
    FROM censusenrollratesdownload2024
    -- Keep only records for schools. Drop district and state records.
    WHERE rtype = "S"
    ORDER BY cds, sed_record DESC, rtype, studentgroup
),
enrollment2 AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY cds ORDER BY sed_record DESC, rtype, studentgroup) AS row_num
    FROM enrollment1
),
enrollment3 AS (
    SELECT *           
    FROM enrollment2
    WHERE row_num = 1
    -- Data is now one record per school uniquely identified by cds.
),
enrollment4 AS (
    SELECT cds,
           schoolname,
           districtname,
           totalenrollment,
           (CASE
               WHEN sed_record = 0 THEN 0
               ELSE rate
            END) AS sed
    FROM enrollment3
),
-- Extract data on distance from standard on math
math AS (
    SELECT cds,
           currstatus AS math
    FROM mathdownload2024
    -- Keep only records for schools that have the data for all students.
    WHERE rtype = "S" AND studentgroup = "ALL"
    -- Data is now one record per school uniquely identified by cds.
),
-- Extract data on distance from standard on ELA
ela AS (
    SELECT cds,
           currstatus AS ela
    FROM eladownload2024
    -- Keep only records for schools that have the data for all students.
    WHERE rtype = "S" AND studentgroup = "ALL"
    -- Data is now one record per school uniquely identified by cds.
),
-- Extract a list of high schools. High schools have a record in the graduation rate data
hs AS (
    SELECT DISTINCT cds
    FROM graddownload2024
    -- Keep only records for schools. Drop district and state records.
    WHERE rtype = "S"
    -- Data is now one record per school uniquely identified by cds.
),
analysis1 AS (
    SELECT enr.*
    FROM hs
    INNER JOIN enrollment4 enr
    ON hs.cds = enr.cds
),
analysis2 AS (
    SELECT a1.*,
           math.math
    FROM analysis1 a1
    LEFT JOIN math
    ON a1.cds = math.cds
),
analysis3 AS (
    SELECT a2.*,
           ela.ela
    FROM analysis2 a2
    LEFT JOIN ela
    ON a2.cds = ela.cds
)
SELECT *
FROM analysis3
ORDER BY cds;
