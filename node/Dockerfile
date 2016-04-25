FROM centos:7
MAINTAINER Feng <fengit@outlook.com>

# 安装 Node
RUN yum update -y && yum -y install git crontabs python-setuptools &&  \
	yum clean all && \
	git config --global user.name "fengit" && \
  	git config --global user.email "fengit@outlook.com"

# 安装 Nvm
RUN mkdir -p ~/git && \
	cd ~/git && \
	git clone https://github.com/creationix/nvm.git && \
	echo "source ~/git/nvm/nvm.sh" >> ~/.bashrc && \
	echo "export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist" >> ~/.bashrc && \
	source ~/.bashrc && nvm install v5.1.0 && nvm use v5.1.0 && \
	echo "nvm use v5.1.0" >> ~/.bashrc && \
	npm install hexo-cli -g

# 生成无密码 ssh key
RUN mkdir -p /root/.ssh && \
	echo "/root/.ssh/id_rsa" | ssh-keygen -t rsa -N "" && \
	cat /root/.ssh/id_rsa.pub
#Install supervisor
RUN easy_install supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/run/sshd && \
    mkdir -p /var/run/supervisord

#Add supervisord conf
ADD supervisord.conf /etc/supervisord.conf

# 共享目录 /data/blog /data/www
VOLUME ["/data/www", "/data/blog"]

# 自动检测更新、脚本
RUN touch /var/spool/cron/root && \
	echo  "* * * * * sleep 10; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 20; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 30; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 40; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 50; /root/hexo.sh"  >> /var/spool/cron/root


# 脚本
ADD hexo.sh /root/hexo.sh
ADD start.sh /start.sh
RUN chmod +x /root/hexo.sh && chmod +x /start.sh

#Start it
ENTRYPOINT ["/start.sh"]

#ENTRYPOINT ["/root/hexo.sh"]