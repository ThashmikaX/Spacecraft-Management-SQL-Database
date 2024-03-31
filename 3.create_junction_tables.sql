CREATE TABLE occur (
    spacecraft_id VARCHAR(20) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT PK_launch_spacecraft PRIMARY KEY (spacecraft_id , launch_id),
    FOREIGN KEY (spacecraft_id)
        REFERENCES spacecraft (spacecraft_id),
    FOREIGN KEY (launch_id)
        REFERENCES launch (launch_id)
);

CREATE TABLE utilize (
    launchvehicle_id VARCHAR(10) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT PK_launch_launchvehicle PRIMARY KEY (launchvehicle_id , launch_id),
    FOREIGN KEY (launchvehicle_id)
        REFERENCES launchvehicle (launchvehicle_id),
    FOREIGN KEY (launch_id)
        REFERENCES launch (launch_id)
);

CREATE TABLE images (
    images VARCHAR(10) NOT NULL,
    launch_id VARCHAR(10) NOT NULL,
    CONSTRAINT PK_launch_images PRIMARY KEY (images , launch_id),
    FOREIGN KEY (launch_id)
        REFERENCES launch (launch_id)
);