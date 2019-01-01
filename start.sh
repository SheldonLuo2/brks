#! /bin/bash
PROGRAM="/home/luoshuilong/brks/brks"
CONFIG="/home/luoshuilong/brks/brks/log.conf"
PIDFILE="/home/luoshuilong/brks/brks/brkspidfile.log"

if [ ! -x "$PROGRAM" ]; then

#if [ ! -x "$CONFIG" ]; then
#    echo "no search file $CONFIG"
#    exit 1
#fi

case $1 in
    "start")
        echo "Starting brks..."
        if [ -f $PIDFILE ]; then
            echo "$PROGRAM is running..."
            exit 6
        fi
        ${PROGRAM} ${CONFIG} &
        PID=$!
        [! -z "${PID}" ]
        echo  ${PID} > ${PIDFILE}
        ;;
    "stop")
        echo "Stopping brks...."
        if [ ! -f "$PIDFILE" ]; then
            echo "no brks to stop(cound not find file $BRKS)"
        else
            $KILL -9 $(cat "$PIDFILE")
            rm -rf "$PIDFILE"
        fi
        exit 2
        ;;
    "restart")
        shift
        "$0" stop ${@}
        sleep 3
        "$0" start ${@}
        echo "brks has been restart"
        ;;
    "status")
        echo "brks status is:"
        ;;
    *)
        echo "$0 {start|stop|restart|status}"
        exit 3
        ;;
esac

