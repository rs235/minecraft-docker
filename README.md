## Minecraft Java Edition in Docker

1. Downloads server jar file automatically.
2. Sets EULA based on provided environmental variable.
3. Bind mounts local directory for easy access to your Minecraft worlds. Can be replaced with a named volume if no easy access is required.
4. Starts server with `-Xmx4G -Xms4G -jar server.jar nogui` java parameters. Those can be adjusted with the following environmental variables:
`EULA=TRUE
JAVA_MIN_MEMORY=4G
JAVA_MAX_MEMORY=4G
SERVER_JAR=/opt/minecraft/server.jar`

### Building

##### Adjust server parameters in start.sh if needed, then run:
``` bash
docker build -f Dockerfile -t image:tag .
```

### Starting

#### Option 1: Docker run

##### Example docker run command
``` bash
docker run \
-it \
--rm \
-v /home/user/Minecraft/data:/data \
-e EULA=TRUE \
-e JAVA_MIN_MEMORY=4G \
-e JAVA_MAX_MEMORY=4G \
-e SERVER_JAR=/opt/minecraft/server.jar \
-p 25565:25565 \
image:tag
```

#### Option 2: Docker compose

Docker Compose depends on a local .env file to:
 - Accept EULA
 - Select an image
 - Set bind mount directory for server data
 - Receive additional server configuration

##### .env file template:
```
MINECRAFT_DATA=/home/user/Minecraft/data
MINECRAFT_IMAGE=image:tag
MINECRAFT_DATA=/home/user/Minecraft/data
MINECRAFT_IMAGE=image:tag
EULA=TRUE
JAVA_MIN_MEMORY=4G
JAVA_MAX_MEMORY=4G
SERVER_JAR=/opt/minecraft/server.jar
```

##### Start your server with a standard
``` bash
docker compose up
```


### To do: 
1. Stop baking the jar file into the image and download it when starting the container instead.
