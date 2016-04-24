FROM centos:7

# 安装 Node
RUN yum -y install git &&  \
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
RUN echo "id_rsa" | ssh-keygen -t rsa -N "" && cat /root/.ssh/id_rsa.pub

# 共享目录 /data/blog /data/www
VOLUME ["/data/www", "/data/blog"]

# 自动检测更新、脚本
RUN echo  "* * * * * sleep 10; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 20; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 30; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 40; /root/hexo.sh"  >> /var/spool/cron/root && \
	echo  "* * * * * sleep 50; /root/hexo.sh"  >> /var/spool/cron/root


# 脚本
Add hexo.sh ~/hexo.sh
RUN chmod +x ~/hexo.sh

#ENTRYPOINT ["/root/hexo.sh"]