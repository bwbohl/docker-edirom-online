#!/bin/bash

echo
echo "###################################"
echo "# Welcome to docker-edirom-online #"
echo "###################################"
echo
echo "This docker container is based on stadlerpeter/existdb:6."
echo "In order to deploy additional XARs at runtime, e.g.,"
echo "Edirom Edition data, place tme in a directory on your host"
echo "and mount it to ›/var/add-xars‹ using the docker run -v flag."
echo

# check for additional XARs
echo "checking for XARs at /var/add-xars/"
xars=(/var/add-xars/*.xar)
[ -f "$xars" ] && echo "copying additional XARs…" && cp /var/add-xars/*.xar $EXIST_HOME/autodeploy/ || { echo "no XARs found"; }
echo

# starting the original image's entrypoint
echo "starting base-image…"
echo

# executing the original entrypoint.sh from stadlerpeter/existdb:6
exec ${EXIST_HOME}/entrypoint.sh
