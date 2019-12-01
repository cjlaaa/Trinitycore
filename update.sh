#!/bin/bash

# 关闭服务器
~/server/kill.sh authserver
~/server/kill.sh worldserver

# 备份玩家数据库
mysqldump -P3306 -utrinity -ptrinity --databases auth > auth.sql 
mysqldump -P3306 -utrinity -ptrinity --databases characters > characters.sql

# 更新&&编译服务器
cd ~/TrinityCore/
git pull origin 3.3.5
cd ~/TrinityCore/build/
cmake ../
make -j 2
make install

# 更新配置文件
cd ~/server/etc/
cp authserver.conf.dist authserver.conf
cp worldserver.conf.dist worldserver.conf

# 上传到github
git add .
NOW=$(date +"%m-%d-%Y %H:%M:%S")
git commit -m "Trinitycore automatic update $NOW"
git push origin master

# 启动服务器
cd ~/server/bin/
nohup ./authserver >/dev/null 2>&1 &
nohup ./worldserver >/dev/null 2>&1 &
