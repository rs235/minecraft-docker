## Minecraft Java Edition in Docker

1. Downloads server jar file automatically.
2. Sets EULA based on provided environmental variable.
3. Bind mounts local directory for easy access to your Minecraft worlds. Can be replaced with a named volume if no easy access is required.
4. Starts server with `-Xmx4G -Xms4G -jar server.jar nogui` java parameters. Those can be adjusted with the following environmental variables:
```
EULA=TRUE
JAVA_MIN_MEMORY=4G
JAVA_MAX_MEMORY=4G
SERVER_JAR=/opt/minecraft/server.jar
```
[Docker Hub repo](https://hub.docker.com/r/rs235/minecraft)

### Building

##### Adjust minecraft user UID and GID if needed. Those need to match host filesystem bind mount ownership:
``` bash
docker build -f Dockerfile \
--build-arg UID=1500 \
--build-arg GID=1500 \
-t image:tag .
```

### Starting

#### Option 1: Docker run

##### Example docker run command
``` bash
docker run \
-it \
--rm \
--restart unless-stopped
--cap-drop=ALL \
--security-opt=no-new-privileges:true \
-v /host/path/data:/data \
-e EULA=TRUE \
-e JAVA_MIN_MEMORY=4G \
-e JAVA_MAX_MEMORY=4G \
-e SERVER_JAR=minecraft_server.26.3.jar \
-p 25565:25565 \
-p 127.0.0.1:25575:25575 \
image:tag
```

#### Option 2: Docker compose

Docker Compose depends on a local .env file to:
 - Accept EULA
 - Select an image
 - Set bind mount directory for server data
 - Receive additional server configuration

##### .env file example:
```
MINECRAFT_DATA=/host/path/data
MINECRAFT_IMAGE=image:tag
MINECRAFT_SERVER_URL=https://piston-data.mojang.com/.../server.jar
EULA=TRUE
JAVA_MIN_MEMORY=4G
JAVA_MAX_MEMORY=4G
SERVER_JAR=minecraft_server.26.3.jar
```

##### Start your server with a standard
``` bash
docker compose up
```


### To do: 
1. 
