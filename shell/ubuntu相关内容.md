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

## for循环报错：Syntax error: Bad for loop variable
在ubuntu中写了一个for循环，如下：
> root@xubuntu-xmb:/test# cat test.sh  
#!/bin/bash  
for (( i=12;i<16;i++ ))  
do  
 echo "i: $i"  
done  

执行的时候一直报错：
> Syntax error: Bad for loop variable

分析：
从 ubuntu 6.10 开始，ubuntu 就将先前默认的bash shell 更换成了dash shell；其表现为 /bin/sh 链接倒了/bin/dash而不是传统的/bin/bash。
所以在使用sh执行检测的时候实际使用的是dash，而dash不支持这种C语言格式的for循环写法。

解决办法：
1、将默认shell更改为bash。（bash支持C语言格式的for循环）
> sudo dpkg-reconfigure dash  

在选择项中选No

2、直接使用bash检测：
> bash -n xxx.sh  

3、为了确保shell脚本的可移植性，直接更改shell脚本，使用shell支持的for循环格式：
> for a in `seq $num`  
