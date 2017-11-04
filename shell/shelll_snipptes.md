## grep精确匹配
> docker images -a | grep -E '(^| )'"nf-oam"'($| )'

## grep拼接同一行多列
> $(docker images -a |grep tcfs_server | awk '{print $1":"$2}')
