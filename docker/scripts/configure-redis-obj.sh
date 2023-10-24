#!/bin/bash
source '.env'
redis_obj_args=()
if [[ "${MAGENTO_REDIS_OBJ_HOST}" ]]; then
  redis_obj_args+=("--cache-backend-redis-server=$MAGENTO_REDIS_OBJ_HOST")
fi
if [[ "${MAGENTO_REDIS_OBJ_PORT}" ]]; then
  redis_obj_args+=("--cache-backend-redis-port=$MAGENTO_REDIS_OBJ_PORT")
fi
if [[ "${MAGENTO_REDIS_OBJ_DATABASE}" ]]; then
  redis_obj_args+=("--cache-backend-redis-db=$MAGENTO_REDIS_OBJ_DATABASE")
fi
if [[ "${MAGENTO_REDIS_OBJ_PASSWORD}" ]]; then
  redis_obj_args+=("--cache-backend-redis-password=$MAGENTO_REDIS_OBJ_PASSWORD")
fi
echo "Configuring Redis object cache: /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:config:set --cache-backend=redis ${redis_obj_args[@]}"
php -d memory_limit=-1 /var/www/html/"${MAGE_INSTALLATION_FOLDER}"/bin/magento setup:config:set --cache-backend=redis "${redis_obj_args[@]}"
