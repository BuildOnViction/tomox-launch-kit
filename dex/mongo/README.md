## A simple, 3 node MongoDB cluster on Docker Swarm

Given a Docker Swarm, will start up 3 Mongo DB instances sharing a replica set.


### Usage
1. Build the `mongors` image:

```
$ docker-compose build

WARNING: Some services (rs) use the 'deploy' key, which will be ignored. Compose does not support 'deploy' configuration - use `docker stack deploy` to deploy to a swarm.
rs1 uses an image, skipping
rs2 uses an image, skipping
rs3 uses an image, skipping
Building rs
Step 1/5 : FROM mongo:4.0
 ---> f2b4f7eadfd2
Step 2/5 : COPY init.sh /tmp/init.sh
 ---> Using cache
 ---> 5a02bbaf1db5
Step 3/5 : RUN chmod +x /tmp/init.sh
 ---> Using cache
 ---> e143322f615c
Step 4/5 : LABEL maintainer="Hai Dam <haidv@tomochain.com>"
 ---> Running in fddadee5ab63
Removing intermediate container fddadee5ab63
 ---> 325bfed426b0
Step 5/5 : CMD /tmp/init.sh
 ---> Running in 7e27035f1f8a
Removing intermediate container 7e27035f1f8a
 ---> d4962824f7cb

Successfully built d4962824f7cb
Successfully tagged ericsmalling/mongors:3.4

```

2. Deploy the stack:

```
$ docker stack deploy -c docker-compose.yml db

Ignoring unsupported options: build

Creating network db_mongo
Creating service db_rs2
Creating service db_rs3
Creating service db_rs
Creating service db_rs1
```

3. Check state of services:

```
$ docker service ls

ID                  NAME                MODE                REPLICAS            IMAGE                      PORTS
jnbd0m27pfni        db_rs               replicated          0/1                 naviat/mongors:4.0   
58r9k9pp4el2        db_rs1              replicated          1/1                 mongo:4.0                  
lb6rnp9icrdt        db_rs2              replicated          1/1                 mongo:4.0                  
fb0xaw2ftcop        db_rs3              replicated          1/1                 mongo:4.0           
```

*The db_rs service will try to run several times waiting for the other services
to finish starting.  The last run should succeed, check with the following and the last (top-most) attempt should have a `Complete` state:*

```
$ docker service ps db_rs

ID                  NAME                IMAGE                      NODE                    DESIRED STATE       CURRENT STATE             ERROR                       PORTS
etwghr495vzn        db_rs.1             naviat/mongors:4.0   linuxkit-025000000001   Shutdown            Complete 42 seconds ago                               
b0mfdypyqkph         \_ db_rs.1         naviat/mongors:4.0   linuxkit-025000000001   Shutdown            Failed 49 seconds ago     "task: non-zero exit (1)"   
```

Additional verification (substitute the correct container name/hash in your environment):

```
$ docker exec -it db_rs1.1.krxwm3fzh8m7zt974mc9n3vlb mongo                                                                                                                                      0.06   ✔   17:04    26.06.19  
  MongoDB shell version v4.0.10
  connecting to: mongodb://127.0.0.1:27017/?gssapiServiceName=mongodb
  Implicit session: session { "id" : UUID("5d31dab9-8bbc-4e99-97c4-79f7f1fb0c86") }
  MongoDB server version: 4.0.10
  Welcome to the MongoDB shell.
  For interactive help, type "help".
  For more comprehensive documentation, see
          http://docs.mongodb.org/
  Questions? Try the support group
          http://groups.google.com/group/mongodb-user
  Server has startup warnings: 
  2019-06-26T09:59:59.914+0000 I STORAGE  [initandlisten] 
  2019-06-26T09:59:59.914+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
  2019-06-26T09:59:59.914+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
  2019-06-26T10:00:00.435+0000 I CONTROL  [initandlisten] 
  2019-06-26T10:00:00.436+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
  2019-06-26T10:00:00.436+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
  2019-06-26T10:00:00.436+0000 I CONTROL  [initandlisten] 
  ---
  Enable MongoDB's free cloud-based monitoring service, which will then receive and display
  metrics about your deployment (disk utilization, CPU, operation statistics, etc).
  
  The monitoring data will be available on a MongoDB website with a unique URL accessible to you
  and anyone you share the URL with. MongoDB may use this information to make product
  improvements and to suggest MongoDB products and deployment options to you.
  
  To enable free monitoring, run the following command: db.enableFreeMonitoring()
  To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---

rs0:PRIMARY>  rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2019-06-26T10:06:28.710Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1561543578, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1561543578, 1),
                        "t" : NumberLong(1)
                },
                "appliedOpTime" : {
                        "ts" : Timestamp(1561543578, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1561543578, 1),
                        "t" : NumberLong(1)
                }
        },
        "lastStableCheckpointTimestamp" : Timestamp(1561543578, 1),
        "members" : [
                {
                        "_id" : 0,
                        "name" : "rs1:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 389,
                        "optime" : {
                                "ts" : Timestamp(1561543578, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-06-26T10:06:18Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1561543216, 1),
                        "electionDate" : ISODate("2019-06-26T10:00:16Z"),
                        "configVersion" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "rs2:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 383,
                        "optime" : {
                                "ts" : Timestamp(1561543578, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1561543578, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-06-26T10:06:18Z"),
                        "optimeDurableDate" : ISODate("2019-06-26T10:06:18Z"),
                        "lastHeartbeat" : ISODate("2019-06-26T10:06:27.301Z"),
                        "lastHeartbeatRecv" : ISODate("2019-06-26T10:06:27.316Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "rs1:27017",
                        "syncSourceHost" : "rs1:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1
                },
                {
                        "_id" : 2,
                        "name" : "rs3:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 383,
                        "optime" : {
                                "ts" : Timestamp(1561543578, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1561543578, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-06-26T10:06:18Z"),
                        "optimeDurableDate" : ISODate("2019-06-26T10:06:18Z"),
                        "lastHeartbeat" : ISODate("2019-06-26T10:06:27.294Z"),
                        "lastHeartbeatRecv" : ISODate("2019-06-26T10:06:27.316Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "rs1:27017",
                        "syncSourceHost" : "rs1:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1
                }
        ],
        "ok" : 1,
        "operationTime" : Timestamp(1561543578, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1561543578, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
```

4. Shut it all down:

```
$ docker stack rm db

Removing service db_rs
Removing service db_rs1
Removing service db_rs2
Removing service db_rs3
Removing network db_mongo
```
