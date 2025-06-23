-- ----------------------------------------------------------------------------
-- import_csv_files.sql
--
-- This program imports data used in the California School Dashboard.
--
-- Written by Stephen Lew
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS censusenrollratesdownload2024;
CREATE TABLE censusenrollratesdownload2024 (
    cds VARCHAR(14),
    rtype VARCHAR(1),
    schoolname VARCHAR(100),
    districtname VARCHAR(100),
    countyname VARCHAR(100),
    studentgroup VARCHAR(3),
    totalenrollment DOUBLE,
    subgrouptotal DOUBLE,
    rate DOUBLE,
    reportingyear DOUBLE
);
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/censusenrollratesdownload2024.csv"
INTO TABLE censusenrollratesdownload2024
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS mathdownload2024;
CREATE TABLE mathdownload2024 (
    cds VARCHAR(14),
    rtype VARCHAR(1),
    schoolname VARCHAR(100),
    districtname VARCHAR(100),
    countyname VARCHAR(100),
    charter_flag VARCHAR(1),
    coe_flag VARCHAR(1),
    dass_flag VARCHAR(1),
    studentgroup VARCHAR(4),
    currdenom DOUBLE,
    currstatus DOUBLE,
    priordenom DOUBLE,
    priorstatus DOUBLE,
    `change` DOUBLE,
    statuslevel DOUBLE,
    changelevel DOUBLE,
    color DOUBLE,
    box DOUBLE,
    currnsizemet VARCHAR(1),
    priornsizemet VARCHAR(1),
    accountabilitymet VARCHAR(1),
    hscutpoints VARCHAR(1),
    pairshare_method VARCHAR(2),
    currprate_enrolled DOUBLE,
    currprate_tested DOUBLE,
    currprate DOUBLE,
    currnumPRLOSS DOUBLE,
    currdenom_withoutPRLOSS DOUBLE,
    currstatus_withoutPRLOSS DOUBLE,
    priorprate_enrolled DOUBLE,
    priorprate_tested DOUBLE,
    priorprate DOUBLE,
    priornumPRLOSS DOUBLE,
    priordenom_withoutPRLOSS DOUBLE,
    priorstatus_withoutPRLOSS DOUBLE,
    indicator VARCHAR(4),
    reportingyear DOUBLE
);
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mathdownload2024.csv"
INTO TABLE mathdownload2024
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS eladownload2024;
CREATE TABLE eladownload2024 (
    cds VARCHAR(14),
    rtype VARCHAR(1),
    schoolname VARCHAR(100),
    districtname VARCHAR(100),
    countyname VARCHAR(100),
    charter_flag VARCHAR(1),
    coe_flag VARCHAR(1),
    dass_flag VARCHAR(1),
    studentgroup VARCHAR(4),
    currdenom DOUBLE,
    currstatus DOUBLE,
    priordenom DOUBLE,
    priorstatus DOUBLE,
    `change` DOUBLE,
    statuslevel DOUBLE,
    changelevel DOUBLE,
    color DOUBLE,
    box DOUBLE,
    currnsizemet VARCHAR(1),
    priornsizemet VARCHAR(1),
    accountabilitymet VARCHAR(1),
    hscutpoints VARCHAR(1),
    pairshare_method VARCHAR(2),
    currprate_enrolled DOUBLE,
    currprate_tested DOUBLE,
    currprate DOUBLE,
    currnumPRLOSS DOUBLE,
    currdenom_withoutPRLOSS DOUBLE,
    currstatus_withoutPRLOSS DOUBLE,
    priorprate_enrolled DOUBLE,
    priorprate_tested DOUBLE,
    priorprate DOUBLE,
    priornumPRLOSS DOUBLE,
    priordenom_withoutPRLOSS DOUBLE,
    priorstatus_withoutPRLOSS DOUBLE,
    indicator VARCHAR(4),
    reportingyear DOUBLE
);
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/eladownload2024.csv"
INTO TABLE eladownload2024
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS graddownload2024;
CREATE TABLE graddownload2024 (
    cds VARCHAR(14),
    rtype VARCHAR(1),
    schoolname VARCHAR(100),
    districtname VARCHAR(100),
    countyname VARCHAR(100),
    charter_flag VARCHAR(1),
    coe_flag VARCHAR(1),
    dass_flag VARCHAR(1),
    studentgroup VARCHAR(4),
    currnumer DOUBLE,
    currdenom DOUBLE,
    currstatus DOUBLE,
    priornumer DOUBLE,
    priordenom DOUBLE,
    priorstatus DOUBLE,
    `change` DOUBLE,
    statuslevel DOUBLE,
    changelevel DOUBLE,
    color DOUBLE,
    box DOUBLE,
    smalldenom VARCHAR(1),
    fiveyrnumer DOUBLE,
    currnsizemet VARCHAR(1),
    priornsizemet VARCHAR(1),
    accountabilitymet VARCHAR(1),
    indicator VARCHAR(4),
    reportingyear DOUBLE
);
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/graddownload2024.csv"
INTO TABLE graddownload2024
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;