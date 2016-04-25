#!/usr/bin/expect
set timeout 60
spawn mkdir -p /data/blog/hexo && cd /data/blog/hexo && git init & git remote add origin git@git.coding.net:AIW/hexo_blog.git  &  git pull origin master
expect "yes/no"
send "yes\r"
expect eof
interact