#!/bin/bash

echo "start build..."

cd api-gateway
mvn clean install -DskipTests

cd ../service-discovery
mvn clean install -DskipTests

cd ../product-service
mvn clean install -DskipTests

cd ../order-service
mvn clean install -DskipTests

docker compose up