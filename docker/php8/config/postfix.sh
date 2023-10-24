#!/bin/sh

debconf-set-selections <<< "postfix postfix/mailname string smtp.mailtrap.io"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install --assume-yes postfix