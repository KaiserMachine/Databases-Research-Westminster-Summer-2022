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
    rating ENUM('E', 'E10+', 'T', 'M', 'RP'),
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
	titleId INT NOT NULL AUTO_INCREMENT,
	platformId INT NOT NULL AUTO_INCREMENT,
    salesNA DECIMAL(2,2),
	salesEU DECIMAL(2,2),
    salesJP DECIMAL(2,2),
	salesOther DECIMAL(2,2),
    salesGlobal DECIMAL(2,2),
    criticScore INT,
    criticCount INT,
    userScore INT,
    userCount INT,
    PRIMARY KEY (titleId, platformId)
);

CREATE TABLE hasDeveloper(
	titleId INT NOT NULL AUTO_INCREMENT,
	developerId INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (titleId, developerId)
);


-- Add foreign keys
-- Title foreign keys
ALTER TABLE Title ADD FOREIGN KEY (`genreId`) REFERENCES Genre(`genreId`);
ALTER TABLE Title ADD FOREIGN KEY (`publisherId`) REFERENCES Publihser(`publisherId`);

-- TitleOnPlatform foreign keys
ALTER TABLE TitleOnPlatform ADD FOREIGN KEY (`titleId`) REFERENCES Title(`id`);
ALTER TABLE TitleOnPlatform ADD FOREIGN KEY (`platformId`) REFERENCES Platform(`platformId`);

-- hasDeveloper foreign keys
ALTER TABLE hasDeveloper ADD FOREIGN KEY (`titleId`) REFERENCES Title(`id`);
ALTER TABLE hasDeveloper ADD FOREIGN KEY (`developerId`) REFERENCES Developer(`developerId`);




