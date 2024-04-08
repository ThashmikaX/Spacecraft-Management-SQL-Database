-- Tunning

-- Union operation quiry tuning.
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
SELECT payload_id FROM spacecraft
UNION ALL
SELECT payload_id FROM satellite;

-- Intersection operation quiry tuning.
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
SELECT payload_id FROM spacecraft
WHERE payload_id IN (
    SELECT payload_id FROM satellite
);

-- Set difference operation quiry tuning.
CREATE INDEX idx_spacecraft_payload_id ON spacecraft (payload_id);
CREATE INDEX idx_satellite_payload_id ON satellite (payload_id);
-- Revised query
SELECT s.payload_id
FROM spacecraft s
LEFT JOIN satellite t ON s.payload_id = t.payload_id
WHERE t.payload_id IS NULL;

 -- Inner join operation operation quiry tuning.
CREATE INDEX idx_launch_launchsite_id ON Launch (launchsite_id);
CREATE INDEX idx_launchsite_launchsite_id ON launchsite (launchsite_id);
SELECT l.*, ls.latitude, ls.longitude
FROM Launch l
INNER JOIN launchsite ls USING (launchsite_id);

 -- Left outer join operation tuning
CREATE INDEX idx_payload_payload_id ON payload (payload_id);
-- Revised query
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id;
EXPLAIN
SELECT launch_info.*, payload.owner
FROM launch_info
LEFT JOIN payload ON launch_info.launch_id = payload.payload_id;

-- Right outer join tuning
CREATE INDEX idx_payload_id ON payload (payload_id);
SELECT launch_info.*, payload.owner
FROM payload
RIGHT OUTER JOIN launch_info ON payload.payload_id = launch_info.launch_id;
