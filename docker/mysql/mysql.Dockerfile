FROM mysql:8.0.30-debian as mysql
ARG MYSQL_ROOT_PASSWORD=root@123A
#COPY ./bin/bootstrap.sh /docker-entrypoint-initdb.d/bootstrap.sh
#COPY ./bin/bootstrap.sh /docker-entrypoint-initdb.d/bootstrap.sh
COPY ./bin/bootstrap.sh /usr/local/bin/bootstrap.sh

# COPY ./mysql-backup/wc_b2b_m2_09-08-2022.sql /home/
# COPY ./bin/backup.sh /usr/local/bin/backup.sh


#RUN chmod +x /docker-entrypoint-initdb.d/bootstrap.sh
RUN chmod +x /usr/local/bin/bootstrap.sh
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# RUN chmod +x /usr/local/bin/backup.sh



#RUN  ["/bin/bash"] ["-c"] ["/usr/local/bin/bootstrap.sh"]
#RUN  ["/bin/bash"] ["-c"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]

RUN  ["/bin/bash"] ["/usr/local/bin/bootstrap.sh"]
RUN  ["/bin/bash"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]
# RUN  ["/bin/bash"] ["/usr/local/bin/backup.sh"]

#ENTRYPOINT ["/usr/local/bin/bootstrap.sh"] #No idea
EXPOSE 3306