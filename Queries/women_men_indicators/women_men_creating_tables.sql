-- CREATING TABLES

-- Set foreign key checks to 0

SET FOREIGN_KEY_CHECKS=0;

-- Drop tables if they exist so to prevent errors
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS MarriageInfo;
DROP TABLE IF EXISTS MaternityInfo;
DROP TABLE IF EXISTS LeadershipInfo;

-- Create the tables
CREATE TABLE Country(
	countryId INT NOT NULL UNIQUE AUTO_INCREMENT,
    country VARCHAR(255),
    marriageId INT,
    maternityId INT,
    leadershipId INT,
    PRIMARY KEY (countryId)
);

CREATE TABLE MarriageInfo(
	marriageId INT NOT NULL UNIQUE AUTO_INCREMENT,
    infoYear YEAR,
    adolescentFemalePercent DECIMAL(4,2),
    adolescentMalePercent DECIMAL(4,2),
    femaleMeanAge DECIMAL(4,2),
    maleMeanAge DECIMAL(4,2),
    PRIMARY KEY (marriageId)
);

CREATE TABLE MaternityInfo(
	maternityId INT NOT NULL UNIQUE AUTO_INCREMENT,
    leaveLength VARCHAR(255),
    percentWagesPaid VARCHAR(255),
    benefitsProvider VARCHAR(255),
    PRIMARY KEY (maternityId)
);

CREATE TABLE LeadershipInfo(
	leadershipId INT NOT NULL UNIQUE AUTO_INCREMENT,
    infoYear YEAR(255),
    percentFemale TINYINT(2),
    PRIMARY KEY (leadershipId)
);

-- Add foreign keys
ALTER TABLE Country ADD FOREIGN KEY (`marriageId`) REFERENCES MarriageInfo(`marriageId`);
ALTER TABLE Country ADD FOREIGN KEY (`maternityId`) REFERENCES MaternityInfo(`maternityId`);
ALTER TABLE Country ADD FOREIGN KEY (`leadershipId`) REFERENCES LeadershipInfo(`leadershipId`);

-- SET FORIEGN KEY CHECKS 1
SET FOREIGN_KEY_CHECKS=1;