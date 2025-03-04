#!/bin/bash

requiredEnvVars=(
  'SIGNAL_TLS_PORT'
)

for envVar in "${requiredEnvVars[@]}"; do
  if [ -z "${!envVar}" ]; then
    echo "Make sure to set the all of the following environment variables:"
    echo "SIGNAL_TLS_PORT"
    exit 1
  fi
done

data_path="./data/certbot"

if [ ! -d "$data_path" ]; then
  echo "Make sure to run ./init-certificate.sh first."
  exit 1
fi

# copy docker-compose.yml
cp docker-compose.yml my-docker-compose.yml

# replace 443 port with the value of the SIGNAL_TLS_PORT environment variable
sed -i "s/443:443/${SIGNAL_TLS_PORT}:443/" my-docker-compose.yml

# remove the 80 port
sed -i "/80:80/d" my-docker-compose.yml

echo "done"




