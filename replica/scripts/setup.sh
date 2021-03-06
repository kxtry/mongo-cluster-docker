#!/bin/bash 

mongodb1="${MONGO1}"
mongodb2="${MONGO2}"
mongodb3="${MONGO3}"

echo "Waiting for startup.."
until mongo --host ${mongodb1} --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 1
done

echo "Started.."

echo setup.sh time now: `date +"%T" `
mongo --host ${mongodb1} <<EOF
   var cfg = {
        "_id": "${RS}",
        "protocolVersion": 1,
        "members": [
            {
                "_id": 0,
                "host": "${mongodb1}"
            },
            {
                "_id": 1,
                "host": "${mongodb2}"
            },
            {
                "_id": 2,
                "host": "${mongodb3}"
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOF
