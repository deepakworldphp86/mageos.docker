#!/bin/bash
source '.env'

  if [ -z "$(ls -A /var/www/html/${MAGE_INSTALLATION_FOLDER})" ]; then    
   /var/www/configure-magento-with-composer.sh
  elif [ ! -z "$(ls -A /var/www/html/${MAGE_INSTALLATION_FOLDER})"  ]; then
   /var/www/configure-magento.sh
  fi
   
  if [[ "${MAGENTO_REDIS_OBJ_SERVER}" ]]; then
    /var/www/configure-redis-obj.sh
  fi
 
  if [[ "${MAGENTO_REDIS_FPC_SERVER}" ]]; then
    /var/www/configure-redis-fpc.sh
  fi
  
  if [[ "${MAGENTO_REDIS_SES_SERVER}" ]]; then
    /var/www/configure-redis-ses.sh
  fi