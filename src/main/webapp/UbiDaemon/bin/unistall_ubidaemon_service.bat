echo off
echo ########################################
echo       UbiDaemon 서비스 해제 처리      
echo ########################################
echo.
set UBIDAEMON_DIR=C:\tomcat8_OTOO_Dev\UbiDaemon
set JS_EXE=%UBIDAEMON_DIR%\bin\JavaService64.exe
echo [디렉토리 정보]
echo UBIDAEMON : %UBIDAEMON_DIR%
echo.
echo [서비스 중지]
net stop UbiDaemonOTOODev
echo.
echo [서비스 해제]
%JS_EXE% -uninstall UbiDaemonOTOODev
echo ########################################
echo                  완 료
echo ########################################
pause>nul
