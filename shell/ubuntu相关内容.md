## ubuntu设置系统自动更新
> 1、需要配置正确的apt源，具体位置在：/etc/apt/sources.list  
2、设置crontab定时任务：0 21 * * * (apt update && apt -y -d upgrade) > /dev/null

## ubuntu设置更新源
> 1、apt-get源：参照公司的源设置即可：  
在ubuntu 16.04上有docker的源，如果公司没有，就暂时将该源禁止掉；  
2、pip源：  
装完pip之后，在~目录下创建.pip目录，然后在该目录下创建pip.conf文件，在其中写入公司的pypi源地址如下：  
\# cat pip.conf   
[global]  
trusted-host = mirrors.***.com.cn  
index-url = http://mirrors.***.com.cn/pypi/simple   
如果不设置pypi的源，装完virtualenv之后，会卡在如下步骤：  
Installing setuptools, pip, wheel...  
直至失败，virtualenv后续操作就无法继续。  

## ubuntu查看服务服务信息
> service --status-all


## 设置和查看crontab日志

> crontab记录日志  
修改rsyslog  
sudo vim /etc/rsyslog.d/50-default.conf
cron.*              /var/log/cron.log #将cron前面的注释符去掉   
重启rsyslog  
sudo  service rsyslog  restart  
查看crontab日志  
less  /var/log/cron.log   
crontab问题定位  
查看日志  
/var/log/cron.log 和 /var/mail/$user  

## ubuntu vnc命令
> x11vnc -display :0 -auth /var/run/lightdm/root/:0 -forever -bg -o /var/log/x11vnc.log -rfbauth /etc/x11vnc.pass -rfbport 5900 PORT=5900