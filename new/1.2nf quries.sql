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
    county_of_origin VARCHAR(20),
    capsule VARCHAR(20),
    rocket VARCHAR(20)
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

