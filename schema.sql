/**
* Source Code File (SRC_CD.txt)
*/
CREATE TABLE src_cd (
    src_cd varchar(2) NOT NULL,
    srccd_desc varchar(60) NOT NULL,
    PRIMARY KEY (src_cd)
);

COMMENT ON TABLE src_cd IS 'Contains codes indicating the type of data (analytical, calculated, assumed zero, and so on) in the Nutrient Data table. 
To improve the usability of the database and to provide values for the FNDDS, NDL staff imputed nutrient values for a number
of proximate components, total dietary fiber, total sugar, and vitamin and mineral values.';
COMMENT ON COLUMN src_cd.src_cd IS 'A 2-digit code indicating type of data.';
COMMENT ON COLUMN src_cd.srccd_desc IS 'Description of source code that identifies the type of nutrient data.';


/**
* Data Derivation Code Description File (DERIV_CD.txt)
*/
CREATE TABLE deriv_cd (
    deriv_cd varchar(4) NOT NULL,
    deriv_desc varchar(120) NOT NULL,
    PRIMARY KEY (deriv_cd)
);

COMMENT ON TABLE deriv_cd IS 'Provides information on how the nutrient values were determined. The table contains the
derivation codes and their descriptions.';
COMMENT ON COLUMN deriv_cd.deriv_cd IS 'Derivation Code.';
COMMENT ON COLUMN deriv_cd.deriv_desc IS 'Description of derivation code giving specific information on how the value was determined.';


/**
* Sources of Data File (DATA_SRC.txt)
*/
CREATE TABLE data_src (
    datasrc_id varchar(6) NOT NULL,
    authors varchar(255),
    title varchar(255) NOT NULL,
    year varchar(4),
    journal varchar(135),
    vol_city varchar(16),
    issue_state varchar(5),
    start_page varchar(5),
    end_page varchar(5),
    PRIMARY KEY (datasrc_id)
);

COMMENT ON TABLE data_src IS 'Provides a citation to the DataSrc_ID in the Sources of Data Link table.';
COMMENT ON COLUMN data_src.datasrc_id IS 'Unique ID identifying the reference/source.';
COMMENT ON COLUMN data_src.authors IS 'List of authors for a journal article or name of sponsoring organization for other documents.';
COMMENT ON COLUMN data_src.title IS 'Title of article or name of document, such as a report from a company or trade association.';
COMMENT ON COLUMN data_src.year IS 'Year article or document was published.';
COMMENT ON COLUMN data_src.journal IS 'Name of the journal in which the article was published.';
COMMENT ON COLUMN data_src.vol_city IS 'Volume number for journal articles, books, or reports; city where sponsoring organization is located.';
COMMENT ON COLUMN data_src.issue_state IS 'Issue number for journal article; State where the sponsoring organization is located.';
COMMENT ON COLUMN data_src.start_page IS 'Starting page number of article/document.';
COMMENT ON COLUMN data_src.end_page IS 'Ending page number of article/document.';


/**
* Footnote File (FOOTNOTE.txt)
*/
CREATE TABLE footnote (
    ndb_no varchar(5) NOT NULL,
    footnt_no varchar(4) NOT NULL,
    footnt_typ varchar(1) NOT NULL,
    nutr_no varchar(3),
    footnt_txt varchar(200) NOT NULL,
);

COMMENT ON TABLE footnote IS 'Contains additional information about the food item, household weight, and nutrient value.';
COMMENT ON COLUMN footnote.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';
COMMENT ON COLUMN footnote.footnt_no IS 'Sequence number. If a given footnote applies to
more than one nutrient number, the same footnote
number is used. As a result, this table cannot be
indexed and there is no primary key.';
COMMENT ON COLUMN footnote.footnt_typ IS 'Type of footnote:
D = footnote adding information to the food
description;
M = footnote adding information to measure
description;
N = footnote providing additional information on a
nutrient value. If the Footnt_typ = N, the Nutr_No will
also be filled in.';
COMMENT ON COLUMN footnote.nutr_no IS 'Unique 3-digit identifier code for a nutrient to which
footnote applies.';
COMMENT ON COLUMN footnote.footnt_txt IS 'Footnote text.';


/**
* LanguaL Factors Description File (LANGDESC.txt)
*/
CREATE TABLE langdesc (
    factor_code varchar(5) NOT NULL,
    description varchar(140) NOT NULL,
    PRIMARY KEY (factor_code)
);

COMMENT ON TABLE langdesc IS 'A support table to the LanguaL Factor table and contains the descriptions for only those
factors used in coding the selected food items codes in this release of SR.';
COMMENT ON COLUMN langdesc.factor_code IS 'The LanguaL factor from the Thesaurus. Only those
codes used to factor the foods contained in the
LanguaL Factor table are included in this table.';
COMMENT ON COLUMN langdesc.description IS 'The description of the LanguaL Factor Code from the
thesaurus.';

/**
* Food Group Description File (FD_GROUP.txt)
*/
CREATE TABLE fd_group(
    fdgrp_cd varchar(4) NOT NULL,
    fdgrp_desc varchar(60) NOT NULL,
    PRIMARY KEY (fdgrp_cd)
);

COMMENT ON TABLE fd_group IS 'A support file to the Food Description table and contains a list of food groups used in SR28
and their descriptions.';
COMMENT ON COLUMN fd_group.fdgrp_cd IS '4-digit code identifying a food group. Only the first 2
digits are currently assigned. In the future, the last 2
digits may be used. Codes may not be consecutive.';
COMMENT ON COLUMN fd_group.fdgrp_desc IS 'Name of food group.';


/**
* Food Description File (FOOD_DES.txt)
*/
CREATE TABLE food_des (
    ndb_no varchar(5) NOT NULL,
    fdgrp_cd varchar(4) NOT NULL REFERENCES fd_group (fdgrp_cd),
    long_desc varchar(200) NOT NULL,
    shrt_desc varchar(60) NOT NULL,
    comname varchar(100),
    manufacname varchar(65),
    survey varchar(1),
    ref_desc varchar(135),
    refuse numeric(2),
    sciname varchar(65),
    n_factor numeric(4, 2),
    pro_factor numeric(4, 2),
    fat_factor numeric(4, 2),
    cho_factor numeric(4, 2),
    PRIMARY KEY (ndb_no),
    UNIQUE (ndb_no, fdgrp_cd)
);

COMMENT ON TABLE food_des IS 'Contains long and
short descriptions and food group designators for all food items, along with common
names, manufacturer name, scientific name, percentage and description of refuse, and
factors used for calculating protein and kilocalories, if applicable. Items used in the
FNDDS are also identified by value of "Y" in the Survey field.';
COMMENT ON COLUMN food_des.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';
COMMENT ON COLUMN food_des.fdgrp_cd IS '4-digit code indicating food group to which a food
item belongs.';
COMMENT ON COLUMN food_des.long_desc IS '200-character description of food item.';
COMMENT ON COLUMN food_des.shrt_desc IS '60-character abbreviated description of food item.
Generated from the 200-character description using
abbreviations in Appendix A. If short description is
longer than 60 characters, additional abbreviations
are made.';
COMMENT ON COLUMN food_des.comname IS 'Other names commonly used to describe a food,
including local or regional names for various foods,
for example, "soda" or "pop" for "carbonated
beverages".';
COMMENT ON COLUMN food_des.manufacname IS 'Indicates the company that manufactured the
product, when appropriate.';
COMMENT ON COLUMN food_des.survey IS 'Indicates if the food item is used in the USDA Food
and Nutrient Database for Dietary Studies (FNDDS)
and thus has a complete nutrient profile for the 65
FNDDS nutrients.';
COMMENT ON COLUMN food_des.ref_desc IS 'Description of inedible parts of a food item (refuse),
such as seeds or bone.';
COMMENT ON COLUMN food_des.refuse IS 'Percentage of refuse.';
COMMENT ON COLUMN food_des.sciname IS 'Scientific name of the food item. Given for the least
processed form of the food (usually raw), if
applicable.';
COMMENT ON COLUMN food_des.n_factor IS 'Factor for converting nitrogen to protein.';
COMMENT ON COLUMN food_des.pro_factor IS 'Factor for calculating calories from protein.';
COMMENT ON COLUMN food_des.fat_factor IS 'Factor for calculating calories from fat.';
COMMENT ON COLUMN food_des.cho_factor IS 'Factor for calculating calories from carbohydrate.';

/**
* Nutrient Data File (NUT_DATA.txt)
*/
CREATE TABLE nut_data(
    ndb_no varchar(5) NOT NULL REFERENCES food_des (ndb_no),
    nutr_no varchar(3) NOT NULL REFERENCES nutr_def (nutr_no),
    nutr_val numeric(10, 3) NOT NULL,
    num_data_pts numeric(5, 0) NOT NULL,
    std_error numeric(8, 3),
    src_cd varchar(2) NOT NULL,
    deriv_cd varchar(4),
    ref_ndb_no varchar(5),
    add_nutr_mark varchar(1),
    num_studies numeric(2),
    min numeric(10, 3),
    max numeric(10, 3),
    df numeric(4),
    low_eb numeric(10, 3),
    up_eb numeric(10, 3),
    stat_cmt varchar(10),
    addmod_date varchar(10),
    cc varchar(1),
    PRIMARY KEY (ndb_no, nutr_no)

);

COMMENT ON TABLE nut_data IS 'Contains the nutrient
values and information about the values, including expanded statistical information.';
COMMENT ON COLUMN nut_data.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';
COMMENT ON COLUMN nut_data.nutr_no IS 'Unique 3-digit identifier code for a nutrient.';
COMMENT ON COLUMN nut_data.nutr_val IS 'Amount in 100 grams, edible portion.';
COMMENT ON COLUMN nut_data.num_data_pts IS 'Number of data points is the number of analyses
used to calculate the nutrient value. If the number of
data points is 0, the value was calculated or
imputed.';
COMMENT ON COLUMN nut_data.std_error IS 'Standard error of the mean. Null if cannot be
calculated. The standard error is also not given if the
number of data points is less than three.';
COMMENT ON COLUMN nut_data.src_cd IS 'Code indicating type of data.';
COMMENT ON COLUMN nut_data.deriv_cd IS 'Data Derivation Code giving specific information on
how the value is determined. This field is populated
only for items added or updated starting with SR14.
This field may not be populated if older records were
used in the calculation of the mean value.';
COMMENT ON COLUMN nut_data.ref_ndb_no IS 'NDB number of the item used to calculate a missing
value. Populated only for items added or updated
starting with SR14.';
COMMENT ON COLUMN nut_data.add_nutr_mark IS 'Indicates a vitamin or mineral added for fortification
or enrichment. This field is populated for ready-to-
eat breakfast cereals and many brand-name hot
cereals in food group 08.';
COMMENT ON COLUMN nut_data.num_studies IS 'Number of studies.';
COMMENT ON COLUMN nut_data.min IS 'Minimum value.';
COMMENT ON COLUMN nut_data.max IS 'Maximum value.';
COMMENT ON COLUMN nut_data.df IS 'Degrees of freedom.';
COMMENT ON COLUMN nut_data.low_eb IS 'Lower 95% error bound.';
COMMENT ON COLUMN nut_data.up_eb IS 'Upper 95% error bound.';
COMMENT ON COLUMN nut_data.stat_cmt IS 'Statistical comments. See definitions below.';
COMMENT ON COLUMN nut_data.addmod_date IS 'Indicates when a value was either added to the
database or last modified.';
COMMENT ON COLUMN nut_data.cc IS 'Confidence Code indicating data quality, based on
evaluation of sample plan, sample handling,
analytical method, analytical quality control, and
number of samples analyzed. Not included in this
release, but is planned for future releases.';