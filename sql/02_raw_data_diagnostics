/* =============================================================================
   SCRIPT: 02_raw_data_diagnostics.sql
   DESCRIPTION: Checked `combined_data` for duplicate records, out-of-range dates,
                missing values, invalid trip lengths, and improbable coordinates. 
   
   DIAGNOSTIC SUMMARY & FINDINGS:
   - Duplicates: Identified 35 exact duplicate ride_ids.
   - Timeframe: Identified 128 records starting before August 2025.
   - Categorical Data: Verified rideable_type and member_casual values were clean.
   - Null Values: Start/end station IDs, names, and end coordinates contained nulls.
   - Durations: Found 29 negative trip durations.
   ============================================================================= */

-- 1. Check for duplicate ride IDs
SELECT *
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data` 
WHERE ride_id IN (
  SELECT ride_id
  FROM `cyclistic-analysis-505120.cyclistic_data.combined_data` 
  GROUP BY ride_id
  HAVING COUNT(*) > 1
)
ORDER BY ride_id;


-- 2. Check date boundaries and identify out-of-range records
SELECT
  MIN(started_at) AS earliest_start,
  MIN(ended_at) AS earliest_end,
  MAX(started_at) AS latest_start,
  MAX(ended_at) AS latest_end
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;
 
SELECT 
  ride_id,
  started_at,
  ended_at
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`
WHERE started_at < '2025-08-01' OR started_at >= '2026-08-01';


-- 3. Verify distinct values in categorical columns
SELECT DISTINCT rideable_type
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;

SELECT DISTINCT member_casual
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;


-- 4. Inspect nulls in each field
SELECT 
  COUNTIF(ride_id IS NULL) AS ride_id_nulls,
  COUNTIF(rideable_type IS NULL) AS rideable_type_nulls,
  COUNTIF(started_at IS NULL) AS started_at_nulls,
  COUNTIF(ended_at IS NULL) AS ended_at_nulls,
  COUNTIF(start_station_name IS NULL) AS start_station_name_nulls,
  COUNTIF(start_station_id IS NULL) AS start_station_id_nulls,
  COUNTIF(end_station_name IS NULL) AS end_station_name_nulls,
  COUNTIF(end_station_id IS NULL) AS end_station_id_nulls,
  COUNTIF(start_lat IS NULL) AS start_lat_nulls,
  COUNTIF(start_lng IS NULL) AS start_lng_nulls,
  COUNTIF(end_lat IS NULL) AS end_lat_nulls,
  COUNTIF(end_lng IS NULL) AS end_lng_nulls,
  COUNTIF(member_casual IS NULL) AS member_casual_nulls
 FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;


-- 5. Inspect trip durations and identify zero or negative ride lengths
SELECT
  MAX(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS longest_ride,
  MIN(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)) AS shortest_ride
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;

SELECT 
  ride_id,
  started_at,
  ended_at,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 0
ORDER BY ride_length;


-- 6. Inspect coordinate boundaries
SELECT 
  MIN(start_lat) AS min_start_lat,
  MIN(end_lat) AS min_end_lat,
  MAX(start_lat) AS max_start_lat,
  MAX(end_lat) AS max_end_lat,
  MIN(start_lng) AS min_start_lng,
  MIN(end_lng) AS min_end_lng,
  MAX(start_lng) AS max_start_lng,
  MAX(end_lng) AS max_end_lng
FROM `cyclistic-analysis-505120.cyclistic_data.combined_data`;
