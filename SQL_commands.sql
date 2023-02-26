SELECT temp_table.region, temp_table.average_price
FROM
(SELECT region, ROUND(AVG(pricem),2) AS average_price
FROM album.clean_combined_toronto_property_data
GROUP BY region
ORDER BY average_price DESC) temp_table;

SELECT COUNT(*) FROM album.clean_combined_toronto_property_data
WHERE
pricem > 0.8;

SELECT COUNT(temp_table.Index) FROM
(SELECT *,
CASE
WHEN pricem > 0.8 THEN 'Expensive'
ELSE 'Affordable'
END AS 'Index'
FROM album.clean_combined_toronto_property_data) temp_table
WHERE
temp_table.Index = 'Expensive';



SELECT COUNT(*) FROM album.clean_combined_toronto_property_data
WHERE region <> 'Ajax, ON'

DROP TABLE IF EXISTS album.friends;
CREATE TABLE album.friends(
ID INTEGER PRIMARY KEY,
FName TEXT,
LName TEXT,
Age INTEGER,
SALARY INTEGER
);
INSERT INTO album.friends
VALUES 
(1, 'Nishan', 'Gill', 32, 2700),
(2, 'Pawan', 'Gill', 29, 2500),
(3, 'Harmeet', 'Singh', 25, 3500),
(4, 'Billa', 'Singh', 45, 4500),
(5, 'Jaggu', 'Don', 35, 8500);
SELECT * FROM album.friends;

DROP TABLE IF EXISTS album.heights;
CREATE TABLE album.heights(
ID INTEGER PRIMARY KEY,
Height INTEGER
);
INSERT INTO album.heights
VALUES 
(1, 45),
(3, 54),
(4, 12),
(2, 87),
(5, 34);
SELECT * FROM album.height;


SELECT friends.FName, heights.Height FROM
album.friends LEFT JOIN album.heights
ON
friends.ID = heights.ID;



SELECT * FROM album.friends
UNION
SELECT * FROM album.friends;

SELECT CONCAT(FName, ' ', LName) AS FullName FROM album.friends;


SELECT *, 
AVG(pricem) OVER (PARTITION BY region) AS count
FROM album.clean_combined_toronto_property_data;


SELECT AVG(pricem) 
FROM album.clean_combined_toronto_property_data
WHERE
region = 'Ajax, ON';



SELECT MAX(temp_table.average_price)
FROM
(SELECT region, ROUND(AVG(pricem),2) AS average_price
FROM album.clean_combined_toronto_property_data
GROUP BY region
ORDER BY average_price DESC) temp_table;


WITH CTE_table AS  
(SELECT region, pricem
FROM album.clean_combined_toronto_property_data
)
SELECT * FROM CTE_table;

WITH temp_table AS
(SELECT region, AVG(pricem) AS avg_price
FROM album.clean_combined_toronto_property_data
GROUP BY region)
SELECT * FROM temp_table
WHERE
avg_price = (SELECT MAX(avg_price) FROM temp_table);

WITH temp_table AS
(SELECT region, pricem,
row_number() OVER(PARTITION BY region ORDER BY price DESC) AS price_rank 
FROM album.clean_combined_toronto_property_data)
SELECT * FROM temp_table
WHERE price_rank = 1;

WITH temp_table AS
(SELECT region, pricem,
row_number() OVER(PARTITION BY region ORDER BY pricem DESC) AS price_rank
FROM album.clean_combined_toronto_property_data)
SELECT * FROM temp_table
WHERE price_rank = 8;

SELECT * FROM album.clean_combined_toronto_property_data
WHERE
region = 'Brampton, ON'
ORDER BY pricem DESC
LIMIT 1
OFFSET 7;


DROP TABLE IF EXISTS album.test_a;
DROP TABLE IF EXISTS album.test_b;
create table album.test_a(id INTEGER);

create table album.test_b(id INTEGER);

insert into album.test_a(id) values
(11),
(22),
(33),
(44),
(55);

insert into album.test_b(id) values
(11),
(33),
(55);

SELECT * FROM album.test_a;
SELECT * FROM album.test_b;

SELECT * FROM album.test_a
WHERE id NOT IN 
(SELECT id FROM album.test_b);

SELECT mod(10,2);



DROP TABLE IF EXISTS album.data;
CREATE TABLE album.data(
id INTEGER
);
INSERT INTO album.data
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(123),
(3425),
(24354);
SELECT * FROM album.data;

WITH temp_data AS
(SELECT *,
row_number() OVER() AS selector
FROM album.data)
SELECT id FROM temp_data
WHERE selector = (SELECT COUNT(*) FROM temp_data);


SELECT * FROM album.data
LIMIT 1;


SELECT region, address, pricem, COUNT(address) AS entries 
FROM album.clean_combined_toronto_property_data
GROUP BY address, region, pricem, bedrooms, bathrooms
HAVING entries > 1;

SELECT * FROM album.clean_combined_toronto_property_data
WHERE pricem IS NULL;


DROP TABLE IF EXISTS album.df;
CREATE TABLE album.df(
FName TEXT,
date_time DATE
);
SELECT * FROM album.df;
INSERT INTO album.df
VALUES 
('Nishan', '2023-12-30 13:09:34'),
('Pawan', '2023-12-29 14:11:54' ),
('Jaggu', '2023-12-28 15:29:57'),
('Jaggu', '2023-12-27 16:34:31');
SELECT * FROM album.df;

