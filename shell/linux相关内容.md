## vim在shell中卡死的情况
    原因:Ctrl+s锁住了
    解决:Ctrl+q解锁
    
## tcpdump命令
> tcpdump -i eth1 -s 0 -w /home/tcpdump/data.pcap host 108.28.61.116

## linux查看端口占用的命令
> 比如，需要查看该linux是否在某一个端口起了某一个服务，可以用如下命令：  
lsof -i :10051

## 时间戳互相转换
> linux-20fr:/home # date -d "2016-10-12 00:00:00" +%s  
1476201600  
linux-20fr:/home # date -d @1476201600  "+%Y-%m-%d %H:%M:%S"  
2016-10-12 00:00:00

## Linux下查看服务器资源消耗
>  CPU占用最多的前10个进程：  
    ps auxw|head -1;ps auxw|sort -rn -k3|head -10  
   内存消耗最多的前10个进程   
        ps auxw|head -1;ps auxw|sort -rn -k4|head -10  
   虚拟内存使用最多的前10个进程  
        ps auxw|head -1;ps auxw|sort -rn -k5|head -10  

## linux查看物理CPU个数、核数、逻辑CPU个数
>  总核数 = 物理CPU个数 X 每颗物理CPU的核数   
 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数  
 查看物理CPU个数  
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l  
 查看每个物理CPU中core的个数(即核数)  
cat /proc/cpuinfo| grep "cpu cores"| uniq  
 查看逻辑CPU的个数  
cat /proc/cpuinfo| grep "processor"| wc -l  
 查看CPU信息（型号）  
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c  

## linux更新yum源
> 1、cd /etc/yum.repos.d下  
2、cp rhel-source.repo   rhel-source.repo.bak  
3、vi rhel-source.repo，对其中内容说明如下：  
    3.1、name：可以根据情况进行命名。  
    3.2、baseurl：源的地址，公司内测试部的地址是：http://10.92.252.233/rhel64/  
    3.3、enabled：是否可用，1为可用，0为不可用  
    3.4、gpgcheck：是否校验，1为校验，0为不校验。以上面的源为例，公司内，肯定是可靠的，所以不用校验  
    3.5、gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release  