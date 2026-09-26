/* =============================================================================
   SCRIPT: 03_create_cleaned_table.sql
   DESCRIPTION: Creates the table `cleaned_data` by applying filtering rules based
                on script 02 and adding the columns `ride_length` and `day_of_week`.
   ============================================================================= */

CREATE OR REPLACE TABLE `cyclistic-analysis-505120.cyclistic_data.cleaned_data` AS
SELECT DISTINCT
   *,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`
WHERE started_at >= '2025-08-01'
  AND started_at < '2026-08-01'
  AND ended_at > started_at;
