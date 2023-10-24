FROM mysql:8.0.30-debian as mysql8


# Install latest updates
# RUN apt-get update
# RUN apt-get upgrade -y

# Install mysql client and server
#RUN apt-get -y install mysql-client mysql-server curl

# Enable remote access (default is localhost only, we change this
# otherwise our database would not be reachable from outside the container)
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# # Install database
# #ADD ./database.sql /var/db/database.sql

# # Set Standard settings
# ENV user admin
# ENV password admin@123A
# # ENV url file:/var/db/database.sql
# # ENV right READ
# COPY ./mysql-backup/wc_b2b_m2_21_09_2021.sql /home/
# COPY ./mysql-init.sql /home/

# RUN mkdir -p /scripts

# # # Install starting script
# COPY ./bin/backup.sh /scripts
# COPY ./bin/bootstrap.sh /scripts
# COPY ./bin/start_database.sh /scripts

# WORKDIR /scripts

# RUN chmod +x start_database.sh
# RUN chmod +x bootstrap.sh
# RUN chmod +x backup.sh

# RUN ./start_database.sh
# RUN ./backup.sh
# RUN ./bootstrap.sh



#RUN  ["/bin/bash"] ["/usr/local/bin/backup.sh"]


# ADD ./bin/start_database.sh /usr/local/bin/start_database.sh
# RUN chmod +x /usr/local/bin/start_database.sh
# RUN  ["/bin/bash"] ["/usr/local/bin/start_database.sh"]

# COPY ./bin/bootstrap.sh /usr/local/bin/bootstrap.sh
# RUN chmod +x /usr/local/bin/bootstrap.sh
# RUN  ["/bin/bash"] ["-c"] ["/usr/local/bin/bootstrap.sh"]

#RUN chmod +x /usr/local/bin/backup.sh
#COPY ./conf/my.cnf /etc/mysql/conf.d/
#RUN chmod +x /etc/mysql/conf.d/my.cnf
#RUN  ["/bin/bash"] ["-c"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]
#CMD ["/usr/local/bin/start_database.sh"]
#RUN  ["/bin/bash"] ["/usr/local/bin/bootstrap.sh"]
#RUN  ["/bin/bash"] ["/usr/local/bin/backup.sh"]
#RUN  ["/bin/bash"] ["/docker-entrypoint-initdb.d/bootstrap.sh"]

#ENTRYPOINT ["/usr/local/bin/bootstrap.sh"] #No idea
EXPOSE 3306
