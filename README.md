# docker-apache-flume
Dockerfile for Apache httpd 2 with a flume agent.

The port 80 of httpd is exposed.

Apache flume is configured via /flume_httpd.conf file and will tail the httpd access log and send it to an external flume agent edgenode:9000, it's purpose is to be a test container for the Hadoop Cloudera containers that I maintain, check https://hub.docker.com/r/loicmathieu/cloudera-cdh-edgenode for more info on it.

**To use it**
First, setup an Hadoop cluster following https://hub.docker.com/r/loicmathieu/cloudera-cdh-edgenode, be sure that all container are in the same docker network.

Then: 
```
docker pull loicmathieu/apache-httpd-flume
docker run -d --net hadoop --net-alias flume -p 80:80 loicmathieu/apache-httpd-flume
firefox localhost
```

If firefow is installed and the port 80 of the container is mapped to the port 80 of the host, doing so will open the httpd homepage and write a ligne to the access log that will be read by flume and send to the edge node on it's 9000 port (the edge node will then write it to HDFS).
