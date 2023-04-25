-- CREATING TABLES

-- Set foreign key checks to 0

SET FOREIGN_KEY_CHECKS=0;

-- Drop tables if they exist so to prevent errors
DROP TABLE IF EXISTS Park;
DROP TABLE IF EXISTS State;
DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS CommonName;
DROP TABLE IF EXISTS HasState;
DROP TABLE IF EXISTS HasCommonName;
DROP TABLE IF EXISTS HasSpecies;

-- Create the tables
CREATE TABLE Park(
	id INT NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(255),
    acres INT,
    latitude DECIMAL(5,2),
    longitude DECIMAL(5,2),
    PRIMARY KEY (id)
);

CREATE TABLE State(
	stateId INT NOT NULL UNIQUE AUTO_INCREMENT,
    stateCode VARCHAR(255),
    stateName VARCHAR(255),
    PRIMARY KEY (stateId)
);

CREATE TABLE Species(
	speciesId INT NOT NULL UNIQUE AUTO_INCREMENT,
    scientificName VARCHAR(255),
    taxFamily VARCHAR(255),
    taxOrder VARCHAR(255),
    category VARCHAR(255),
    -- [Maybe Add conservation status]?
    PRIMARY KEY (speciesId)
);

CREATE TABLE CommonName(
	nameId INT NOT NULL UNIQUE AUTO_INCREMENT,
    commonName VARCHAR(255),
    PRIMARY KEY (nameId)
);

CREATE TABLE HasState(
	parkId INT NOT NULL,
    stateId INT NOT NULL,
    PRIMARY KEY (parkId, stateid)
);

CREATE TABLE HasCommonName(
	speciesId INT NOT NULL,
    nameId INT NOT NULL,
    PRIMARY KEY (speciesId, nameId)
);

CREATE TABLE HasSpecies(
	parkId INT NOT NULL,
    speciesId INT NOT NULL,
    nativeness ENUM('Native', 'Not Native', 'Unknown'),
    abundance ENUM('Abundant', 'Common', 'Occasional', 'Uncommon', 'Rare', 'Unknown'),
    PRIMARY KEY (parkId, speciesId)
);

-- Add foreign keys
ALTER TABLE HasState ADD FOREIGN KEY (`parkId`) REFERENCES Park(`id`);
ALTER TABLE HasState ADD FOREIGN KEY (`stateId`) REFERENCES State(`stateId`);

ALTER TABLE HasCommonName ADD FOREIGN KEY (`speciesId`) REFERENCES Species(`speciesId`);
ALTER TABLE HasCommonName ADD FOREIGN KEY (`nameId`) REFERENCES CommonName(`nameId`);

ALTER TABLE HasSpecies ADD FOREIGN KEY (`parkId`) REFERENCES Park(`id`);
ALTER TABLE HasSpecies ADD FOREIGN KEY (`speciesId`) REFERENCES Species(`speciesId`);

-- SET FORIEGN KEY CHECKS 1
SET FOREIGN_KEY_CHECKS=1;


-- TESTING INSERTS:
/*
SELECT * FROM park;
DELETE FROM Park WHERE id > 0;

INSERT INTO Park
VALUES(1, "[Test Park]", 1000, 20.50, -100.3),
	(2, '[Good Park]', 100000, 15.4, 98.2);

SELECT * FROM Species;

INSERT INTO Species
VALUES(1, 'Buffalo Testus Parkicus', '[Family]', '[Order]', 'Mammal', 'Native', 'Uncommon'),
	(2, 'Vascual Plant Testus Parkicus', '[Family]', '[Order]', 'Vascular Plant', 'Not Native', 'Abundant');


SELECT * FROM state;
DELETE FROM State WHERE stateId > 0;

INSERT INTO State
VALUES(1, 'UT', 'Utah'),
	(2, 'CA', 'California');



DELETE FROM Commonname WHERE nameId > 0;

SELECT * FROM commonname;

INSERT INTO Commonname
VALUES(1, 'Buffalo'),
	(2, 'Vascual Plant'),
    (3, 'Water Buffalo');


SELECT * FROM hasCommonName;

INSERT INTO HasCommonName
VALUES(1, 1),
	(1, 3),
    (2,2);
    
SELECT * FROM hasSpecies;

INSERT INTO HasSpecies
VALUES(1, 1),
	(1,2),
    (2, 2);

SELECT * FROM hasstate;

INSERT INTO HasState
VALUES(1, 1),
		(1, 2),
        (2,1);
*/
