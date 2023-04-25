SELECT developer1.developerId AS id1, developer2.developerId AS id2, developer1.developerName
FROM developer AS developer1 INNER JOIN developer AS developer2
	ON developer1.developerName = developer2.developerName
WHERE developer1.developerId < developer2.developerId
ORDER BY developerName;

SELECT * FROM developer WHERE developerName = "Sims";

SELECT publisher1.publisherId AS id1, publisher2.publisherId AS id2, publisher1.publisherName
FROM publisher AS publisher1 INNER JOIN publisher AS publisher2
	ON publisher1.publisherName = publisher2.publisherName
WHERE publisher1.publisherId < publisher2.publisherId
ORDER BY publisherName;

SELECT * FROM publisher WHERE publisherName = "Square Enix";

-- FINDING DUPLICATES

SELECT developer1.developerId AS id1, developer2.developerId AS id2, developer1.developerName
FROM developer AS developer1 INNER JOIN developer AS developer2
	ON developer1.developerName = developer2.developerName
WHERE developer1.developerId < developer2.developerId
ORDER BY developerName;

SELECT * FROM publisher WHERE publisherName = "Square Enix";
SELECT * FROM title where publisherId = 110;

SELECT publisher1.publisherId AS id1, publisher2.publisherId AS id2, publisher1.publisherName
FROM publisher AS publisher1 INNER JOIN publisher AS publisher2
	ON publisher1.publisherName = publisher2.publisherName
WHERE publisher1.publisherId < publisher2.publisherId
ORDER BY publisherName;

-- Finding publishers with no games
SELECT publisher.publisherId, publisher.publisherName
FROM publisher LEFT JOIN title
	ON publisher.publisherId = title.publisherId
WHERE title.publisherId IS NULL;

-- Finding devs with no games
SELECT developer.developerId, developer.developerName
FROM developer LEFT JOIN hasdeveloper
	ON developer.developerId = hasdeveloper.developerId
WHERE hasDeveloper.titleId IS NULL;

SELECT * FROM publisher WHERE publisher.publisherName LIKE "%id Software%";

SELECT * FROM title WHERE name = "Doom";

SELECT * FROM publisher WHERE publisherId = 53;

SELECT COUNT(*) FROM TitleOnPlatform;

CREATE TABLE titlePublisherTest(
	publisherTitleId INT NOT NULL UNIQUE,
    title VARCHAR(255),
    publisher VARCHAR(255),
    PRIMARY KEY (publisherTitleId)
);

-- IN PROGRESS, Finding the number of many to many publihsers to titles
SELECT * FROM titlepublishertest;

SELECT * FROM titlepublishertest WHERE title = "Doom";

SELECT * FROM title WHERE publisherId = 8;

SELECT * FROM publisher WHERE publisherName = "Electronic Arts";
SELECT * FROM publisher WHERE publisherName = "Valve";

SELECT * FROM Developer WHERE developerName = "EA Games";
SELECT * FROM Developer WHERE developerName = "Electronic Arts";
SELECT * FROM Developer WHERE developerName = "Valve Software";

SELECT * FROM Title WHERE PublisherId = 56;

SELECT * FROM HasDeveloper WHERE developerId = 106;
SELECT * FROM HasDeveloper WHERE developerId = 23;
 
DELETE FROM developer WHERE developerId = 106;

UPDATE HasDeveloper
SET
developerId = 23
WHERE developerId = 106;

SELECT * FROM Title;

UPDATE Title
SET
releaseYear = 2009
WHERE id = 4175;

SELECT * FROM hasdeveloper;
