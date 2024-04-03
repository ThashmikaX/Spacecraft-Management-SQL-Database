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