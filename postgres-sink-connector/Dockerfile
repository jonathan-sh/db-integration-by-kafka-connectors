FROM confluentinc/cp-kafka-connect-base:6.0.1

COPY launch.sh /etc/confluent/docker/launch
COPY connect-postgres-sink.properties /etc/kafka/connect-postgres-sink.properties
COPY connect-standalone.properties /etc/kafka/connect-standalone.properties

USER root

RUN chmod 777 /etc/kafka/connect-postgres-sink.properties
RUN chmod 777 /etc/kafka/connect-standalone.properties

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.2.0
