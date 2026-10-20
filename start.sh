#!/bin/sh
set -eu

if [ "$EULA" = "TRUE" ]; then
  echo "eula=true" > /data/eula.txt
else
  echo "You must accept the EULA"
  exit 1
fi

JAVA_MIN_MEMORY="${JAVA_MIN_MEMORY:-4G}"
JAVA_MAX_MEMORY="${JAVA_MAX_MEMORY:-4G}"
SERVER_JAR="${SERVER_JAR:-/opt/minecraft/server.jar}"

exec java \
  -Xms"$JAVA_MIN_MEMORY" \
  -Xmx"$JAVA_MAX_MEMORY" \
  -jar "$SERVER_JAR" \
  nogui
