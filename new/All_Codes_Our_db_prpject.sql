-- Schema creation with 2NF considerations
CREATE DATABASE IF NOT EXISTS space_launch;

USE space_launch;

CREATE TABLE IF NOT EXISTS launchsite (
    launchsite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT
);

CREATE TABLE IF NOT EXISTS payload (
    payload_id VARCHAR(10) NOT NULL PRIMARY KEY,
    owner VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS launchvehicle (
    launchvehicle_id VARCHAR(10) NOT NULL PRIMARY KEY,
    manufacture VARCHAR(50),
    payload_capacity INT,
    country_of_origin VARCHAR(20),
    capsule VARCHAR(20),
    rocket VARCHAR(20),
    carry_launchvehicle_id VARCHAR(10),
    CONSTRAINT fk_launchvehicle_carry FOREIGN KEY (carry_launchvehicle_id) REFERENCES launchvehicle(launchvehicle_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS launch (
    launch_id VARCHAR(10) NOT NULL PRIMARY KEY,
    launchsite_id VARCHAR(10) NOT NULL,
    payload_id VARCHAR(10) NOT NULL,
    launchvehicle_id VARCHAR(10) NOT NULL,
    date DATE,
    time TIME,
    CONSTRAINT fk_launch_launchsite FOREIGN KEY (launchsite_id) REFERENCES launchsite(launchsite_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_launch_payload FOREIGN KEY (payload_id) REFERENCES payload(payload_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_launch_launchvehicle FOREIGN KEY (launchvehicle_id) REFERENCES launchvehicle(launchvehicle_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS spacecraft (
    spacecraft_id VARCHAR(20) NOT NULL PRIMARY KEY,
    payload_id VARCHAR(10) NOT NULL,
    crew_capacity VARCHAR(10),
    CONSTRAINT fk_spacecraft_payload FOREIGN KEY (payload_id) REFERENCES payload(payload_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS satellite (
    satellite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    payload_id VARCHAR(10) NOT NULL,
    orbit VARCHAR(50),
    CONSTRAINT fk_satellite_payload FOREIGN KEY (payload_id) REFERENCES payload(payload_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS launchprovider (
    launchprovider_id VARCHAR(10) NOT NULL PRIMARY KEY,
    country_of_origin VARCHAR(50),
    website VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS occur (
    spacecraft_id VARCHAR(20) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_occurrence PRIMARY KEY (spacecraft_id, launch_id),
    FOREIGN KEY (spacecraft_id) REFERENCES spacecraft(spacecraft_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (launch_id) REFERENCES launch(launch_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS utilize (
    launchvehicle_id VARCHAR(10) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_utilization PRIMARY KEY (launchvehicle_id, launch_id),
    FOREIGN KEY (launchvehicle_id) REFERENCES launchvehicle(launchvehicle_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (launch_id) REFERENCES launch(launch_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS images (
    image_id VARCHAR(10) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT pk_image PRIMARY KEY (image_id, launch_id),
    FOREIGN KEY (launch_id) REFERENCES launch(launch_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Example data population
-- Populate payload table
INSERT INTO payload (payload_id, owner) VALUES 
('P001', 'NASA'),
('P002', 'SpaceX'),
('P003', 'ESA'),
('P004', 'Roscosmos'),
('P005', 'ISRO'),
('P006', 'Blue Origin');

-- Populate launchsite table
INSERT INTO launchsite (launchsite_id, latitude , longitude) VALUES 
('LS001', 28.5721, -80.648),
('LS002', 34.6328, -120.6107),
('LS003', 5.239, -52.768),
('LS004', 28.7575, -80.5326),
('LS005', 34.742, 135.332),
('LS006', 5.216, -52.768);

-- Populate launchvehicle table
INSERT INTO launchvehicle (launchvehicle_id, manufacture, payload_capacity, country_of_origin, capsule, rocket, carry_launchvehicle_id) VALUES 
('LV001', 'SpaceX', 22000, 'USA', 'Dragon', 'Falcon 9', NULL),
('LV002', 'NASA', 26900, 'USA', 'Orion', 'Space Launch System', NULL),
('LV003', 'ESA', 21000, 'Europe', 'Columbus', 'Ariane 5', NULL),
('LV004', 'Roscosmos', 22000, 'Russia', 'Soyuz', 'Soyuz', NULL),
('LV005', 'ISRO', 18000, 'India', 'Crew Module', 'GSLV Mk III', NULL),
('LV006', 'Blue Origin', 15800, 'USA', 'New Shepard', 'New Shepard', 'LV001');


-- Populate launch table
INSERT INTO launch (launch_id, launchsite_id, payload_id, launchvehicle_id, date, time) VALUES 
('L001', 'LS001', 'P001', 'LV001', '2023-01-10', '08:00:00'),
('L002', 'LS002', 'P002', 'LV002', '2023-02-15', '13:30:00'),
('L003', 'LS003', 'P003', 'LV003', '2023-03-20', '10:45:00'),
('L004', 'LS004', 'P004', 'LV004', '2023-04-25', '09:15:00'),
('L005', 'LS005', 'P005', 'LV005', '2023-05-30', '12:00:00'),
('L006', 'LS006', 'P006', 'LV006', '2023-06-05', '11:00:00');

-- Populate spacecraft table
INSERT INTO spacecraft (spacecraft_id, payload_id, crew_capacity) VALUES 
('S001', 'P001', '7'),
('S002', 'P002', '4'),
('S003', 'P003', '6'),
('S004', 'P004', '3'),
('S005', 'P005', '5'),
('S006', 'P006', '2');

-- Populate images table
INSERT INTO images (image_id, launch_id) VALUES 
('IMG001', 'L001'),
('IMG002', 'L002'),
('IMG003', 'L003'),
('IMG004', 'L004'),
('IMG005', 'L005'),
('IMG006', 'L006');

-- Populate launchprovider table
INSERT INTO launchprovider (launchprovider_id, country_of_origin, website) VALUES 
('LP001', 'USA', 'www.spacex.com'),
('LP002', 'USA', 'www.nasa.gov'),
('LP003', 'Russia', 'www.roscosmos.ru'),
('LP004', 'Europe', 'www.esa.int'),
('LP005', 'India', 'www.isro.gov.in'),
('LP006', 'China', 'www.cnsa.gov.cn');

-- Populate occur table
INSERT INTO occur (spacecraft_id, launch_id) VALUES 
('S001', 'L001'),
('S002', 'L002'),
('S003', 'L003'),
('S004', 'L004'),
('S005', 'L005'),
('S006', 'L006');

-- Populate satellite table
INSERT INTO satellite (satellite_id, payload_id, orbit) VALUES 
('SAT001', 'P001', 'Low Earth Orbit'),
('SAT002', 'P002', 'Geostationary Orbit'),
('SAT003', 'P003', 'Polar Orbit'),
('SAT004', 'P004', 'Medium Earth Orbit'),
('SAT005', 'P005', 'Sun-Synchronous Orbit'),
('SAT006', 'P006', 'Molniya Orbit');

-- Populate utilize table
INSERT INTO utilize (launchvehicle_id, launch_id) VALUES 
('LV001', 'L001'),
('LV002', 'L002'),
('LV003', 'L003'),
('LV004', 'L004'),
('LV005', 'L005'),
('LV006', 'L006');

-- Update and delete operations for launch table
UPDATE launch SET time = '09:00:00' WHERE launch_id = 'L001';
UPDATE launch SET date = '2023-01-11' WHERE launch_id = 'L002';

-- Update and delete operations for payload table
UPDATE payload SET owner = 'SpaceX Corporation' WHERE payload_id = 'P003';
UPDATE payload SET owner = 'ISRO' WHERE payload_id = 'P004';

-- Update and delete operations for spacecraft table
UPDATE spacecraft SET crew_capacity = '6' WHERE spacecraft_id = 'S001';
UPDATE spacecraft SET crew_capacity = '5' WHERE spacecraft_id = 'S002';

-- Update and delete operations for satellite table
UPDATE satellite SET orbit = 'Geostationary' WHERE satellite_id = 'SAT001';
UPDATE satellite SET orbit = 'Polar' WHERE satellite_id = 'SAT002';

-- Update and delete operations for launchvehicle table
UPDATE launchvehicle SET payload_capacity = 25000 WHERE launchvehicle_id = 'LV001';
UPDATE launchvehicle SET manufacture = 'NASA JPL' WHERE launchvehicle_id = 'LV002';

-- Update and delete operations for launchsite table
UPDATE launchsite SET latitude = 30.0 WHERE launchsite_id = 'LS001';
UPDATE launchsite SET longitude = -80.0 WHERE launchsite_id = 'LS002';

-- Update and delete operations for launchprovider table
UPDATE launchprovider SET website = 'www.nasa.gov' WHERE launchprovider_id = 'LP001';
UPDATE launchprovider SET country_of_origin = 'USA' WHERE launchprovider_id = 'LP002';

-- Update and delete operations for occur table
UPDATE occur SET launch_id = 'L002' WHERE spacecraft_id = 'S001';
UPDATE occur SET launch_id = 'L003' WHERE spacecraft_id = 'S002';

-- Update and delete operations for utilize table
UPDATE utilize SET launch_id = 'L003' WHERE launchvehicle_id = 'LV001';
UPDATE utilize SET launch_id = 'L004' WHERE launchvehicle_id = 'LV002';

-- Update and delete operations for images table
UPDATE images SET launch_id = 'L004' WHERE image_id = 'IMG001';
UPDATE images SET launch_id = 'L005' WHERE image_id = 'IMG002';

DELETE FROM launch WHERE launch_id = 'L006';
DELETE FROM payload WHERE payload_id = 'P006';
DELETE FROM spacecraft WHERE spacecraft_id = 'S004';
DELETE FROM satellite WHERE satellite_id = 'SAT003';
DELETE FROM launchvehicle WHERE launchvehicle_id = 'LV006';
DELETE FROM launchsite WHERE launchsite_id = 'LS006';
DELETE FROM launchprovider WHERE launchprovider_id = 'LP003';
DELETE FROM occur WHERE spacecraft_id = 'S003';
DELETE FROM utilize WHERE launchvehicle_id = 'LV003';
DELETE FROM images WHERE image_id = 'IMG003';

-- Simple Queries:
-- 1. Select operation: Retrieve all data from the launch table.
SELECT * FROM launch;

-- 2. Project operation: Retrieve launch IDs and their corresponding payload IDs from the launch table.
SELECT launch_id, payload_id FROM launch;

-- 3. Cartesian product operation: Retrieve a Cartesian product of launch and payload tables.
SELECT * FROM launch, payload;

-- 4. Creating a user view: Create a view to show launch information including the launch site latitude and longitude.
CREATE VIEW launch_info AS
SELECT l.launch_id, l.date, l.time, ls.latitude, ls.longitude
FROM launch l
JOIN launchsite ls ON l.launchsite_id = ls.launchsite_id;

-- 5. Renaming operation: Rename the 'owner' column in the payload table to 'payload_owner'.
SELECT payload_id, owner AS payload_owner FROM payload;

-- 6. Aggregation function: Calculate the average payload capacity of launch vehicles.
SELECT AVG(payload_capacity) AS average_payload_capacity FROM launchvehicle;

-- 7. LIKE keyword: Retrieve payload IDs starting with 'P00'.
SELECT * FROM payload WHERE payload_id LIKE 'P00%';

-- Complex Queries:
-- 1. Union operation: Retrieve all distinct payload IDs from spacecraft and satellite tables.
SELECT payload_id FROM spacecraft
UNION
SELECT payload_id FROM satellite;

-- 2. Intersection operation: Retrieve payload IDs that are present in both the spacecraft and satellite tables.
SELECT DISTINCT s1.payload_id 
FROM spacecraft s1
INNER JOIN satellite s2 ON s1.payload_id = s2.payload_id;

-- 3. Set difference operation: Retrieve payload IDs that are in the spacecraft table but not in the satellite table.
SELECT sc.payload_id
FROM spacecraft sc
LEFT JOIN satellite s ON sc.payload_id = s.payload_id
WHERE s.payload_id IS NULL;

-- 4. Division operation: Retrieve launch vehicle IDs that have launched all payloads.
SELECT launchvehicle_id
FROM Launchvehicle lv
WHERE NOT EXISTS (
SELECT payload_id
FROM payload p
WHERE NOT EXISTS (
SELECT *
FROM utilize u
JOIN launch l ON u.launch_id = l.launch_id
WHERE u. launchvehicle_id = lv. launchvehicle_id)
);

-- 5. Inner join operation using user view: Retrieve launch details along with the launch site latitude and longitude.
SELECT l .* , ls. latitude, ls.longitude
FROM Launch l
INNER JOIN launchsite ls ON l. launchsite_id = ls. launchsite_id;

-- 6. Natural join operation using user view: Retrieve launch details along with the launch site latitude and longitude.
SELECT * FROM launch_info NATURAL JOIN payload;

-- 7. Left outer join operation using user view: Retrieve all launch details and their corresponding payload owners.
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT OUTER JOIN payload ON launch_info.launch_id = payload.payload_id;

-- 8. Right outer join operation using user view: Retrieve all payload owners and their corresponding launch details.
SELECT launch_info.*, payload.owner
FROM payload
RIGHT OUTER JOIN launch_info ON payload.payload_id = launch_info.launch_id;

-- 9. Full outer join operation using user view: Retrieve all launch details along with their corresponding payload owners.
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id
UNION
SELECT launch_info.*, payload.owner
FROM launch_info
RIGHT JOIN payload ON launch_info.launch_id = payload.payload_id
WHERE launch_info.launch_id IS NULL;


-- 10. Outer union relational algebraic operation using user view: Retrieve all launch details and their corresponding payload owners.
SELECT launch_info .* , payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id
UNION
SELECT launch_info .* , payload.owner
FROM payload
LEFT JOIN launch_info ON payload.payload_id = launch_info.launch_id
WHERE launch_info.launch_id IS NULL;

-- 11. Nested query with inner join: Retrieve payload IDs along with their owners for launches before 2023-05-01.
SELECT payload_id, owner
FROM payload
WHERE payload_id IN (
   SELECT l.payload_id
   FROM launch l
   INNER JOIN launch_info li ON l.launch_id = li.launch_id
   WHERE li.date < '2023-05-01'
);

-- 12. Nested query with set difference: Retrieve payload IDs that have not been launched yet.
SELECT payload_id
FROM payload
WHERE payload_id NOT IN (
   SELECT launch_id FROM utilize
);

-- 13. Nested query with aggregation function: Retrieve the maximum payload capacity among the launches.
SELECT MAX(payload_capacity) AS max_payload_capacity
FROM launchvehicle
WHERE launchvehicle_id IN (
   SELECT launchvehicle_id FROM utilize
);

-- Tunning

-- 1.Union operation quiry tuning.
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
-- tuned query,
SELECT payload_id FROM spacecraft
UNION ALL
SELECT payload_id FROM satellite;
-- explain tuned query
EXPLAIN SELECT payload_id FROM spacecraft
UNION ALL
SELECT payload_id FROM satellite;

-- 2.Intersection operation quiry tuning.
SELECT DISTINCT s1.payload_id 
FROM spacecraft s1
INNER JOIN satellite s2 USING (payload_id);
-- explain tuned query
EXPLAIN SELECT DISTINCT s1.payload_id 
FROM spacecraft s1
INNER JOIN satellite s2 USING (payload_id);

-- 3.Set difference operation quiry tuning.
-- Tuned query
SELECT s.payload_id
FROM spacecraft s
LEFT JOIN satellite t USING(payload_id)
WHERE t.payload_id IS NULL;
-- explain tuned query
EXPLAIN SELECT s.payload_id
FROM spacecraft s
LEFT JOIN satellite t USING(payload_id)
WHERE t.payload_id IS NULL;

-- 4.Division operation quiry tuning.
SELECT lv.launchvehicle_id
FROM Launchvehicle lv
LEFT JOIN (
    SELECT DISTINCT u.launchvehicle_id
    FROM utilize u
    JOIN launch l ON u.launch_id = l.launch_id
) AS used_lv ON lv.launchvehicle_id = used_lv.launchvehicle_id
WHERE used_lv.launchvehicle_id IS NULL;
-- explain tuned query
EXPLAIN SELECT lv.launchvehicle_id
FROM Launchvehicle lv
LEFT JOIN (
    SELECT DISTINCT u.launchvehicle_id
    FROM utilize u
    JOIN launch l ON u.launch_id = l.launch_id
) AS used_lv ON lv.launchvehicle_id = used_lv.launchvehicle_id
WHERE used_lv.launchvehicle_id IS NULL;

 -- 5.Inner join operation operation quiry tuning.
CREATE INDEX idx_launch_launchsite_id ON Launch (launchsite_id);
CREATE INDEX idx_launchsite_launchsite_id ON launchsite (launchsite_id);
SELECT l.*, ls.latitude, ls.longitude
FROM Launch l
INNER JOIN launchsite ls USING (launchsite_id);
-- explain tuned query
EXPLAIN SELECT l.*, ls.latitude, ls.longitude
FROM Launch l
INNER JOIN launchsite ls USING (launchsite_id);

-- 6. Natural join operation tuning
CREATE INDEX idx_launch_id ON launch(launch_id); 
CREATE INDEX idx_payload_id ON payload(payload_id);
-- tuned uery
SELECT * FROM launch_info NATURAL JOIN payload;
explain SELECT * FROM launch_info NATURAL JOIN payload;

 -- 7.Left outer join operation tuning
-- tuned query
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id;
EXPLAIN
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id;

-- 8.Right outer join tuning
-- tuned query
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON payload.payload_id = launch_info.launch_id;
EXPLAIN SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON payload.payload_id = launch_info.launch_id;

-- 9.Full outer join
-- tuned query
SELECT launch_info.*, payload.owner
FROM launch_info
INNER JOIN payload ON launch_info.launch_id = payload.payload_id
UNION
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id
WHERE payload.payload_id IS NULL;
EXPLAIN SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id
UNION
SELECT launch_info.*, payload.owner
FROM launch_info
RIGHT JOIN payload ON launch_info.launch_id = payload.payload_id
WHERE launch_info.launch_id IS NULL;

-- 12. Nested query with set difference operation tuning
CREATE INDEX idx_utilize_launch_id ON utilize(launch_id);
-- tuned query
SELECT p.payload_id
FROM payload p
LEFT JOIN utilize u ON p.payload_id = u.launch_id
WHERE u.launch_id IS NULL;
EXPLAIN SELECT p.payload_id
FROM payload p
LEFT JOIN utilize u ON p.payload_id = u.launch_id
WHERE u.launch_id IS NULL;

