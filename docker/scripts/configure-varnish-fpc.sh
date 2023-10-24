#!/bin/bash
source '.env'
php -d memory_limit=-1 /var/www/html/"${MAGE_INSTALLATION_FOLDER}"/bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2
