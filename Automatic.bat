@echo off
set dd=%DATE:~0,10%
set tt=%time:~0,8%
echo ====Trinitycore automatic update start %dd:/=-% %tt%====

taskkill /t /im authserver.exe
taskkill /t /im worldserver.exe

git -C C:\TrinityCore\TrinityCore pull
cmake -S C:\TrinityCore\TrinityCore\ -B C:\TrinityCore\build\
devenv C:\TrinityCore\build\TrinityCore.sln /Build "RelWithDebInfo|x64" /Project ALL_BUILD
copy C:\TrinityCore\build\bin\RelWithDebInfo\*.* C:\TrinityCore\server\*.* /Y

set dd=%DATE:~0,10%
set tt=%time:~0,8%
git -C C:\TrinityCore\server add .
git -C C:\TrinityCore\server commit -m "Trinitycore automatic update %dd:/=-% %tt%"
git -C C:\TrinityCore\server push origin master 

cd C:\TrinityCore\server\
start C:\TrinityCore\server\authserver.exe
start C:\TrinityCore\server\worldserver.exe

set dd=%DATE:~0,10%
set tt=%time:~0,8%
echo ====Trinitycore automatic update end %dd:/=-% %tt%====