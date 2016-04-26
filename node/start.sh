#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: Skiychan
# Email:  dev@skiy.net
# Version:
# Created Time: 2015/12/13
#########################################################################

Hexo_backup_url='git@git.coding.net:AIW/hexo_blog.git'
Hexo_note_url='git@github.com:hmilyfyj/Note.git'
Personal='git@git.coding.net:AIW/personal.git'


#下载博客
echo "请确认已将公钥加入仓库。"

cat /root/.ssh/id_rsa.pub

expect -f /root/expect_git.sh


#mkdir -p /data/blog/hexo && cd /data/blog/hexo && git init & git remote add origin $Hexo_backup_url  &  git pull origin master
mkdir -p /data/blog/hexo && cd /data/blog/hexo && git init && git remote add origin $Hexo_backup_url  && git pull origin master


#cd /data/blog/hexo_blog/source/_posts && git init && git remote add origin $Hexo_note_url  && yes yes | git pull origin master
cd /data/blog/hexo/source/_posts && git init && git remote add origin $Hexo_note_url && git pull origin master

# npm install
cd /data/blog/hexo && npm install && hexo d -g

#
mkdir -p /data/www/personal && cd /data/www/personal && git init && git remote add origin $Personal  && git pull origin master && chmod +rw /data/www/personal/application/cache

/usr/bin/supervisord -n -c /etc/supervisord.conf
