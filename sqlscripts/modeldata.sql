USE gtfs_trimet;

CREATE VIEW model_input_data IF NOT EXISTS AS
SELECT 
    r.route_id,
    t.trip_id,
    st.stop_id,
    st.stop_sequence,
    st.arrival_time,  
    st.departure_time, 
    s.stop_lat,
    s.stop_lon
FROM routes r
JOIN trips t ON r.route_id = t.route_id
JOIN stop_times st ON t.trip_id = st.trip_id
JOIN stops s ON st.stop_id = s.stop_id
ORDER BY r.route_id, t.trip_id, st.stop_sequence; 
