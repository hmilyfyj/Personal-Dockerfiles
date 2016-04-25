#!/usr/bin/expect -f
set timeout 60
spawn git pull origin master
expect "yes/no"
send "yes\n"
expect eof