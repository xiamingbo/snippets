#!/bin/sh

[ $# != 1 ] && echo "Usage: $0 new_branch_name" && exit 1

jenkins_path="http://ip:port/job"
app_buildJob="job_name"
jobPage=${jenkins_path}/${app_buildJob}/

echo "jobPage: $jobPage"
curl -s ${jobPage} -o build.tmp --connect-timeout 5

lastbuild=$(cat build.tmp | grep -oE "Last build \(#[0-9]*" | grep -oE "[0-9]*")
newbuild=$(($lastbuild+1))

#由于2.0以上版本Jenkins增加了防跨站攻击功能，因此在每次访问Jenkins api的时候都需要将crubm参数带上，否则会提示认证不通过。
crumb=$(curl -s 'http://username:password@ip:port/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

curl -u username:password -H "$crumb" -s -d build -d delay=0sec ${jobPage}buildWithParameters?parameter=$1
echo "buliding ${app_buildJob} #${newbuild} url:${jobPage}"
echo -n "building..."
sleep 5

#下面为查看最新构建（刚刚触发的构建）的结果。
curl -o build.tmp2 -s --header n:${newbuild} ${jobPage}buildHistory/ajax
#判断结果文件中是否包含 In progress（排队中）|pending（构建中），是的话每三秒去重新获取结果进行判断
while grep -qE "In progress|pending" build.tmp2;
do
  echo -n "."
  sleep 3
  curl -o build.tmp2 -s --header n:${newbuild} ${jobPage}buildHistory/ajax
done
echo
#包含Success单词为构建成功
if grep -qE "Success" build.tmp2 ;then
  echo "Build Success"
#包含Unstable单词为构建有警告但是构建成功
elif grep -qE "Unstable" build.tmp2 ;then
  echo "Build Success, but is a Unstable build"
#包含Failed或者Aborted单词为构建失败
elif grep -qE "Failed|Aborted" build.tmp2 ;then
  echo "Build Fail"
  echo "#Open Link: ${jobPage}${newbuild}/console see details"
  rm -rf build.tmp*
  exit 1
fi

rm -rf build.tmp*
