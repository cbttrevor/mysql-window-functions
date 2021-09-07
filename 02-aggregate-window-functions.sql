
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

SELECT
    firstName, track, raceTimeSeconds
    , SUM(raceTimeSeconds) OVER () AS 'TotalRaceTime'
    , SUM(raceTimeSeconds) OVER (PARTITION BY firstName) as 'RunnerRaceTime'
    , SUM(raceTimeSeconds) OVER (PARTITION BY firstName, track) as 'RunnerRaceTimeByTrack'
    FROM cbtnuggets_window.races
    ORDER BY firstName, track, raceTimeSeconds;
