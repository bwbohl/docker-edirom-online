#!/bin/bash

echo
echo "###################################"
echo "# Welcome to docker-edirom-online #"
echo "###################################"
echo
echo "This docker container is based on stadlerpeter/existdb:6."
echo
echo "checking for XARs at /var/add-xars/"
xars=(/var/add-xars/*.xar)
[ -f "$xars" ] && echo "copying additional XARs…" && cp /var/add-xars/*.xar $EXIST_HOME/autodeploy/ || { echo "no XARs found"; }
echo
# starting the original image's entrypoint
echo "starting base-image…"
echo
exec ${EXIST_HOME}/entrypoint.sh
