SELECT * FROM park;
SELECT * FROM hasstate;

DROP PROCEDURE sp_AddHasState;

DELIMITER //
CREATE PROCEDURE sp_AddHasState(IN parkName VARCHAR(255), IN stateCode VARCHAR(255))
BEGIN
	SET @parkId = (SELECT id FROM Park WHERE park.name = parkName);
	SET @stateId = (SELECT stateId FROM State WHERE state.stateCode = stateCode);
	-- SET @developerIdFinal = (SELECT IFNULL(@developerId, 2));
	INSERT INTO HasState
	VALUES(@parkId, @stateId);
END //
DELIMITER ;

SELECT * FROM Species;


DROP PROCEDURE sp_AddHasSpecies;

DELIMITER //
CREATE PROCEDURE sp_AddHasSpecies(IN parkName VARCHAR(255), IN scientificName VARCHAR(255))
BEGIN
	SET @parkId = (SELECT id FROM Park WHERE park.name = parkName);
	SET @speciesId = (SELECT speciesId FROM Species WHERE Species.scientificName = scientificName);
	-- SET @developerIdFinal = (SELECT IFNULL(@developerId, 2));
	INSERT INTO hasspecies
	VALUES(@parkId, @speciesId);
END //
DELIMITER ;


-- DELETE FROM Species WHERE speciesId = 7656;
SELECT * FROM Species WHERE Species.scientificName = "Physa virgata";

DELETE FROM species WHERE SpeciesId;

SELECT * FROM Species;

SELECT * FROM hasState;

DELETE FROM hasState WHERE stateId > 0;

DELETE FROM Species WHERE speciesId > 0;

SELECT * FROM State;

DELETE FROM State where stateId > 0;

SELECT * FROM park;

DELETE FROM Park WHERE id > 0;

SELECT * FROM Park;

SELECT * FROM Species;

ALTER TABLE hasSpecies
ADD COLUMN nativeness ENUM('Native','Not Native','Unknown') AFTER speciesId,
ADD COLUMN abundance ENUM('Abundant','Common','Occasional','Uncommon','Rare','Unknown') AFTER nativeness;

ALTER TABLE Species
DROP COLUMN nativeness,
DROP COLUMN abundance;
