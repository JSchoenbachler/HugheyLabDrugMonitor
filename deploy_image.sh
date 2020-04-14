#!/bin/sh
# This script is designed to be run on the production server.
# It requires a command-line parameter of the new version number
# to be assigned to the newly built image.
# This should probably live somewhere else soon.

cd /var/www/drugmonitor/api/
mv config.py ../
git pull
if [[ $? -ne 0 ]]; then
  exit 1
fi

mv ../config.py .
docker build . -t drugmonitor:$1
docker service update --image drugmonitor:$1 drugmonitor_service
