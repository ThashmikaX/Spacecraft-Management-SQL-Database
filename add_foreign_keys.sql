SELECT * FROM spaceship_management.launch;

ALTER TABLE launch
ADD FOREIGN KEY (launchsite_id) REFERENCES launchsite(launchsite_id)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (payload_id) REFERENCES payload(payload_id)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (launchvehicle_id) REFERENCES launchvehicle(launchvehicle_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE spacecraft
ADD FOREIGN KEY (payload_id) REFERENCES payload(payload_id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE satelite
ADD FOREIGN KEY (payload_id) REFERENCES payload(payload_id)
ON DELETE CASCADE ON UPDATE CASCADE;




