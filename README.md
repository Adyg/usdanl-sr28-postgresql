Script for importing the USDA Nutrients Database into PostgreSQL.

What it does
------------
1. Downloads & unzips the USDA Nutrients Database in .txt format
2. Creates the PostgreSQL tables
3. Imports the data from the unzipped .txt files

Usage
-----
1. Create a PostgreSQL database.
2. Run `./import_usdand.sh postgresUser postgresPassword postgresDatabase`