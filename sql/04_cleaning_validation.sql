/* =============================================================================
   SCRIPT: 04_cleaning_validation.sql
   DESCRIPTION: Verification script confirming that duplicate records, out-of-range
                dates, and invalid trip lengths were successfully removed.
   ============================================================================= */

-- 1. Confirms there are no duplicate records
SELECT *
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data` 
WHERE ride_id IN (
  SELECT ride_id
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data` 
GROUP BY ride_id
HAVING COUNT(*) > 1
)
ORDER BY ride_id;


-- 2. Confirms there are no records outside of the timeframe
SELECT
  MIN(started_at) AS earliest_start,
  MIN(ended_at) AS earliest_end,
  MAX(started_at) AS latest_start,
  MAX(ended_at) AS latest_end
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`;


-- 3. Confirms there are no invalid ride lengths
SELECT 
  ride_id,
  started_at,
  ended_at,
  ride_length
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
WHERE ride_length < 0
ORDER BY ride_length;
