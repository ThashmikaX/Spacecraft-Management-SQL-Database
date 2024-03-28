SELECT * FROM spaceship_management.launch;

ALTER TABLE launch
ADD FOREIGN KEY (launchsite_id) REFERENCES launchsite(launchsite_id)
on delete set default on update cascade,
add foreign key (payload_id) references payload(payload_id)
on delete set default on update cascade,
add foreign key (launchvehicle_id) references launchvehicle(launchvehicle_id)
on delete set default on update cascade;

alter table spacecraft
add foreign key (payload_id) references payload(payload_id)
on delete set default on update cascade;

alter table satelite
add foreign key (payload_id) references payload(payload_id)
on delete set default on update cascade;




