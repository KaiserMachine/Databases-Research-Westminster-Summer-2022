""" VIDEO GAME SALES AND RATINGS FINAL """
# Imports all the data from the two csv files (parks.csv and species.csv)

# Imports
import mariadb
import csv
import sys

# Parks.csv information to put into the db, stored in dicts and lists
parkId = 1
stateId = 1

parks = {}

states = {}

has_states = []

# Opening the file parks.csv (tiny)
with open('parks.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)

    # Read each row as dict
    for row in reader:
        # Parks
        parks[row['Park Name']] = [parkId, row['Acres'], row['Latitude'], row['Longitude']]

        # States
        # There can be multiple states so we split by the comma and strip
        for state in row['State'].split(','):
            state = state.strip()
            if state not in states:
                states[str(state)] = [stateId, None]
                stateId += 1
            # Has state
            has_states.append([parkId, states[str(state)][0]])

        parkId += 1

# Export lists (used because it is more convenient than dicts)
states_export = []
parks_export = []

# Put the information to import from the dicts into the lists in the right order
for keys, values in states.items():
    states_export.append([values[0], keys, values[1]])

for keys, values in parks.items():
    parks_export.append([values[0], keys, values[1], values[2], values[3]])

# Species.csv information
species_id = 1
common_name_id = 1

species = {}

common_names = {}

has_commom_names = []

has_species = []

# Opening the file species.csv (large)
with open('species.csv', newline='', encoding='utf8') as csvfile:
    reader = csv.DictReader(csvfile)

    #Read each row as dict
    for row in reader:
        # Getting species by scientific name
        if row['Scientific Name'] not in species:
            species[row['Scientific Name']] = [species_id, row['Family'], row['Order'], row['Category']]
            species_id += 1

        # Getting common names
        for common_name in row['Common Names'].split(','):
            common_name = common_name.strip()
            if common_name not in common_names:
                common_names[common_name] = common_name_id
                common_name_id += 1
            #Has common Names
            has_commom_names.append([species[row['Scientific Name']][0], common_names[common_name]])

        # Has species
        has_species.append([parks[row['Park Name']][0], species[row['Scientific Name']][0], row['Nativeness'], row['Abundance']])




# !!!IMPORTANT!!! REMOVE DUPLICATES HERE

# REMOVE DUPLUCATES FOR HAS SPECIES
# Copy has_species, then sort in numerical order, then remove the duplicate pairs via a bool system
has_species_no_dups = has_species
has_species_no_dups.sort(key=lambda row: (row[0], row[1]))

# Add the bools at the beginning
has_species_add = []
for i in range(len(has_species_no_dups)):
    has_species_add.append(True)

# Set to false where the previous one has the same index
for i in range(1, len(has_species_no_dups)):
    # Check if the previous one is the same as this one
    if has_species_no_dups[i-1][0] == has_species_no_dups[i][0] and has_species_no_dups[i-1][1] == has_species_no_dups[i][1]:
        has_species_add[i] = False

# Append to final if it is true
has_species_final = []

for i in range(len(has_species_no_dups)):
    if has_species_add[i] == True:
        has_species_final.append(has_species_no_dups[i])

# REMOVE DUPLUCATES FOR HAS Common Name (Explained Above)
has_common_names_no_dups = has_commom_names
has_common_names_no_dups.sort(key=lambda row: (row[0], row[1]))

# Add them all at the beginning
has_common_names_add = []
for i in range(len(has_common_names_no_dups)):
    has_common_names_add.append(True)

# Do not add ones where the previous one has the same index
for i in range(1, len(has_common_names_no_dups)):
    # Check if the previous one is the same as this one
    if has_common_names_no_dups[i-1][0] == has_common_names_no_dups[i][0] and has_common_names_no_dups[i-1][1] == has_common_names_no_dups[i][1]:
        has_common_names_add[i] = False

has_common_names_final = []

for i in range(len(has_common_names_no_dups)):
    if has_common_names_add[i] == True:
        has_common_names_final.append(has_common_names_no_dups[i])


# EXPORT SPECIES AND COMMON NAMES
# Using List format
species_export = []
common_names_export = []

for keys, values in species.items():
    species_export.append([values[0], keys, values[1], values[2], values[3]])

for keys, values in common_names.items():
    common_names_export.append([values, keys])

# Has Species setting Null values to None
has_species_nativeness = ['Native','Not Native','Unknown']
has_species_abundance = ['Abundant','Common','Occasional','Uncommon','Rare','Unknown']

# Set the value to None if it is not in the enum
for i in range(len(has_species)):
    if has_species[i][2] not in has_species_nativeness:
        has_species[i][2] = None
    if has_species[i][3] not in has_species_abundance:
        has_species[i][3] = None

# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="FreedomMan69!",
        host="127.0.0.1",
        port=3306,
        database="parks_species_v2"
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cur = conn.cursor()

count = 0

try:

    # Queries to run
    mySql_query_park = 'INSERT INTO Park VALUES(%s, %s, %s, %s, %s)'
    mySql_query_state = 'INSERT INTO State VALUES(%s, %s, %s)'
    mySql_query_species = 'INSERT INTO Species VALUES(%s, %s, %s, %s, %s)'
    mySql_query_common_name = 'INSERT INTO CommonName VALUES(%s, %s)'
    mySql_query_has_state = 'INSERT INTO HasState VALUES(%s, %s)'
    mySql_query_has_species = 'INSERT INTO HasSpecies VALUES(%s, %s, %s, %s)'
    mySql_query_has_common_name = 'INSERT INTO HasCommonName VALUES(%s, %s)'

    # Run each query and count the index
    for i in range(len(parks_export)):
        cur.execute(mySql_query_park, parks_export[i])
        count += 1

    print ('Parks Done!')

    for i in range(len(states_export)):
        cur.execute(mySql_query_state, states_export[i])
        count += 1

    print ('States Done!')

    for i in range(len(species_export)):
        cur.execute(mySql_query_species, species_export[i])
        count += 1

    print ('Species Done!')

    for i in range(len(common_names_export)):
        cur.execute(mySql_query_common_name, common_names_export[i])
        count += 1

    print ('Common Names Done!')

    for i in range(len(has_states)):
        cur.execute(mySql_query_has_state, has_states[i])
        count += 1

    print ('Has States Done!')

    for i in range(len(has_species_final)):
        cur.execute(mySql_query_has_species, has_species_final[i])
        count += 1

    print ('Has Species Done!')

    for i in range(len(has_common_names_final)):
        cur.execute(mySql_query_has_common_name, has_common_names_final[i])
        count += 1

    print ('Has Common Names Done!')

    conn.commit()
    print(count, " record(s) inserted successfully into [Table] table(s)")

except mariadb.Error as error:
    #print("Error Point: ", count, "Error Output: ", has_species[count])
    print("Failed to insert record into MySQL table {}".format(error))

finally:
    cur.close()
    conn.close()
    print("MySQL connection is closed")