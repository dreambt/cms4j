@echo off
echo [INFO] Use maven jetty-plugin run the project.

cd %~dp0
cd ..

set MAVEN_OPTS=%MAVEN_OPTS% -XX:MaxPermSize=256m
call mvn jetty:run -Djetty.port=80

cd bin
pause