#This file is not in use.  Vpn is required to access the data via API. This file pulls data from API into local 
import requests
import mysql.connector
import zipfile
import io
import csv
import configparser

config = configparser.ConfigParser()
config.read("settings.ini")
db_config = config["config"]


def fetch_and_load_gtfs_data(config):
    gtfs_url = "http://developer.trimet.org/schedule/gtfs.zip"
    response = requests.get(gtfs_url, {'api_key_parameter_name': 'D86CA92D9152352C782AE1834'})
    response.raise_for_status()

    mydb = mysql.connector.connect(
        user=db_config["user"],
        password=db_config["password"],
        host=db_config["host"],
        database=db_config["database"],
    )

    cursor = mydb.cursor()

    with zipfile.ZipFile(io.BytesIO(response.content)) as zip_file:
        for filename, table_name in [
            ("agency.txt", "Agency"),
            ("trips.txt", "Trips"),
            ("stop_times.txt", "Stop_Times"),
            ("stops.txt", "Stops"),
            ("routes.txt", "Routes"),
            ("calendar.txt", "Calendar"),
            ("calendar_dates.txt", "Calendar_Dates"),
            ("shapes.txt", "Shapes"),
            ("fare_attributes.txt", "Fare_Attributes"),
            ("fare_rules.txt", "Fare_Rules"),
            ("frequencies.txt", "Frequencies"),
            ("transfers.txt", "Transfers"),
            ("feed_info.txt", "Feed_Info"),
        ]:
            if filename in zip_file.namelist():
                table_name = filename.replace(".txt", "")

                with zip_file.open(filename) as file:
                    reader = csv.DictReader(io.TextIOWrapper(file, encoding="utf-8"))

                    for row in reader:
                        columns = ", ".join(row.keys())
                        placeholders = ", ".join(["%s"] * len(row))
                        sql = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"

                        try:
                            cursor.execute(sql, tuple(row.values()))
                        except mysql.connector.Error as err:
                            print(f"Error inserting data: {err}")
                            mydb.rollback()

    mydb.commit()

    cursor.close()
    mydb.close()


fetch_and_load_gtfs_data(config)
