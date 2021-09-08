
-- Perform aggregation functions across data set
SELECT
    firstName, track, MAX(raceTimeSeconds) 
    FROM cbtnuggets_window.races
    GROUP BY firstName, track;

SELECT
    firstName, track, MIN(raceTimeSeconds) 
    FROM cbtnuggets_window.races
    GROUP BY firstName, track;

SELECT
    firstName, track, ROUND(AVG(raceTimeSeconds))
    FROM cbtnuggets_window.races
    GROUP BY firstName, track;

-- Use a WINDOW in MySQL to answer questions about our data set
-- NOTE: The WINDOW keyword is only used if you're defining a window separately from the OVER clause
-- NOTE: The WINDOW is defined prior to the ORDER BY clause in a SELECT statement
SELECT
    firstName, track, raceTimeSeconds
    , SUM(raceTimeSeconds) OVER () AS 'TotalRaceTime'
    , SUM(raceTimeSeconds) OVER (PARTITION BY firstName) as 'RunnerRaceTime'
    , SUM(raceTimeSeconds) OVER runner_track as 'RunnerRaceTimeByTrack'
    , MIN(raceTimeSeconds) OVER runner_track as 'RunnerBestTimeOnTrack'
    FROM cbtnuggets_window.races
      WINDOW
          runner_track AS (firstName PARTITION BY track)
        , firstName AS (PARTITION BY firstName)
    ORDER BY firstName, track, raceTimeSeconds;

SELECT
    firstName, track, raceTimeSeconds
    , DENSE_RANK() OVER (PARTITION BY firstName, track ORDER BY raceTimeSeconds)
    FROM cbtnuggets_window.races;

SELECT
    firstName, track, raceTimeSeconds
    , DENSE_RANK() OVER (PARTITION BY firstName, track ORDER BY raceTimeSeconds)
    , COUNT(firstName) OVER (PARTITION BY firstName) AS 'NumberOfRacesPerRunner'
    FROM cbtnuggets_window.races;

SELECT * FROM (
    SELECT
        firstName, track, raceTimeSeconds
        , ROW_NUMBER() OVER (PARTITION BY firstName, track ORDER BY raceTimeSeconds DESC) AS `rownum`
        , COUNT(firstName) OVER (PARTITION BY firstName) AS 'NumberOfRacesPerRunner'
        FROM cbtnuggets_window.races) races 
    WHERE `rownum` <= 3;


