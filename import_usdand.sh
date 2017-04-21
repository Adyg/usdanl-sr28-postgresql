#!/bin/bash

#db credentials
POSTGRES_DB=$1

#download the SR28 archive
wget https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR/SR28/dnload/sr28asc.zip -P /tmp/sr28
unzip /tmp/sr28/sr28asc.zip -d /tmp/sr28
recode cp1250.. /tmp/sr28/*.txt

#create the tables
psql -d ${POSTGRES_DB} -f schema.sql

#import data from the downloaded files
psql -d ${POSTGRES_DB} -c "COPY src_cd FROM '/tmp/sr28/SRC_CD.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY deriv_cd FROM '/tmp/sr28/DERIV_CD.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY data_src FROM '/tmp/sr28/DATA_SRC.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY footnote FROM '/tmp/sr28/FOOTNOTE.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY langdesc FROM '/tmp/sr28/LANGDESC.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY fd_group FROM '/tmp/sr28/FD_GROUP.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY food_des FROM '/tmp/sr28/FOOD_DES.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY nutr_def FROM '/tmp/sr28/NUTR_DEF.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY nut_data FROM '/tmp/sr28/NUT_DATA.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY weight FROM '/tmp/sr28/WEIGHT.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY langual FROM '/tmp/sr28/LANGUAL.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY datsrcln FROM '/tmp/sr28/DATSRCLN.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"

