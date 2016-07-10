wget https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar -P /home/minecraft/.minecraft/versions/${MINECRAFT_VERSION}/

run() {
  overviewer.py --config /home/minecraft/config.py
  overviewer.py --config /home/minecraft/config.py --genpoi
}

envsubst < /home/minecraft/custom-template/index.template > /home/minecraft/custom-web/index.html

if [ ! -z "${MAPGEN_INTERVAL}" ]; then
  sleep 60
  while true 
  do
    run
    sleep ${MAPGEN_INTERVAL}
  done
else
  run
fi