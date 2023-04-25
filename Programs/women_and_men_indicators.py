""" WOMEN AND MEN INDICATORS FINAL """
# Imports all the data from the CSV files for Women and Men Indicators

# Imports
import mariadb
import csv
import sys

countries_id = 1
countries = {}


# Opening the files to get the countries
with open('Marriages.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        if row['Country or area'] not in countries:
            countries[row['Country or area']] = [countries_id, None, None, None]
            countries_id += 1

with open ('Maternity leave benefits.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        if row['Country'] not in countries:
            countries[row['Country']] = [countries_id, None, None, None]
            countries_id += 1

with open ('Women legislators and managers.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        if row['Country or area'] not in countries:
            countries[row['Country or area']] = [countries_id, None, None, None]
            countries_id += 1

# Getting marriage data
marriage_id = 1
marriage_info = []

with open('Marriages.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        marriage_info.append([marriage_id, row['Year'], row['AdolescentWomenMarried'], row['AdolescentMenMarried'],
                              row['WomenMeanAge'], row['MenMeanAge']])
        countries[row['Country or area']] = [countries[row['Country or area']][0], marriage_id, None, None]
        marriage_id += 1

# Getting maternity leave benefits
maternity_id = 1
maternity_info = []

with open('Maternity leave benefits.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        maternity_info.append([maternity_id, row['Time Off'], row['Percentage of wages paid'], row['Provider of benefit']])
        countries[row['Country']] = [countries[row['Country']][0], countries[row['Country']][1],
                                             maternity_id, None]
        maternity_id += 1

# Getting women in leadership data
leadership_id = 1
leadership_info = []

with open('Women legislators and managers.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    for row in reader:
        leadership_info.append([leadership_id, row['Year'], row['Women Percent']])
        countries[row['Country or area']] = [countries[row['Country or area']][0], countries[row['Country or area']][1],
                                     countries[row['Country or area']][2], leadership_id]
        leadership_id += 1

# Set values of maternity and marriage info's to None instead of ''
for i in range(len(marriage_info)):
    for j in range(len(marriage_info[i])):
        if marriage_info[i][j] == '':
            marriage_info[i][j] = None

for i in range(len(maternity_info)):
    for j in range(len(maternity_info[i])):
        if maternity_info[i][j] == '':
            maternity_info[i][j] = None

# Set the type of leadership percent (id = 2) to int over string
for i in range(len(leadership_info)):
    leadership_info[i][2] = int(leadership_info[i][2])

# DEBUG PRINTS (Comment out later)
"""
print('Country Info\n')
for key, values in countries.items():
    print(key, values)
print('\nMarriage Info\n')
for i in range(len(marriage_info)):
    print(marriage_info[i])
print('\nMaternity Info\n')
for i in range(len(maternity_info)):
    print(maternity_info[i])
print('\nLeadership Info\n')
for i in range(len(leadership_info)):
    print(leadership_info[i])
"""

# Countries to export (convert from dict to list)
countries_export = []

for key, values in countries.items():
    countries_export.append([values[0], key, values[1], values[2], values[3]])

# MySQL Data
# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="FreedomMan69!",
        host="127.0.0.1",
        port=3306,
        database="women_men_indicators"
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cur = conn.cursor()

count = 0

try:
    # Queries to run
    mySql_query_leadership = 'INSERT INTO LeadershipInfo VALUES(%s, %s, %s)'
    mySql_query_marriage = 'INSERT INTO MarriageInfo VALUES(%s, %s, %s, %s, %s, %s)'
    mySql_query_maternity = 'INSERT INTO MaternityInfo VALUES(%s, %s, %s, %s)'
    mySql_query_country = 'INSERT INTO Country VALUES(%s, %s, %s, %s, %s)'

    # Run each query and count the index
    for i in range(len(marriage_info)):
        cur.execute(mySql_query_marriage, marriage_info[i])
        count += 1

    print ('Marriage Done!')

    for i in range(len(maternity_info)):
        cur.execute(mySql_query_maternity, maternity_info[i])
        count += 1

    print ('Maternity Done!')

    for i in range(len(leadership_info)):
        cur.execute(mySql_query_leadership, leadership_info[i])
        count += 1

    print ('Leadership Done!')

    for i in range(len(countries_export)):
        cur.execute(mySql_query_country, countries_export[i])
        count += 1

    print('Countries Done!')

    conn.commit()
    print(count, " record(s) inserted successfully into [Table] table(s)")

except mariadb.Error as error:
    #print("Error Point: ", count, "Error Output: ", has_species[count])
    print("Failed to insert record into MySQL table {}".format(error))

finally:
    cur.close()
    conn.close()
    print("MySQL connection is closed")

