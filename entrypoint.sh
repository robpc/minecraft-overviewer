#!/bin/bash
set -o errexit

# Require MINECRAFT_VERSION environment variable to be set (no default assumed)
if [ -z "$MINECRAFT_VERSION" ]; then
  echo "Expecting environment variable MINECRAFT_VERSION to be set if no versions available at /home/minecraft/.minecraft/versions/. Exiting."
  exit 1
fi

wget https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar -P /home/minecraft/.minecraft/versions/${MINECRAFT_VERSION}/

run() {
  overviewer.py --config /home/minecraft-overviewer/config.py
  overviewer.py --config /home/minecraft-overviewer/config.py --genpoi
}

envsubst < /home/minecraft-overviewer/custom-template/index.template > /home/minecraft-overviewer/custom-web/index.html

if [ ! -z "${MAPGEN_INTERVAL}" ]; then
  sleep 120
  while true 
  do
    run
    sleep ${MAPGEN_INTERVAL}
  done
else
  run
fi
