# db-integration-by-kafka-connectors

In this topic, we will make a database integration between mongoDB and postgreSQL.
To do this, we will use two [kafka connectors][kafka-connectors], a source connector from mongoDB and a sink connector at postgreSQL. 

## that will be the scenario:
![not found][scenario]

### 1 - mongoDB
That guy will be the trigger of the flow.

### 2 - source connector
That will be the "handler of mongoDB", that means it is still looking at mongoDB using mainly the (pipeline, schema.key, schema.value and topic.namespace.map) parameters as a guide.

* pipeline - what to look out for and how to treat.
* schema.key - the identification of the contract scheme.
* schema.value - the description of the contract scheme.
* topic.namespace.map - map of mongoDB collection to kafka topic.
> obviously there are several other parameters, but I highlighted some

### 3 - kafka broker and schema-register
The kafka broker is the message manager, and that's fine. 
But you need to pay attention to schema-register, this guy will be the schema contract manager, he must save the (schema.key and schema.value) to be used in message formatting.

### 4 - sink connector
That will be the "handler to postgreSQL", that means it is still looking at kafka topic (mapped at topic.namespace.map on source connector) to make the jdbc insertions.
Pay more attention at this parameters: 

* topics - should be matched with `topic.namespace.map` and will become the table name.
* pk.fields - the PK of table (should be at `pipeline` on source connector).
* fields.whitelist - should be contains the entire schema field that we want to save.
> obviously there are several other parameters, but I highlighted some
### 4 - postgreSQL
That will be that "end" of us integration flow. 

## to run we need:
 - docker
 - docker compose
## run with this
```sh
docker-compose build --no-cache && docker-compose up -d
```
![not found][docker-composer]

> it's normal have um mongoDB container stopped (he's only used to generate a fake mongoDB cluster set).

# example
### insert into mongo DB
```json
{
    "quoteId": "unique_string_hash",
    "planPrice": 1.87,
    "createdAt": 1651475252,
    "updatedAt": 1651475252
}
```
![not found][insert]

### select on postgreSQL
```sql
select * from "FROM_MONGO" fm;
```
![not found][select]

#
That's it.

Have a nice experience! 

:)


[scenario]: https://raw.githubusercontent.com/jonathan-sh/db-integration-by-kafka-connectors/main/doc/db-integration.jpg
[kafka-connectors]: https://www.youtube.com/watch?v=WnUsiueKfKI&ab_channel=Confluent
[docker-composer]: https://raw.githubusercontent.com/jonathan-sh/db-integration-by-kafka-connectors/main/doc/docker-composer.png
[insert]: https://raw.githubusercontent.com/jonathan-sh/db-integration-by-kafka-connectors/main/doc/insert.png
[select]: https://raw.githubusercontent.com/jonathan-sh/db-integration-by-kafka-connectors/main/doc/select.png