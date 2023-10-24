FROM mariadb:10.4.13

COPY ./bin/bootstrap.sh /docker-entrypoint-initdb.d/bootstrap.sh
COPY ./bin/bootstrap.sh /usr/local/bin/bootstrap.sh
COPY ./conf/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

RUN chmod +x /docker-entrypoint-initdb.d/bootstrap.sh
RUN chmod +x /usr/local/bin/bootstrap.sh

#RUN  ["/bin/bash"] ["-c"] ["/usr/local/bin/bootstrap.sh"]
#RUN  ["/bin/bash"] ["-c"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]
RUN  ["/bin/bash"] ["/usr/local/bin/bootstrap.sh"]
RUN  ["/bin/bash"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]
#ENTRYPOINT ["/usr/local/bin/bootstrap.sh"] #No idea
EXPOSE 3306