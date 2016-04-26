#!/usr/bin/expect -f
set timeout 60
spawn ssh -T git@git.coding.net
expect "yes/no"
send "yes\n"
spawn ssh -T git@github.com
expect "yes/no"
send "yes\n"
expect eof