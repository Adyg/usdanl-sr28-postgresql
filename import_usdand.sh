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
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_srccd FROM '/tmp/sr28/SRC_CD.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_derivcd FROM '/tmp/sr28/DERIV_CD.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_datasrc FROM '/tmp/sr28/DATA_SRC.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_footnote(ndb_no, footnt_no, footnt_typ, nutr_no, footnt_txt) FROM '/tmp/sr28/FOOTNOTE.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_langdesc FROM '/tmp/sr28/LANGDESC.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_fdgroup FROM '/tmp/sr28/FD_GROUP.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_fooddes(ndb_no, fdgrp_cd_id, long_desc, shrt_desc, comname, manufacname, survey, ref_desc, refuse, sciname, n_factor, pro_factor, fat_factor, cho_factor) FROM '/tmp/sr28/FOOD_DES.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_nutrdef FROM '/tmp/sr28/NUTR_DEF.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_nutdata(ndb_no_id, nutr_no_id, nutr_val, num_data_pts, std_error, src_cd, deriv_cd, ref_ndb_no, add_nutr_mark, num_studies, min, max, df, low_eb, up_eb, stat_cmt, addmod_date, cc) FROM '/tmp/sr28/NUT_DATA.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_weight(ndb_no_id, seq, amount, msre_desc, gm_wgt, num_data_pts, std_dev) FROM '/tmp/sr28/WEIGHT.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_langual(ndb_no_id, factor_code_id) FROM '/tmp/sr28/LANGUAL.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"
psql -d ${POSTGRES_DB} -c "COPY ${POSTGRES_DB}_datsrcln(ndb_no_id, nutr_no_id, datasrc_id_id) FROM '/tmp/sr28/DATSRCLN.txt' (FORMAT('csv'), DELIMITER('^'), QUOTE('~'))"

