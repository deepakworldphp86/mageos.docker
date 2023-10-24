#!/bin/bash

mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "CREATE USER 'mage'@'%' IDENTIFIED BY 'mage@123A#';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "GRANT ALL PRIVILEGES ON *.* TO 'mage'@'%';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute "FLUSH PRIVILEGES;"




