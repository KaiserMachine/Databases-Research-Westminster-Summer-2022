-- VIDEO GAME SALES

SELECT * FROM sales;

select count(distinct Sales.Genre) as distinctVals FROM Sales;

SELECT * FROM sales WHERE Name LIKE "%Call of Duty%";

SELECT
     Name, COUNT(Name)
	 -- month, COUNT(month),
     -- year, COUNT(year)
FROM 
     sales
GROUP BY
     Name
HAVING 
	COUNT(Name) > 1;
    
SELECT * FROM Sales WHERE Name = "FIFA 14";

-- Player (test)
CREATE TABLE player2(id INT AUTO_INCREMENT, player_name VARCHAR(255), team_abbreviation VARCHAR(3), age SMALLINT(2),
primary KEY (id)
);

SELECT * FROM player2;

DROP TABLE player2;





