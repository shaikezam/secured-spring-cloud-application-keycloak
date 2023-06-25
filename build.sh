#!/bin/bash
docker swarm leave --force
echo "start build..."

cd api-gateway
mvn clean install -DskipTests -T 4
docker rmi api-gateway
docker build -t api-gateway .

cd ../service-discovery
mvn clean install -DskipTests -T 4
docker rmi service-discovery
docker build -t service-discovery .

cd ../product-service
mvn clean install -DskipTests -T 4
docker rmi product-service
docker build -t product-service .

cd ../order-service
mvn clean install -DskipTests -T 4
docker rmi order-service
docker build -t order-service .


cd ../db
docker rmi db
docker build -t db .

cd ../pma
docker rmi pma
docker build -t pma .

cd ../keycloak
docker rmi keycloak
docker build -t keycloak .

cd ../
docker swarm leave --force
docker swarm init
docker stack deploy --compose-file=docker-compose.yml product-web
