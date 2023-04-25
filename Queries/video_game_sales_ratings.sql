-- START

-- CREATING TITLE TABLE
CREATE TABLE title (
	id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(255),
    releaseYear YEAR(4),
    PRIMARY KEY (id)
);


-- Deletes all rows
-- DELETE FROM title WHERE id > 0;

-- ALTER TABLE title RENAME COLUMN title TO name;
SELECT * FROM title WHERE releaseYear IS NULL;

-- CREATING RATINGS TABLE
CREATE TABLE rating(
	ratingId INT UNSIGNED AUTO_INCREMENT,
    ratingType VARCHAR(255),
    PRIMARY KEY (ratingId)
);

INSERT INTO rating(ratingType)
VALUES
	("E"),
    ("E10+"),
    ("T"),
    ("M"),
    ("RP")
;
    
SELECT * FROM rating;

-- CREATING THE TABLE FOR HAS_RATING

CREATE TABLE HasRating(
	titleId INT UNSIGNED NOT NULL,
    ratingId INT UNSIGNED NOT NULL,
	FOREIGN KEY (titleId)
      REFERENCES title(id)
      ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (ratingId)
      REFERENCES rating(ratingId)
      ON UPDATE CASCADE ON DELETE RESTRICT,
	PRIMARY KEY (titleId, ratingId)
);

SELECT * FROM hasrating;

SELECT * FROM rating;

-- CHECK FOR RATING
SELECT title.name, rating.ratingType
FROM hasrating
LEFT OUTER JOIN rating
ON rating.ratingId = hasrating.ratingId
LEFT OUTER JOIN title
ON title.id = hasrating.titleId
;
    