# Header ------------------------------------------------------------------
# create_csv_import_files.r
#
# This program downloads tab-delimited text files that contain data used in
# the California School Dashboard and converts them to comma-delimited text
# files to be imported into a MySQL server.
#
# Written by Stephen Lew



# Load packages -----------------------------------------------------------
library(tidyverse)



# Download and convert data -----------------------------------------------
enrollment <- read_tsv("https://www3.cde.ca.gov/researchfiles/cadashboard/censusenrollratesdownload2024.txt", guess_max = Inf)
enrollment |> write.csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/censusenrollratesdownload2024.csv", na = "NULL", row.names = FALSE)

math <- read_tsv("https://www3.cde.ca.gov/researchfiles/cadashboard/mathdownload2024.txt", guess_max = Inf)
math |> write.csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mathdownload2024.csv", na = "NULL", row.names = FALSE)

ela <- read_tsv("https://www3.cde.ca.gov/researchfiles/cadashboard/eladownload2024.txt", guess_max = Inf)
ela |> write.csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/eladownload2024.csv", na = "NULL", row.names = FALSE)

hs <- read_tsv("https://www3.cde.ca.gov/researchfiles/cadashboard/graddownload2024.txt", guess_max = Inf)
hs |> write.csv("C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/graddownload2024.csv", na = "NULL", row.names = FALSE)
