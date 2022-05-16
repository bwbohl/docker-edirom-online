#!/bin/bash

echo
echo "###################################"
echo "# Welcome to docker-edirom-online #"
echo "###################################"
echo
echo "This docker container is based on stadlerpeter/existdb:6."
echo "In order to deploy your data XARs for Edirom-Online place"
echo "them in ›add-xars‹ directory next to the Dockerfile."
echo
echo "copying additional XARs…"
cp /var/add-xars/*.xar $EXIST_HOME/autodeploy/
echo
# starting the original image's entrypoint
echo "starting base-image…"
echo
exec ${EXIST_HOME}/entrypoint.sh
