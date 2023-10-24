#!/bin/bash
clear

if [ "$1" == "full" ] 
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


if [ "$1" == "compile" ] 
then

	echo "*********************** Setup compile - setup:di:compile *******************************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:di:compile

fi
if [ "$1" == "index" ] 
then

	echo "*********************** setup reindex - indexer:reindex ********************************"
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento indexer:reindex

fi
if [ "$1" == "content" ] 
then

	echo "*********************** setup static content deploy - setup:static-content:deploy -f  *******************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:static-content:deploy -f

fi
if [ "$1" == "upgrade_content" ] 
then

	echo "*********************** Upgrading setup - setup:upgrade ****************************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:upgrade
	echo "*********************** setup static content deploy - setup:static-content:deploy -f  *******************" 
	php -d memory_limit=-1 /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:static-content:deploy -f

fi
if [ "$1" == "permission" ] 
then

	echo "*********************** Giving Permission *******************" 
	chmod -R 777 /var/www/html/${MAGE_INSTALLATION_FOLDER}/
	echo "*********************** Ending Permission *******************" 

fi


 exit 1
