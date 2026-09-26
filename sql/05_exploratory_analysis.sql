/* =============================================================================
   SCRIPT: 05_exploratory_analysis.sql
   DESCRIPTION: Queries comparing riders across ride count, ride length, bike
                types, location patterns, and time patterns.
   
   KEY FINDINGS:
   - Ride Count: Members took ~3.89M rides and Casual riders took ~2.15M rides.
   - Ride Length: Members' ride length averaged 11.90 minutes, while Casual riders' 
     ride length averaged 20.73 minutes.
   - Bike Types: Both rider types preferred electric bikes (72% casuals, 67% members).
   - Same Stations: 8.74% of casual trips started and ended at the same station vs 
     only 3.16% for members.
   -Ride Count by Time: Members peaked once a day while casual riders peaked twice a
    day. Members' ride count decreased on the weekends while casual riders' ride count 
    increased on the weekends. 
   -Ride Length by Time: Members had very consistent ride lengths hourly and weekly, 
    slightly increasing on the weekends. Casual riders had various hourly changes,
    significantly increasing on the weekends. 
   ============================================================================= */

-- =============================================================================
-- SECTION 1: RIDE COUNT, RIDE LENGTH, & BIKE PREFERENCE
-- =============================================================================

-- Query 1.1: Overall Ride Count by Rider Type
SELECT 
  member_casual,
  COUNT(member_casual) AS ride_count
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual;


-- Query 1.2: Average Ride Length by Rider Type
SELECT 
  member_casual,
  AVG(ride_length) AS avg_ride_length
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual;


-- Query 1.3: Bike Type Preference
SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS ride_count,
  ROUND(
    COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual) * 100,
    2
  ) AS percentage_of_rides
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, rideable_type;


-- =============================================================================
-- SECTION 2: LOCATION & STATION PATTERNS
-- =============================================================================

-- Query 2.1: Top 10 Start Stations by Rider Type
SELECT
  member_casual,
  start_station_id,
  COUNT(*) AS ride_count,
  ROW_NUMBER() OVER (
    PARTITION BY member_casual
    ORDER BY COUNT(*) DESC
  ) AS station_rank
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
WHERE start_station_id IS NOT NULL
GROUP BY member_casual, start_station_id
ORDER BY station_rank, member_casual
LIMIT 20;


-- Query 2.2: Top 10 End Stations by Rider Type
SELECT
  member_casual,
  end_station_id,
  COUNT(*) AS ride_count,
  ROW_NUMBER() OVER (
    PARTITION BY member_casual
    ORDER BY COUNT(*) DESC
  ) AS station_rank
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
WHERE end_station_id IS NOT NULL
GROUP BY member_casual, end_station_id
ORDER BY station_rank, member_casual
LIMIT 20;


-- Query 2.3: Same Start and End Station Comparison
SELECT
  member_casual,
  COUNTIF(start_station_id = end_station_id) AS same_station_rides,
  COUNT(*) AS total_rides,
  ROUND(
    COUNTIF(start_station_id = end_station_id) / COUNT(*) * 100,
    2
  ) same_station_percentage
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
WHERE start_station_id IS NOT NULL
AND end_station_id IS NOT NULL
GROUP BY member_casual;


-- =============================================================================
-- SECTION 3: RIDE COUNT BY TIME
-- =============================================================================

-- Query 3.1: Hourly Rides and Rider Type
SELECT
  member_casual,
  EXTRACT(HOUR FROM started_at) AS hour_of_day,
  COUNT(*) AS ride_count,
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual, hour_of_day
ORDER BY hour_of_day, member_casual;


-- Query 3.2: Weekly Rides and Rider Type
SELECT
  member_casual,
  day_of_week,
  COUNT(*) AS ride_count,
  ROUND(
    COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY member_casual) * 100,
    2
  ) AS percentage_of_rides
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;


-- Query 3.3: Monthly Rides and Rider Type
SELECT
  member_casual,
  FORMAT_DATE('%Y-%m', DATE(started_at)) AS month,
  COUNT(*) AS ride_count
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY month, member_casual
ORDER BY month, member_casual;


-- =============================================================================
-- SECTION 4: RIDE LENGTH BY TIME
-- =============================================================================

-- Query 4.1: Hourly Ride Length and Rider Type
SELECT
  member_casual,
  EXTRACT(HOUR FROM started_at) AS hour_of_day,
  ROUND(AVG(ride_length), 2) AS avg_ride_length
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual, hour_of_day
ORDER BY member_casual, hour_of_day;


-- Query 4.2: Weekly Ride Length and Rider Type
SELECT
  member_casual,
  day_of_week,
  ROUND(AVG(ride_length), 2) AS avg_ride_length
FROM `cyclistic-analysis-505120.cyclistic_data.cleaned_data`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;
