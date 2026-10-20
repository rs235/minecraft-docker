# Use Alipne Linux as image base for downloading the server executable.
FROM alpine AS download

# Set working directory for Alpine to "downloads".
WORKDIR /downloads

# Download server jar file.
RUN wget "https://piston-data.mojang.com/v1/objects/33680f5f2ac32864d6d7cf5e56a705fdb3e05f4c/server.jar"

# Use eclipse-temurin as image base for running the server jar file.
FROM eclipse-temurin AS server

#  Set working directory to "data".
WORKDIR /data

# Create a directory for server installation.
RUN mkdir /opt/minecraft

# Copy jar file downloaded via Alpine to newly created server directory.
COPY --from=download /downloads /opt/minecraft

# Expose port TCP 25565.
EXPOSE 25565

# Copy eula script to /opt/minecraft.
COPY start.sh /start.sh

# Make eula.sh script executable.
RUN chmod +x /start.sh

# Set entrypoint to eula.sh which sets EULA based on EULA= enironmental variable and starts the server when executed.
ENTRYPOINT ["/start.sh"]

# CMD is located in eula.sh that ENTRYPOINT points to.
