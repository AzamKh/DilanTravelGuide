{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 Helvetica-Bold;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww12920\viewh9060\viewkind0
\deftab720
\pard\pardeftab720\ri0\partightenfactor0

\f0\fs24 \cf0 DROP TABLE IF EXISTS new_readers CASCADE;\
DROP TABLE IF EXISTS return_readers CASCADE;\
DROP TABLE IF EXISTS subscribers CASCADE;\
DROP TABLE IF EXISTS buyers CASCADE;\
\
CREATE TABLE new_readers (\
my_date TIMESTAMP,\
event_type TEXT,\
country TEXT,\
user_id BIGINT,\
source TEXT,\
topic TEXT);\
\
CREATE TABLE return_readers (\
my_date TIMESTAMP,\
event_type TEXT,\
country TEXT,\
user_id BIGINT,\
topic TEXT);\
\
CREATE TABLE subscribers (\
my_date TIMESTAMP,\
event_type TEXT,\
user_id BIGINT);\
\
CREATE TABLE buyers (\
my_date TIMESTAMP,\
event_type TEXT,\
user_id BIGINT,\
price INTEGER);\
\
\pard\pardeftab720\ri0\partightenfactor0

\f1\b \cf0 \
commit
\f0\b0 ; --commit created tables in Postgres database \
\pard\pardeftab720\ri0\partightenfactor0

\f1\b \cf0 \ul \ulc0 \

\f0\b0 \'97SQL Data LOAD (from csv files to DB tables)\
\pard\pardeftab720\ri0\partightenfactor0
\cf0 \ulnone \
COPY new_readers FROM '/home/azamkh/DilanTravel/new_readers.csv' DELIMITER ';';\
\
COPY return_readers FROM '/home/azamkh/DilanTravel/repeat_readers.csv' DELIMITER ';';\
\
COPY subscribers FROM '/home/azamkh/DilanTravel/all_subscribers.csv' DELIMITER ';';\
\
COPY buyers FROM '/home/azamkh/DilanTravel/all_buyers.csv' DELIMITER ';';\
\
}