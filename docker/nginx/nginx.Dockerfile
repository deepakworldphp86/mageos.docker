FROM nginx:latest

COPY ./conf/site.conf /etc/nginx/conf.d/
COPY ./conf/magento.conf /etc/nginx/conf.d/
RUN usermod -u 1000 www-data

CMD ["nginx"]
EXPOSE 80
