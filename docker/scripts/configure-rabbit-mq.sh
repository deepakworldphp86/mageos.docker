#!/bin/bash
source '.env'
amqp_args=()
  if [[ "${MAGENTO_AMQP_HOST}" ]]; then
    amqp_args+=("--amqp-host=$MAGENTO_AMQP_HOST")
  fi
  if [[ "${MAGENTO_AMQP_PORT}" ]]; then
    amqp_args+=("--amqp-port=$MAGENTO_AMQP_PORT")
  fi
  if [[ "${MAGENTO_AMQP_USER}" ]]; then
    amqp_args+=("--amqp-user=$MAGENTO_AMQP_USER")
  fi
  if [[ "${MAGENTO_AMQP_PASSWORD}" ]]; then
    amqp_args+=("--amqp-password=$MAGENTO_AMQP_PASSWORD")
  fi
  if [[ "${MAGENTO_AMQP_VIRTUALHOST}" ]]; then
    amqp_args+=("--amqp-virtualhost=$MAGENTO_AMQP_VIRTUALHOST")
  fi
  if [[ "${MAGENTO_AMQP_SSL}" ]]; then
    amqp_args+=("--amqp-ssl=$MAGENTO_AMQP_SSL")
  fi
echo "Configuring rabbit mq  queue: /var/www/html/${MAGE_INSTALLATION_FOLDER}/bin/magento setup:config:set  ${amqp_args[@]}"
php -d memory_limit=-1 /var/www/html/"${MAGE_INSTALLATION_FOLDER}"/bin/magento setup:config:set "${amqp_args[@]}"
