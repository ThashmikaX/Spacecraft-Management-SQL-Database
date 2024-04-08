-- Tunning

-- Union operation quiry tuning.
EXPLAIN SELECT payload_id FROM spacecraft
UNION
SELECT payload_id FROM satellite;
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
EXPLAIN SELECT payload_id FROM spacecraft
UNION
SELECT payload_id FROM satellite;

-- Inner Join operation quiry tuning.
EXPLAIN SELECT payload_id FROM spacecraft
INTERSECT
SELECT payload_id FROM satellite;
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
EXPLAIN SELECT s.payload_id 
FROM spacecraft s
INNER JOIN satellite t ON s.payload_id = t.payload_id;




