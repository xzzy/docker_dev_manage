#!/bin/bash
unhealthycount=$(docker ps | grep unhealthy | grep nginxserver | wc -l);
healthy=$(docker ps | grep "(healthy)" | grep nginxserver | wc -l);
starting=$(docker ps | grep starting | grep nginxserver | wc -l);
echo $healthy;
echo $starting;
container_dir="/container-data/nginx-container"
if [ -d "$container_dir/nginx-config" ]
then
   echo "Directory Exists $container_dir/nginx-config"
else
   mkdir "$container_dir/nginx-config"
fi

if [ -d "$container_dir/letsencrypt-config" ]
then
   echo "Directory Exists $container_dir/letsencrypt-config"
else
   mkdir "$container_dir/letsencrypt-config"
fi


if [ $healthy -eq 0 ]
then
   if [ $starting -eq 0 ]
   then
      echo "Unhealthy - restarting";
      docker stop nginxserver
      docker rm nginxserver
      docker container run --name=nginxserver --mount type=bind,source=/container-data/nginx-container/nginx-config,target=/etc/webconfs/nginx/ --mount type=bind,source=/container-data/nginx-container/letsencrypt-config,target=/etc/letsencrypt --mount type=bind,source=/container-data/nginx-container/web/,target=/var/web/ -p 80:80  -p 443:443 -d -i -t digitalreachinsight/nginx-ubuntu-docker:latest
   fi
fi
if [ $unhealthycount -eq 0 ]
then
   echo "Healthy";
fi
