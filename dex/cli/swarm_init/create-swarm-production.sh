# Create docker machines
docker-machine create --driver amazonec2 \
  --amazonec2-open-port 5672 \
  --amazonec2-open-port 2377/tcp \
 --amazonec2-open-port 7946/tcp \
 --amazonec2-open-port 7946/udp \
 --amazonec2-open-port 4789/tcp \
 --amazonec2-open-port 4789/udp \
 --amazonec2-instance-type="t2.micro" \
  rabbitmq

docker-machine create --driver amazonec2 \
  --amazonec2-open-port 80 \
  --amazonec2-open-port 2377/tcp \
 --amazonec2-open-port 7946/tcp \
 --amazonec2-open-port 7946/udp \
 --amazonec2-open-port 4789/tcp \
 --amazonec2-open-port 4789/udp \
 --amazonec2-instance-type="t2.micro" \
  frontend

docker-machine create --driver amazonec2 \
  --amazonec2-open-port 8081 \
  --amazonec2-open-port 2377/tcp \
 --amazonec2-open-port 7946/tcp \
 --amazonec2-open-port 7946/udp \
 --amazonec2-open-port 4789/tcp \
 --amazonec2-open-port 4789/udp \
 --amazonec2-instance-type="t2.medium" \
  backend

# Create one manager node for each element
eval $(docker-machine env frontend)
docker swarm init --advertise-addr $(docker-machine ip frontend)

manager_token=$(docker swarm join-token manager --quiet)
worker_token=$(docker swarm join-token worker --quiet)

eval $(docker-machine env -u)
ip=$(docker-machine ip frontend)

eval $(docker-machine env backend)
docker swarm join --token $manager_token $(docker-machine ip frontend):2377

eval $(docker-machine env rabbitmq)
docker swarm join --token $manager_token $(docker-machine ip frontend):2377

docker network create --driver overlay --attachable frontend
docker network create --driver overlay --attachable backend

docker-machine ssh rabbitmq mkdir -p etc/ssl
docker-machine ssh client mkdir -p etc/ssl
docker-machine ssh mongodb mkdir -p etc/ssl
docker-machine ssh backend mkdir -p etc/ssl

docker-machine ssh backend sudo chmod 755 /etc/letsencrypt/live
docker-machine ssh backend mkdir -p etc/letsencrypt/amp.exchange

PRODUCTION_RABBITMQ_USERNAME=${PRODUCTION_RABBITMQ_USERNAME}
PRODUCTION_RABBITMQ_PASSWORD=${PRODUCTION_RABBITMQ_PASSWORD}
PRODUCTION_MONGODB_USERNAME=${PRODUCTION_MONGODB_USERNAME}
PRODUCTION_MONGODB_PASSWORD=${PRODUCTION_MONGODB_PASSWORD}



# mongod --dbpath /data/db --nojournal
# while ! nc -vz localhost 27017; do sleep 1; done

# echo "Creating mongodb user:"
# echo -e "Username: ${PRODUCTION_MONGOB_USERNAME}"
# echo -e "Password: ${PRODUCTION_MONGODB_PASSWORD}"
# mongo tomodex --eval "db.createUser({ user: 'PRODUCTION_MONGODB_USERNAME', pwd: 'PRODUCTION_MONGODB_PASSWORD', roles: [ { role: dbAdminAnyDatabase, db: tomodex } ] });"

# mongod --dbpath /data/db --shutdown
