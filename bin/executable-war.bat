@echo off
echo [INFO] Packaging a executable war.

cd %~dp0
cd ..

set MAVEN_OPTS=%MAVEN_OPTS%
call mvn clean package -Pstandalone

echo [INFO] Executable war had been packaged as target/CMS4j-0.1.2.standalone.war


cd bin
pause