""" VIDEO GAME SALES AND RATINGS
Imports all the data from the csv file ('Video_Games_Sales_as_at_22_Dec_2016.csv')
"""

# Module Imports
import mariadb
import sys
import csv

# Video Game Sales csv information to put into the db, stored in dicts and lists
genreCount = 1
genres = {}

publisherCount = 1
publishers = {}

titleCount = 1
titles = {}

devCount = 1
devs = {}

platformCount = 1
platforms = {}

hasDeveloper = []

titleOnPlatform = []

# Read the CSV file
with open('Video_Games_Sales_as_at_22_Dec_2016.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    # limit and counter (limit causes a break when it goes on too long and counter counts the rows being read)
    limit = 20000
    counter = 0

    # Read each row
    for row in reader:
        # Add genres
        if row['Genre'] not in genres:
            genres[row['Genre']] = genreCount
            genreCount += 1

        # Add Publishers
        if row['Publisher'] not in publishers:
            publishers[row['Publisher']] = publisherCount
            publisherCount += 1

        # Add titles
        if row['Name'] not in titles:
            titles[row['Name']] = [titleCount, row['Year_of_Release'], row["Rating"], genres[row['Genre']]
                ,publishers[row["Publisher"]]]
            titleCount += 1

        # Add Devs
        for dev in (row["Developer"].split(",")):
            dev = dev.strip()
            if dev not in devs:
                devs[dev] = devCount
                devCount += 1
            # Add Has Developer
            hasDeveloper.append([titles[row['Name']][0], devs[dev]])

        # Add platforms
        if row['Platform'] not in platforms:
            platforms[row['Platform']] = platformCount
            platformCount += 1

        # Add title on platform
        titleOnPlatform.append([titles[row['Name']][0], platforms[row['Platform']], row['NA_Sales'], row['EU_Sales'],
                                row['JP_Sales'], row['Other_Sales'], row['Global_Sales'], row['Critic_Score'],
                                row['Critic_Count'], row['User_Score'], row['User_Count']])

        # Counter and break limit
        counter += 1

        if counter >= limit:
            break

# Debug prints
"""
print(genres)
count = 0
for item in publishers.items():
    if count > 5:
        break
    print(item)
    count += 1

count = 0
for item in titles.items():
    if count > 5:
        break
    print(item)
    count += 1
count = 0
for item in devs.items():
    if count > 5:
        break
    print(item)
    count += 1


for key, values in platforms.items():
    print(key, values)

print(titleOnPlatform[:5])
"""

# Convert dicts to lists for exporting
genres_export = []
for key, values in genres.items():
    genres_export.append([values, key])

publishers_export = []
for key, values in publishers.items():
    publishers_export.append([values, key])

titles_export = []
for key, values in titles.items():
    titles_export.append([values[0], key, values[1], values[2], values[3], values[4]])

devs_export = []
for key, values in devs.items():
    devs_export.append([values, key])

platforms_export = []
for key, values in platforms.items():
    platforms_export.append([values, key])

# DATA CLEANING
title_ratings = ['EC','E','E10+','T','M','RP']

# Cleaning Titles
for i in range(len(titles_export)):
    # Setting N/A years to None
    if titles_export[i][2] == 'N/A':
        titles_export[i][2] = None
    # Setting title ratings to None if not in approved list
    if titles_export[i][3] not in title_ratings:
        titles_export[i][3] = None

# Remove Has Developer Duplicates
hasDeveloper_no_dups = hasDeveloper
hasDeveloper_no_dups.sort(key=lambda row: (row[0], row[1]))

# Add them all at the beginning
hasDeveloper_add = []
for i in range(len(hasDeveloper_no_dups)):
    hasDeveloper_add.append(True)

# Do not add ones where the previous one has the same index
for i in range(1, len(hasDeveloper_no_dups)):
    # Check if the previous one is the same as this one
    if hasDeveloper_no_dups[i-1][0] == hasDeveloper_no_dups[i][0] and hasDeveloper_no_dups[i-1][1] == hasDeveloper_no_dups[i][1]:
        hasDeveloper_add[i] = False

hasDeveloper_final = []

for i in range(len(hasDeveloper_no_dups)):
    if hasDeveloper_add[i] == True:
        hasDeveloper_final.append(hasDeveloper_no_dups[i])

# titleOnPlatform set '' values to None
for i in range(len(titleOnPlatform)):
    for j in range(len(titleOnPlatform[i])):
        if titleOnPlatform[i][j] == '' or titleOnPlatform[i][j] == 'tbd':
            titleOnPlatform[i][j] = None

# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="FreedomMan69!",
        host="127.0.0.1",
        port=3306,
        database="video_game_sales_ratings_v2"
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cur = conn.cursor()

count = 0

# Run the queries
try:
    # Queries to run
    mySql_query_genre = 'INSERT INTO Genre VALUES(%s, %s)'
    mySql_query_publishers = 'INSERT INTO Publisher VALUES(%s, %s)'
    mySql_query_title = 'INSERT INTO Title VALUES(%s, %s, %s, %s, %s, %s)'
    mySql_query_dev = 'INSERT INTO Developer VALUES(%s, %s)'
    mySql_query_has_dev = 'INSERT INTO HasDeveloper VALUES(%s, %s)'
    mySql_query_platform = 'INSERT INTO Platform VALUES(%s, %s)'
    mySql_query_title_on_platform = 'INSERT INTO TitleOnPlatform VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'

    # Run the query and count the index
    print('Starting Genres...')
    for i in range(len(genres_export)):
        cur.execute(mySql_query_genre, genres_export[i])
        count += 1

    print('Starting Publishers...')
    for i in range(len(publishers_export)):
        cur.execute(mySql_query_publishers, publishers_export[i])
        count += 1

    print('Starting Titles...')
    for i in range(len(titles_export)):
        cur.execute(mySql_query_title, titles_export[i])
        count += 1

    print('Starting Devs...')
    for i in range(len(devs_export)):
        cur.execute(mySql_query_dev, devs_export[i])
        count += 1

    print('Starting Has Devs...')
    for i in range(len(hasDeveloper_final)):
        cur.execute(mySql_query_has_dev, hasDeveloper_final[i])
        count += 1

    print('Starting Platforms...')
    for i in range(len(platforms_export)):
        cur.execute(mySql_query_platform, platforms_export[i])
        count += 1

    print('Starting Title On Platform...')
    for i in range(len(titleOnPlatform)):
        #print(titleOnPlatform[i])
        cur.execute(mySql_query_title_on_platform, titleOnPlatform[i])
        count += 1

    conn.commit()
    print(count, " record(s) inserted successfully into [Table] table(s)")


except mariadb.Error as error:
    #print("Error Point: ", count, "Error Output: ", has_species[count])
    print("Failed to insert record into MySQL table {}".format(error))

finally:
    cur.close()
    conn.close()
    print("MySQL connection is closed")
