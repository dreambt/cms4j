@echo off
echo [INFO] run sonar.

cd %~dp0
cd ..

set MAVEN_OPTS=%MAVEN_OPTS% -XX:MaxPermSize=128m
call mvn clean install -Dmaven.test.skip=true sonar:sonar

cd bin
pause