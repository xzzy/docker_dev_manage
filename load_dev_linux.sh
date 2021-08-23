docker stop postgresubuntu
docker stop pythonwebubuntu

docker run --rm --name=postgresubuntu  --mount type=bind,source=/container-data/postgres/data/,target=/data/ -p 172.17.0.1:5432:5432  -d -i -t  jasondbca/ubuntu_postgres_2004_development:latest
# -e "POSTFIX_MAIL_HOST=docker-webdev.dbca.wa.gov.au" -e "POSTFIX_RELAY_HOST=mail-relay.lan.fyi:587"  -e "POSTFIX_CATCHALL_EMAIL=jason.moore@dbca.wa.gov.au"
docker run --rm --name=pythonwebubuntu --mount type=bind,source=/container-data/python-web-dev/data/,target=/data/ --hostname docker-webdev -p 172.17.0.1:9000-9100:9000-9100  -p 19000:19000 -p 172.17.0.1:19006:19006 -p 172.17.0.1:2222:22 --cap-add SYS_ADMIN -d -i -t --privileged=true jasondbca/ubuntu_2004_development:latest

#docker run --rm --name=postgresubuntu  --mount type=bind,source=/container-data/postgres/data/,target=/data/ -p 10.17.0.1:5432:5432  -d -i -t  jasondbca/ubuntu_postgres_2004_development:1.0.2
#docker run -v dockercontainer:/data/ -v c:/docker_shared_data:/docker_shared_data --rm --name=pythonwebubuntu --hostname docker-webdev -e "POSTFIX_MAIL_HOST=docker-webdev.dbca.wa.gov.au" -e "POSTFIX_RELAY_HOST=mail-relay.lan.fyi:587"  -e "POSTFIX_CATCHALL_EMAIL=jason.moore@dbca.wa.gov.au"  -p 10.17.0.1:9000-9100:9000-9100 -p 10.17.0.1:2222:22 --cap-add SYS_ADMIN -d -i -t --privileged=true jasondbca/ubuntu_2004_development:1.0.34
