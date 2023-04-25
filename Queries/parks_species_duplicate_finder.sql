-- FIND DUPLICATES
-- Find duplicates in species (WARNING! takes forever!)
SELECT species1.speciesId AS id1,  species2.speciesId AS id2, species1.scientificName
FROM species AS species1 INNER JOIN species AS species2
	ON species1.scientificName = species2.scientificName
WHERE species1.speciesId < species2.speciesId
ORDER BY scientificName;

-- Find duplicates in common name (WARNING! Takes forever!)
SELECT commonName1.nameId AS id1,  commonName2.nameId AS id2, commonName1.commonName
FROM commonName AS commonName1 INNER JOIN commonName AS commonName2
	ON commonName1.commonName = commonName2.commonName
WHERE commonName1.nameId < commonName2.nameId
ORDER BY commonName;

-- FIND NO MATCH
--  
SELECT publisher.publisherId, publisher.publisherName
FROM publisher LEFT JOIN title
	ON publisher.publisherId = title.publisherId
WHERE title.publisherId IS NULL;