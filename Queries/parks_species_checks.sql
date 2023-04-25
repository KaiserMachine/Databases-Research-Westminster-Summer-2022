-- Make sure everything is fine
SELECT * FROM species;

SELECT * FROM HASSpecies WHERE speciesId = 1;

SELECT * FROM CommonName;

SELECT * FROM HasCommonName;

SELECT * FROM commonName WHERE nameId = 26445;

SELECT * FROM HasCommonName
INNER JOIN commonName ON HasCommonName.nameId = commonName.nameId
WHERE speciesId = 2;
