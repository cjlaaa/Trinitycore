#!/bin/bash

~/server/kill.sh authserver
~/server/kill.sh worldserver

cd ~/TrinityCore/
git pull origin 3.3.5
cd ~/TrinityCore/build/
cmake ../
make -j 2
make install

cd ~/server/etc/
cp authserver.conf.dist authserver.conf
cp worldserver.conf.dist worldserver.conf

cd ~/server/bin/
nohup ./authserver >/dev/null 2>&1 &
nohup ./worldserver >/dev/null 2>&1 &
