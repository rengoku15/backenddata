USE gtfs_trimet;

CREATE TABLE IF NOT EXISTS Agency (
    agency_id VARCHAR(255) PRIMARY KEY,
    agency_name VARCHAR(255),
    agency_url VARCHAR(255),
    agency_timezone VARCHAR(255),
    agency_lang VARCHAR(10),
    agency_phone VARCHAR(255), 
    agency_fare_url VARCHAR(255), 
    agency_email VARCHAR(255), 
    bikes_policy_url VARCHAR(255) 
);


CREATE TABLE IF NOT EXISTS Stops (
    stop_id VARCHAR(255) PRIMARY KEY,
    stop_code VARCHAR(255),
    stop_name VARCHAR(255),
    tts_stop_name VARCHAR(255),  
    stop_desc VARCHAR(255),
    stop_lat DECIMAL(9,6),
    stop_lon DECIMAL(9,6),
    zone_id VARCHAR(255),
    stop_url VARCHAR(255),
    location_type INT,
    parent_station VARCHAR(255) NULL, 
    wheelchair_boarding TINYINT, 
    platform_code VARCHAR(255) NULL, 
    direction VARCHAR(255), 
    position VARCHAR(255) 
);


CREATE TABLE IF NOT EXISTS Routes (
    route_id VARCHAR(255) PRIMARY KEY, 
    agency_id VARCHAR(255), 
    route_short_name VARCHAR(255),
    route_long_name VARCHAR(255),
    route_type INT,
    route_url VARCHAR(255),
    route_color VARCHAR(6),  
    route_text_color VARCHAR(6),
    route_sort_order INT, 
    network_id VARCHAR(255) 
);


CREATE TABLE IF NOT EXISTS Trips (
    trip_id INT,
    route_id VARCHAR(255), 
    service_id INT,
    trip_headsign VARCHAR(255),
    trip_short_name VARCHAR(255), 
    direction_id TINYINT,  
    block_id VARCHAR(255),
    shape_id VARCHAR(255),
    trip_type VARCHAR(255), 
    wheelchair_accessible TINYINT,  
    bikes_allowed TINYINT  
); 

CREATE TABLE IF NOT EXISTS Stop_Times (
    trip_id INT, 
    arrival_time TIME NOT NULL,
    departure_time TIME NOT NULL,
    stop_id INT, 
    stop_sequence INT NOT NULL,
    stop_headsign VARCHAR(255), 
    pickup_type TINYINT,
    drop_off_type TINYINT,
    shape_dist_traveled DECIMAL(10, 2), 
    timepoint TINYINT  
); 


CREATE TABLE IF NOT EXISTS Route_Directions (
    route_id INT, 
    direction_id VARCHAR(255), 
    direction_name VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS Fare_Rules (
    fare_id VARCHAR(255) NULL, 
    origin_id VARCHAR(255) NULL, 
    route_id VARCHAR(255) NULL, 
    contains_id VARCHAR(255) NULL
);

CREATE TABLE IF NOT EXISTS Calendar_Dates (
    service_id VARCHAR(255),
    `date` DATE NOT NULL,
    exception_type TINYINT NOT NULL
);

CREATE TABLE IF NOT EXISTS Fare_Attributes (
    fare_id VARCHAR(255),
    agency_id VARCHAR(255), 
    price DECIMAL(10,2) NOT NULL,  
    currency_type VARCHAR(255) NOT NULL,
    payment_method VARCHAR(255),
    transfers VARCHAR(255) NULL, 
    transfer_duration VARCHAR(255) NULL
);

CREATE TABLE IF NOT EXISTS Shapes (
    shape_id VARCHAR(255),
    shape_pt_lat DECIMAL(9,6) NOT NULL,
    shape_pt_lon DECIMAL(9,6) NOT NULL,
    shape_pt_sequence INT NOT NULL,
    shape_dist_traveled DECIMAL(10,2) 
); 

CREATE TABLE IF NOT EXISTS Transfers (
    from_stop_id VARCHAR(255) NOT NULL, 
    to_stop_id VARCHAR(255) NOT NULL, 
    transfer_type TINYINT NOT NULL,
    PRIMARY KEY (from_stop_id, to_stop_id)  
);