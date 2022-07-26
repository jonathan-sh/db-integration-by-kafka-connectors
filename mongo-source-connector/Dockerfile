FROM confluentinc/cp-kafka-connect-base:6.0.1

COPY launch.sh /etc/confluent/docker/launch
COPY connect-mongodb-source.properties /etc/kafka/connect-mongodb-source.properties
COPY connect-standalone.properties /etc/kafka/connect-standalone.properties
COPY pipeline.json /pipeline.json
COPY schema.key.json /schema.key.json
COPY schema.value.json /schema.value.json

USER root

RUN chmod 777 /etc/kafka/connect-mongodb-source.properties
RUN chmod 777 /etc/kafka/connect-standalone.properties
RUN echo pipeline=$(awk -v RS= '{$1=$1}1' /pipeline.json) >> /etc/kafka/connect-mongodb-source.properties
RUN echo output.schema.key=$(awk -v RS= '{$1=$1}1' /schema.key.json) >> /etc/kafka/connect-mongodb-source.properties
RUN echo output.schema.value=$(awk -v RS= '{$1=$1}1' /schema.value.json) >> /etc/kafka/connect-mongodb-source.properties
RUN cat /etc/kafka/connect-mongodb-source.properties

RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.5.1