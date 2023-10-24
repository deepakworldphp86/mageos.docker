FROM percona:8.0
COPY ./bin/bootstrap.sh /docker-entrypoint-initdb.d/bootstrap.sh
COPY ./bin/bootstrap.sh /usr/local/bin/bootstrap.sh
COPY ./conf/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
#RUN chmod +x /docker-entrypoint-initdb.d/bootstrap.sh#chmod: changing permissions of '/docker-entrypoint-initdb.d/bootstrap.sh': Operation not permitted
# RUN chown -R mysql:root  /usr/local/bin 
# RUN chown -R mysql:root  /docker-entrypoint-initdb.d/

# RUN schmod -R ug+rwX /usr/local/bin/bootstrap.sh
# RUN schmod -R ug+rwX /docker-entrypoint-initdb.d/bootstrap.sh


RUN  ["/bin/bash"] ["-c"] ["/usr/local/bin/bootstrap.sh"]
RUN  ["/bin/bash"] ["-c"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]
#ENTRYPOINT ["/usr/local/bin/bootstrap.sh"] #No idea
EXPOSE 3306