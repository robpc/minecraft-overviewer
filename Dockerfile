# To use this Docker image, make sure you set up the mounts properly.
#
# The Minecraft server files are expected at
#     $MINECRAFT_WORLD_DIR or /home/minecraft/server
#
# The Minecraft-Overviewer render will be output at
#     /home/minecraft-overviewer/render

FROM debian:latest

MAINTAINER Mark Ide Jr (https://www.mide.io)

RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y wget && \
    wget -O - https://overviewer.org/debian/overviewer.gpg.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y minecraft-overviewer gettext && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -m minecraft && \
    mkdir -p /home/minecraft/render /home/minecraft/server

COPY config/config.py /home/minecraft/config.py
COPY entrypoint.sh /home/minecraft/entrypoint.sh

RUN mkdir -p /home/minecraft/custom-template
RUN mkdir -p /home/minecraft/custom-web

COPY html/index.template /home/minecraft/custom-template

RUN chown minecraft:minecraft -R /home/minecraft/

WORKDIR /home/minecraft/

USER minecraft

VOLUME "/home/minecraft/render/"

CMD ["bash", "/home/minecraft/entrypoint.sh"]
