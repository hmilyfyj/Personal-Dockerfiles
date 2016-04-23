FROM daocloud.io/library/centos:7

RUN yum install memcached -y

EXPOSE 11211

# Port to expose (default: 11211)
EXPOSE 11211
 
# Set the user to run Memcached daemon
USER daemon
 
# Set the entrypoint to memcached binary
ENTRYPOINT memcached

# Default Memcached run command arguments
#CMD ["-m", "128"]

#ENTRYPOINT start.sh

#CMD ['/usr/local/bin/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid', '']

