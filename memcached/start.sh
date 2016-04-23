#!/bin/sh

memcached -d -m 1024 -u root -p 11211 -P /tmp/memcached.pid