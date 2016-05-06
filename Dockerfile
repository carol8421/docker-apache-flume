###########################################################################################
# This dockerfile is derived from loicmathieu/openjdk and will setup an Apache 2 httd
# webserver and Apache Flume with an agent configure to collect the apache access log file
# and send it to an Hadoop edge node (see loicmathieu/cloudera-cdh-edgenode).
#
# The namenode will expose it's 8020 port, to use it, you first need to start a datanode 
# (using loicmathieu/cloudera-hdfs-datanode) and make sure the netword stack is OK 
# so that the namenode and datanode can communicate together
#
# The container will use supervisor to start both the apache httpd and the flume agent
###########################################################################################
FROM loicmathieu/openjdk

MAINTAINER Loic Mathieu <loicmathieu@free.fr>

#install the Apache httpd webserver
RUN yum -y install httpd && rm -rf /var/cache/yum/*

#install Apache flume
WORKDIR /usr/lib/apache-flume
COPY http://www.apache.org/dyn/closer.lua/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz .
RUN tar -xvf apache-flume-1.6.0-bin.tar.gz

#setup supervisor
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#expose httpd port
EXPOSE 80

#start the supervisor
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
