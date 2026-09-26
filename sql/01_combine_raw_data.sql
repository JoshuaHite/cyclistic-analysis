/* =============================================================================
   SCRIPT: 01_combine_raw_data.sql
   DESCRIPTION: Unifies the 12 monthly datasets, August 2025 to July 2026, into
                a single table for analysis.
   ============================================================================= */

CREATE TABLE IF NOT EXISTS `cyclistic-analysis-505120.cyclistic_data.combined_data` AS
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2025_08` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2025_09` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2025_10` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2025_11` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2025_12` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_01` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_02` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_03` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_04` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_05` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_06` UNION ALL
SELECT * FROM `cyclistic-analysis-505120.cyclistic_data.2026_07`;
