/*
Exploring the Shinkansen Station data
Used the 'Shinkansen Stations in Japan' Dataset on kaggle. https://www.kaggle.com/datasets/japandata509/shinkansen-stations-in-japan
*/

-- Create the ShinkansenStations table

CREATE TABLE ShinkansenStations (
    StationID INT IDENTITY(1,1) PRIMARY KEY,
    StationName NVARCHAR(255),
    LineName NVARCHAR(255),
    OpeningYear NVARCHAR(50),
    Prefecture NVARCHAR(255),
    DistanceFromTokyo NVARCHAR(50),
    Company NVARCHAR(255)
);

-- Imported data into the table and verified

SELECT * FROM ShinkansenStations

-- Clean Year
UPDATE ShinkansenStations SET OpeningYear = NULLIF(LTRIM(RTRIM(OpeningYear)), '');

ALTER TABLE ShinkansenStations ALTER COLUMN OpeningYear INT;

-- Clean Distance
UPDATE ShinkansenStations
SET DistanceFromTokyo = LTRIM(RTRIM(DistanceFromTokyo));

ALTER TABLE ShinkansenStations ALTER COLUMN DistanceFromTokyo DECIMAL(10,2);

-- Add Decade column
ALTER TABLE ShinkansenStations
ADD Decade AS (OpeningYear / 10) * 10;


-- Number of stations per line
SELECT LineName, COUNT(*) AS NumberOfStations
FROM ShinkansenStations
GROUP BY LineName
ORDER BY NumberOfStations DESC;

-- Average distance from Tokyo per line
SELECT LineName, AVG(DistanceFromTokyo) AS AverageDistanceFromTokyo
FROM ShinkansenStations
GROUP BY LineName
ORDER BY AverageDistanceFromTokyo DESC;

-- Number of stations opened per year
SELECT OpeningYear, COUNT(*) AS NumberOfStations
FROM ShinkansenStations
GROUP BY OpeningYear
ORDER BY OpeningYear;

-- Number of stations opened per decade
SELECT Decade, COUNT(*) AS NumberOfStations
FROM ShinkansenStations
WHERE Decade IS NOT NULL
GROUP BY Decade

-- Number of stations per prefecture
SELECT Prefecture, COUNT(*) AS NumberOfStations
FROM ShinkansenStations
GROUP BY Prefecture
ORDER BY NumberOfStations DESC;

-- Oldest and newest station per line
SELECT LineName, MIN(OpeningYear) AS OldestOpening, MAX(OpeningYear) AS NewestOpening
FROM ShinkansenStations
GROUP BY LineName


-- Which companies operate the longest distance stations
SELECT Company,AVG(DistanceFromTokyo) AS AvgDistance, MAX(DistanceFromTokyo) AS MaxDistance
FROM ShinkansenStations
GROUP BY Company
ORDER BY AvgDistance DESC;

-- Which lines expanded the fastest
SELECT LineName,OpeningYear, COUNT(*) AS StationsOpened
FROM ShinkansenStations
GROUP BY LineName, OpeningYear
ORDER BY LineName, OpeningYear;
