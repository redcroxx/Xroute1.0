JAVA_DIR=/usr/local/java1.6
UBIDAEMON_DIR=/home/UbiDaemon
PROPERTY_DIR=$UBIDAEMON_DIR
UBIDAEMON_LOG=$UBIDAEMON_DIR/log/ubidaemon.log
XMS=512M
XMX=1024M
CLASSPATH=$UBIDAEMON_DIR/lib/UbiDaemon.jar:$UBIDAEMON_DIR/lib/UbiViewerLib.jar:$UBIDAEMON_DIR/lib/ubijdf.jar:$UBIDAEMON_DIR/lib/ubixml.jar:$UBIDAEMON_DIR/lib/ubixls.jar:$UBIDAEMON_DIR/lib/ubipdf.jar:$UBIDAEMON_DIR/lib/ubitext.jar:$UBIDAEMON_DIR/lib/ubilog4j.jar

nohup $JAVA_DIR/bin/java -Xms$XMS -Xmx$XMX -classpath $CLASSPATH:. com.ubidcs.daemon.UbiDaemon $PROPERTY_DIR > $UBIDAEMON_LOG & 
