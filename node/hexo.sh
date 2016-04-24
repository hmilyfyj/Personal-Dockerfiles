#!/bin/sh
update_flag="/data/www/at.xuyu.club/application/cache/git_update.txt"
hexo_dir="/data/blog/hexo_blog"
post_dir="/data/blog/hexo_blog/source/_posts"
log_dir="/data/www/at.xuyu.club"

cur_time=`date "+%Y-%m-%d %H:%M:%S"`

if [ -f "$update_flag" ];then
    cd "$log_dir"
    echo "$cur_time£ºChanged." >> update_hexo_flag.txt 2>&1
    echo >> update_hexo_flag.txt
    rm "$update_flag"
    cd "$post_dir"
    git pull origin master
    cd "$hexo_dir"
    export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
    source ~/git/nvm/nvm.sh
    nvm use v5.1.0
    hexo d -g
    hexo b
fi