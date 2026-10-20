FROM eclipse-temurin:21-jre

ARG UID=1500
ARG GID=1500

# Install curl and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

# Create minecraft user, group and set permissions
RUN groupadd -g "${GID}" minecraft \
    && useradd --uid "${UID}" --gid minecraft --no-create-home --shell /usr/sbin/nologin minecraft \
    && chown minecraft:minecraft /data

# Server: 25565, RCON: 25575
EXPOSE 25565 25575

COPY start.sh /start.sh

RUN chmod +x /start.sh

# Run as unprivileged user
USER minecraft

ENTRYPOINT ["/start.sh"]
