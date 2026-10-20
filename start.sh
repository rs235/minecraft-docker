#!/bin/sh
set -eu

SERVER_JAR="${SERVER_JAR:-server.jar}"
JAVA_MIN_MEMORY="${JAVA_MIN_MEMORY:-4G}"
JAVA_MAX_MEMORY="${JAVA_MAX_MEMORY:-4G}"

# EULA
if [ "${EULA:-}" = "TRUE" ]; then
  echo "eula=true" > eula.txt
else
  echo "You must accept EULA"
  exit 1
fi

# Server URL "validation"
if [ -z "${MINECRAFT_SERVER_URL:-}" ]; then
    echo "MINECRAFT_SERVER_URL is not set"
    exit 1
fi

# Ensure download directory exists
mkdir -p "$(dirname "$SERVER_JAR")"

# Download the jar file if it doesn exist and handle incomplete downloads
if [ ! -f "$SERVER_JAR" ]; then
    echo "Downloading Minecraft server..."

    curl -fSL "$MINECRAFT_SERVER_URL" -o "${SERVER_JAR}.tmp"
    mv "${SERVER_JAR}.tmp" "$SERVER_JAR"
fi

# Start server
echo "Starting Minecraft server..."

exec java \
  -Xms"$JAVA_MIN_MEMORY" \
  -Xmx"$JAVA_MAX_MEMORY" \
  -jar "$SERVER_JAR" \
  nogui
