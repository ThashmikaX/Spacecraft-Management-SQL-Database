CREATE DATABASE spaceship_management;
CREATE TABLE launch (
    launch_id VARCHAR(10) NOT NULL PRIMARY KEY,
    date DATE,
    time TIME
);
CREATE TABLE payload (
    payload_id VARCHAR(10) NOT NULL PRIMARY KEY,
    owner VARCHAR(100)
);
CREATE TABLE spacecraft (
    spacecraft_id VARCHAR(20) NOT NULL PRIMARY KEY,
    crew_capacity VARCHAR(10)
);
CREATE TABLE satelite (
    satelite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    orbit VARCHAR(50)
);
CREATE TABLE launchvehicle (
    launchvehicle_id VARCHAR(10) NOT NULL PRIMARY KEY,
    manufacture VARCHAR(50),
    payload_capacity INT,
    county_of_origin VARCHAR(20),
    capsule VARCHAR(20),
    rocket VARCHAR(20)
);
CREATE TABLE launchsite (
    launchsite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    atitude FLOAT,
    longitude FLOAT
);
CREATE TABLE launchProvider (
    launchProvider_id VARCHAR(10) NOT NULL PRIMARY KEY,
    county_of_origin VARCHAR(50),
    website VARCHAR(100)
);
	
