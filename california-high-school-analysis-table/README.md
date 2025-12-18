# California High School Analysis Table

## Description
Developed a SQL-based data transformation pipeline to produce a high-school–level analytical table, consolidating enrollment, socioeconomic, and academic performance data into a single record per school. The workflow leverages layered CTEs, window functions, and conditional logic to deduplicate and normalize statewide education datasets, explicitly handling schools with zero socioeconomically disadvantaged students. High schools are identified via graduation rate records, and math and ELA distance-from-standard metrics are joined to enable analysis of academic performance relative to socioeconomic composition.

Tech stack: SQL, CTEs, window functions, joins, data validation, education data analytics.

## File Information
| Program Name              | Last Updated | Purpose                                        |
|---------------------------|--------------|------------------------------------------------|
| create_csv_import_files.r | 6/22/2025    | Downloads tab-delimited text files that contain data used in the California School Dashboard and converts them to comma-delimited text files to be imported into a MySQL server. |
| import_csv_files.sql      | 6/22/2025    | Imports data used in the California School Dashboard into a MySQL server |
| create_analysis_table.sql | 6/22/2025    | Creates a table that has one record per high school that can be used to analyze distance from standard on math and ELA by percent of students who are socioeconomically disadvantaged. |
