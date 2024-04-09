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

