#!/bin/bash

mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "CREATE USER 'mariadb'@'%' IDENTIFIED BY 'root@123A#';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "GRANT ALL PRIVILEGES ON *.* TO 'mariadb'@'%';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "FLUSH PRIVILEGES;"
