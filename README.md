Script for importing the USDA Nutrients Database into PostgreSQL.

What it does
------------
1. Downloads & unzips the USDA Nutrients Database in .txt format
2. Creates the PostgreSQL tables
3. Imports the data from the unzipped .txt files

Usage
-----
1. Create a PostgreSQL database, UTF-8 encoded.
2. Run `./import_usdand.sh postgresDatabase`

Misc
----
An Ansible powered Vagrant box is also included, it reflects the environment this was built and used in.

If you just want the PostgreSQL database without having to run the script, a pg_dump can be found in usda_sr28.sql
