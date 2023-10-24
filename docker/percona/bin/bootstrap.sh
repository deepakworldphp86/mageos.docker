#!/bin/bash

mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "CREATE USER 'percona'@'%' IDENTIFIED BY 'root@123A#';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "GRANT ALL PRIVILEGES ON *.* TO 'percona'@'%';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "FLUSH PRIVILEGES;"
