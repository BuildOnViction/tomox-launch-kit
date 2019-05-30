#!/bin/bash

mongo0=`getent hosts ${MONGO0} | awk '{ print $1 }'`
mongo1=`getent hosts ${MONGO1} | awk '{ print $1 }'`
mongo2=`getent hosts ${MONGO2} | awk '{ print $1 }'`

port=${PORT:-27017}

echo "Waiting for startup.."
until mongo --host ${mongo0}:${port} --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 1
done

echo "Started.."

echo setup.sh time now: `date +"%T" `
mongo --host ${mongo0}:${port} <<EOF
   var cfg = {
        "_id": "${RS}",
        "members": [
            {
                "_id": 0,
                "host": "${mongo0}:${port}"
            },
            {
                "_id": 1,
                "host": "${mongo1}:${port}"
            },
            {
                "_id": 2,
                "host": "${mongo2}:${port}"
            }
        ]
    };
    rs.initiate(cfg);
EOF
