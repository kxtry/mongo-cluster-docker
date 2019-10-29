#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

mode=$1
extern_ip=$2

case "$mode" in
     'build')
        if [ -f $path_script/docker-compose.yml ]; then
           echo 'the docker-compose.yml had been exist. if you want to continue, remove it.'
           exit 1
        fi
        /bin/cp $path_script/docker-compose.yml.template $path_script/docker-compose.yml && echo "$path_script/docker-compose.yml" | xargs /bin/sed -i "s#{{extern_ip}}#$extern_ip#g"
        echo 'success to build the file.'
     ;;
     *)
       basename=`basename "$0"`
       echo "Usage: $basename  {build}{extern_ip}"
       echo "---$basename build 192.168.10.104"
     ;;
esac
