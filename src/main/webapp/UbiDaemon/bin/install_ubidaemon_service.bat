echo off
echo ########################################
echo       UbiDaemon ���� ��� ó��      
echo ########################################
echo.
set JAVA_DIR="C:\Program Files\Java\jdk1.8.0_121"
set UBIDAEMON_DIR=C:\tomcat8_OTOO_Dev\UbiDaemon
set PROPERTY_DIR=%UBIDAEMON_DIR%
set JVM=%JAVA_DIR%\jre\bin\server\jvm.dll
set XMS=512M
set XMX=1024M
set CLASSPATH=%UBIDAEMON_DIR%\lib\UbiDaemon.jar;%UBIDAEMON_DIR%\lib\UbiViewerLib.jar;%UBIDAEMON_DIR%\lib\ubijdf.jar;%UBIDAEMON_DIR%\lib\ubixml.jar;%UBIDAEMON_DIR%\lib\ubixls.jar;%UBIDAEMON_DIR%\lib\ubipdf.jar;%UBIDAEMON_DIR%\lib\ubitext.jar;%UBIDAEMON_DIR%\lib\ubilog4j.jar
set JS_EXE=%UBIDAEMON_DIR%\bin\JavaService64.exe
set LOG=%UBIDAEMON_DIR%\log\ubidaemon.log
echo [���丮 ����]
echo JAVA      : %JAVA_DIR%
echo UBIDAEMON : %UBIDAEMON_DIR%
echo.
echo [���� ���]
%JS_EXE% -install UbiDaemonOTOODev %JVM% -Djava.class.path=%CLASSPATH% -Xms%XMS% -Xmx%XMX% -start com.ubidcs.daemon.UbiDaemon -params %PROPERTY_DIR% -out %LOG% -err %LOG% -description "UbiDaemon for UbiReport"
echo.
echo [���� ����]
net start UbiDaemonOTOODev
echo ########################################
echo                  �� ��
echo ########################################
pause>nul