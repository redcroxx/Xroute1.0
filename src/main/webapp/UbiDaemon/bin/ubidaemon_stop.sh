UBIDAEMON_CLS=com.ubidcs.daemon.UbiDaemon

if [ `ps -ef | grep $UBIDAEMON_CLS | grep -v grep | awk '{print $2}'` ];then

        echo "UbiDaemon is ShutDown."
        kill -9 `ps -ef | grep $UBIDAEMON_CLS | grep -v grep | awk '{print $2}'`
        echo "UbiDaemon has ShutDown."
else

        echo "UbiDaemon can not quit."
        echo "Please confirm the UbiDaemon is operating very well."

fi
