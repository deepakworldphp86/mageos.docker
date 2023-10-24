#!/bin/sh
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "CREATE DATABASE wc_b2b_m2_21_09_2021 ;"
mysql -uroot -hmysql8  -p$MYSQL_ROOT_PASSWORD wc_b2b_m2_21_09_2021 < wc_b2b_m2_21_09_2021.sql;

