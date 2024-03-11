import mysql.connector
import configparser

config = configparser.ConfigParser()
config.read("settings.ini") 

db_config = config["config"]

with open("./sqlscripts/maindata.sql", "r") as file:
    sql_commands = file.read()

sql_statements = sql_commands.split(";")

mydb = mysql.connector.connect(
    user=db_config["user"],
    password=db_config["password"],
    host=db_config["host"],
    database=db_config["database"],
)
cursor = mydb.cursor()

for statement in sql_statements:
    if statement.strip(): 
        try:
            cursor.execute(statement)
        except mysql.connector.Error as err:
            print(f"Failed to execute statement: {statement}")
            print(err)
mydb.commit()
mydb.close() 

print("Script execution complete.") 
