@echo off
echo [INFO] Use maven jetty-plugin run the project.

cd %~dp0
cd ..

set MAVEN_OPTS=%MAVEN_OPTS% -server -Xms128m -Xmx256m -Xmn64m -Xss256k -XX:PermSize=96m -XX:MaxPermSize=128m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:CMSFullGCsBeforeCompaction=5 -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=80 -XX:+PrintCommandLineFlags -XX:+DisableExplicitGC -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -verbose:gc -Xloggc:bin/gc.log

call mvn jetty:run -Djetty.port=80

cd bin
pause