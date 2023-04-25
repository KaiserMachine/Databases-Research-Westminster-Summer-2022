-- WORK ON VIDEO GAME SALES AND RATINGS
-- Part 1 (Setting up tables)
-- Setting foreign key checks to false so we can add them later
SET FOREIGN_KEY_CHECKS=0;

-- Drop tables if they exist so to prevent errors
DROP TABLE IF EXISTS title;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS developer;
DROP TABLE IF EXISTS platform;
DROP TABLE IF EXISTS titleOnPlatform;
DROP TABLE IF EXISTS hasDeveloper;

-- Create the tables
CREATE TABLE Title(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    releaseYear YEAR,
    rating ENUM('EC', 'E', 'E10+', 'T', 'M', 'RP'),
    genreId INT NOT NULL,
    publisherId INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Platform(
	platformId INT NOT NULL AUTO_INCREMENT,
    platformName VARCHAR(255),
    PRIMARY KEY (platformId)
);

CREATE TABLE Genre(
	genreId INT NOT NULL AUTO_INCREMENT,
    genreName VARCHAR(255),
    PRIMARY KEY (genreId)
);

CREATE TABLE Publisher(
	publisherId INT NOT NULL AUTO_INCREMENT,
    publisherName VARCHAR(255),
    PRIMARY KEY (publisherId)
); 

CREATE TABLE Developer(
	developerId INT NOT NULL AUTO_INCREMENT,
    developerName VARCHAR(255),
    PRIMARY KEY (developerId)
);

CREATE TABLE titleOnPlatform(
	titleId INT NOT NULL ,
	platformId INT NOT NULL ,
    salesNA DECIMAL(5,2),
	salesEU DECIMAL(5,2),
    salesJP DECIMAL(5,2),
	salesOther DECIMAL(5,2),
    salesGlobal DECIMAL(5,2),
    criticScore INT,
    criticCount INT,
    userScore DECIMAL(5,1),
    userCount INT,
    PRIMARY KEY (titleId, platformId)
);

CREATE TABLE hasDeveloper(
	titleId INT NOT NULL ,
	developerId INT NOT NULL ,
    PRIMARY KEY (titleId, developerId)
);


-- ADD FOREIGN KEYS
-- Title foreign keys
ALTER TABLE Title ADD FOREIGN KEY (`genreId`) REFERENCES Genre(`genreId`);
ALTER TABLE Title ADD FOREIGN KEY (`publisherId`) REFERENCES publisher(`publisherId`);

-- TitleOnPlatform foreign keys
ALTER TABLE TitleOnPlatform ADD FOREIGN KEY (`titleId`) REFERENCES Title(`id`);
ALTER TABLE TitleOnPlatform ADD FOREIGN KEY (`platformId`) REFERENCES Platform(`platformId`);

-- hasDeveloper foreign keys
ALTER TABLE hasDeveloper ADD FOREIGN KEY (`titleId`) REFERENCES Title(`id`);
ALTER TABLE hasDeveloper ADD FOREIGN KEY (`developerId`) REFERENCES Developer(`developerId`);

-- SIMPLE INSERTIONS
-- NOT HERE FOR NOW

-- SET FORIEGN KEY CHECKS 1
SET FOREIGN_KEY_CHECKS=1;

-- CHECKING (uncomment this!)
/*
SELECT title.name, title.id, titleOnPlatform.* FROM title
INNER JOIN titleOnPlatform WHERE title.id = titleOnPlatform.titleId AND title.name = "Half Life 3";

-- User variables in stored procedure for adding title info
DROP PROCEDURE sp_AddTitle;

DELIMITER //
CREATE PROCEDURE sp_AddTitle(IN genreName VARCHAR(255), IN publisherName VARCHAR(255), IN id INT, IN name VARCHAR(255),
IN releaseYear YEAR, IN rating ENUM('EC','E','E10+','T','M','RP', 'NULL'))
BEGIN
    SET @genreId = (SELECT genreId FROM Genre WHERE Genre.genreName = genreName LIMIT 1);
	SET @publisherId = (SELECT publisherId FROM Publisher WHERE Publisher.publisherName = publisherName LIMIT 1);
    INSERT INTO Title
	VALUES(id, name, releaseYear, rating,  @genreId, @publisherId);
END //
DELIMITER ;

DELETE FROM Title WHERE id > 0;

CALL sp_AddTitle("Misc", "Nintendo", 1, 'Wii Sports', 2006, "E");


SELECT * FROM title;

SELECT * FROM genre;


DROP PROCEDURE sp_AddHasDeveloper;

DELIMITER //
CREATE PROCEDURE sp_AddHasDeveloper(IN devName VARCHAR(255), IN titleName VARCHAR(255))
BEGIN
	SET @developerId = (SELECT developerId FROM developer WHERE developer.developerName = devName LIMIT 1);
	SET @titleId = (SELECT id FROM Title WHERE title.name = titleName LIMIT 1);
	SET @developerIdFinal = (SELECT IFNULL(@developerId, 2));
	INSERT INTO HasDeveloper
	VALUES(@titleId, @developerIdFinal);
END //
DELIMITER ;

SELECT * FROM developer WHERE developerName LIKE "%Bungie%";

SELECT * FROM developer WHERE developerName LIKE "%CyberPlanet Interactive Public%";
SELECT * FROM developer WHERE developerName LIKE "%ltd%";

SELECT * FROM title WHERE name = "Sakura Wars 4: Koi Seyo,Otome";

SELECT * FROM developer WHERE developerName = "Relic";

SELECT title.name, publisher.publisherName
FROM Publisher 
INNER JOIN title
ON title.publisherId = publisher.publisherID;

SELECT * FROM Title;

-- REMOVE THE FIRST " " (space) from a few rows.
-- UPDATE title
-- SET title.name = SUBSTR(title.name, 2)
-- WHERE id = 884 OR id = 2476 OR id = 9398 OR id = 1868;
SELECT * FROM platform;

DROP PROCEDURE sp_AddTitleOnPlatform;

DELIMITER //
CREATE PROCEDURE sp_AddTitleOnPlatform(IN titleName VARCHAR(255), IN platformName VARCHAR(255), IN salesNA DECIMAL(5,2),
IN salesEU DECIMAL(5,2), IN salesJP DECIMAL(5,2), IN salesOther DECIMAL(5,2), IN salesGlobal DECIMAL(5,2),
IN criticScore INT, IN criticCount INT, IN userScore DECIMAL(5,1), IN userCount INT)
BEGIN
    SET @titleId = (SELECT id FROM Title WHERE Title.name = titleName LIMIT 1);
	SET @platformId = (SELECT platformId FROM Platform WHERE Platform.platformName = platformName LIMIT 1);
    INSERT INTO TitleOnPlatform
	VALUES(@titleId, @platformId, salesNA, salesEU, salesJP, salesOther, salesGlobal, criticScore, criticCount, userScore, userCount);
END //
DELIMITER ;


SELECT * FROM title WHERE name LIKE "%Call of Duty%";
SELECT * FROM Platform WHERE platformId = 5;
SELECT * FROM TitleOnPlatform WHERE titleId = 35;
*/

-- TESTS
/*
SELECT * FROM Developer;
SELECT * FROM Genre;
SELECT * FROM hasdeveloper;
SELECT * FROM Platform;
SELECT * FROM Publisher;
SELECT * FROM Title;
SELECT * FROM TitleOnPlatform;
*/


