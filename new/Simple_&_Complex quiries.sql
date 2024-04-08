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

