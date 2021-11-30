SET @db_name = 'cbtnuggets_window';

SET @drop_db = CONCAT('DROP DATABASE IF EXISTS ', @db_name); 
PREPARE dropdb FROM @drop_db;
EXECUTE dropdb;

SET @create_db = CONCAT('CREATE DATABASE IF NOT EXISTS ', @db_name);
PREPARE createdb from @create_db;
EXECUTE createdb;

CREATE TABLE IF NOT EXISTS cbtnuggets_window.races (
    firstName varchar(30),
    raceTimeSeconds int,
    track varchar(30)
);
DELETE FROM cbtnuggets_window.races;

DROP PROCEDURE IF EXISTS cbtnuggets_window.addRaceData;
DROP FUNCTION IF EXISTS cbtnuggets_window.getRandomRaceTime;
DELIMITER //
CREATE FUNCTION cbtnuggets_window.getRandomRaceTime () RETURNS INT DETERMINISTIC
    BEGIN
        RETURN ROUND((RAND() * (280-200))+200);
    END//
SELECT cbtnuggets_window.getRandomRaceTime();

CREATE PROCEDURE cbtnuggets_window.addRaceData ()
    BEGIN
        DELETE FROM cbtnuggets_window.races;
        INSERT INTO cbtnuggets_window.races 
            (firstName, raceTimeSeconds, track)
            VALUES 
              ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Denver')

            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Denver')

            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Denver')
            
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Tracy', cbtnuggets_window.getRandomRaceTime(), 'Seattle')

            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Jane', cbtnuggets_window.getRandomRaceTime(), 'Seattle')

            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            , ROW('Trevor', cbtnuggets_window.getRandomRaceTime(), 'Seattle')
            ;
    END//

DELIMITER ;

CALL cbtnuggets_window.addRaceData();

-- Verify that expected data is stored in table
SELECT * FROM cbtnuggets_window.races;
