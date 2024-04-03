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