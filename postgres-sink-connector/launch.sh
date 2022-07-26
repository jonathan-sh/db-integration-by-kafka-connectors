
#!/usr/bin/env bash

if [ -z "$KAFKA_JMX_OPTS" ]; then
  export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false "
fi

export KAFKA_JMX_HOSTNAME=${KAFKA_JMX_HOSTNAME:-$(hostname -i | cut -d" " -f1)}

if [ "$KAFKA_JMX_PORT" ]; then
  export JMX_PORT=$KAFKA_JMX_PORT
  export KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Djava.rmi.server.hostname=$KAFKA_JMX_HOSTNAME -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT -Dcom.sun.management.jmxremote.port=$JMX_PORT"
fi

echo "===> Launching ${COMPONENT} ... "
export CLASSPATH="/etc/kafka-connect/jars/*"
exec connect-standalone /etc/kafka/connect-standalone.properties /etc/kafka/connect-postgres-sink.properties