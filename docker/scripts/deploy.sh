#!/bin/bash
clear

if [ ! $1 ]
then
	echo "*********************** Upgrading setup - setup:upgrade ****************************" 
	 php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:upgrade
	echo "*********************** Setup compile - setup:di:compile *******************************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:di:compile
	echo "*********************** setup reindex - indexer:reindex ********************************"
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento indexer:reindex
	echo "*********************** setup static content deploy - setup:static-content:deploy -f  *******************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:static-content:deploy -f
	echo "*********************** Permission ***********************************************"
fi



if [ $1 == "compile" ]
then

	echo "*********************** Setup compile - setup:di:compile *******************************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:di:compile

fi


 #chmod -R 777 /var/www/html/${MAGE_INSTALLATION_FOLDER}/
