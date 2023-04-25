-- RUN ALL THIS AFTER IMPORTING TO DEAL WITH SOME ISSUES!

SET SQL_SAFE_UPDATES = 0;

-- Setting developer name to NULL where it is ''
UPDATE Developer
SET developerName = NULL
WHERE developer.developerName = '';

-- Deleting publishers with no games
DELETE PUBLISHER 
FROM publisher
  LEFT JOIN title
	ON publisher.publisherId = title.publisherId
WHERE title.publisherId IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- Sanity Checks
/*
SELECT * FROM developer;

SELECT publisher.publisherId, publisher.publisherName
FROM publisher LEFT JOIN title
	ON publisher.publisherId = title.publisherId
WHERE title.publisherId IS NULL;
*/
