echo off
echo ########################################
echo       UbiDaemon ���� ���� ó��      
echo ########################################
echo.
set UBIDAEMON_DIR=C:\tomcat8_OTOO_Dev\UbiDaemon
set JS_EXE=%UBIDAEMON_DIR%\bin\JavaService64.exe
echo [���丮 ����]
echo UBIDAEMON : %UBIDAEMON_DIR%
echo.
echo [���� ����]
net stop UbiDaemonOTOODev
echo.
echo [���� ����]
%JS_EXE% -uninstall UbiDaemonOTOODev
echo ########################################
echo                  �� ��
echo ########################################
pause>nul
