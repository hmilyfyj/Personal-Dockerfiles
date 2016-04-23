FROM daocloud.io/library/centos:7

RUN yum install memcached -y

EXPOSE 11211


ENTRYPOINT ["/start.sh"]
#CMD ['/usr/local/bin/memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid', '']

