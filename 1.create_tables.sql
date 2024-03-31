CREATE DATABASE if NOT EXISTS spaceship_management;

Use spaceship_management;

CREATE TABLE if NOT EXISTS launch (
    launch_id VARCHAR(10) NOT NULL PRIMARY KEY,
    launchsite_id varchar(10) not null default "0",
    payload_id varchar(10) not null default "0",
    launchvehicle_id varchar(10) not null default "0",
    date DATE,
    time TIME
);
CREATE TABLE if NOT EXISTS payload (
    payload_id VARCHAR(10) NOT NULL PRIMARY KEY,
    owner VARCHAR(100)
);
CREATE TABLE if NOT EXISTS spacecraft (
    spacecraft_id VARCHAR(20) NOT NULL PRIMARY KEY,
    payload_id varchar(10) not null default "0",
    crew_capacity VARCHAR(10)
);
CREATE TABLE if NOT EXISTS satelite (
    satelite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    payload_id varchar(10) not null default "0",
    orbit VARCHAR(50)
);
CREATE TABLE if NOT EXISTS launchvehicle (
    launchvehicle_id VARCHAR(10) NOT NULL PRIMARY KEY,
    manufacture VARCHAR(50),
    payload_capacity INT,
    county_of_origin VARCHAR(20),
    capsule VARCHAR(20),
    rocket VARCHAR(20)
);
CREATE TABLE if NOT EXISTS launchsite (
    launchsite_id VARCHAR(10) NOT NULL PRIMARY KEY,
    atitude FLOAT,
    longitude FLOAT
);
CREATE TABLE if NOT EXISTS launchProvider (
    launchProvider_id VARCHAR(10) NOT NULL PRIMARY KEY,
    county_of_origin VARCHAR(50),
    website VARCHAR(100)
);



