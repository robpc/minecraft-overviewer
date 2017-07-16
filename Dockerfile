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
    apt-get install -y wget gnupg2 && \
    wget -O - https://overviewer.org/debian/overviewer.gpg.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y minecraft-overviewer gettext && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -m minecraft 

RUN mkdir -p /home/minecraft-overviewer/render

COPY config/config.py /home/minecraft-overviewer/config.py
COPY entrypoint.sh /home/minecraft-overviewer/entrypoint.sh

RUN mkdir -p /home/minecraft-overviewer/custom-template
RUN mkdir -p /home/minecraft-overviewer/custom-web

COPY html/index.template /home/minecraft-overviewer/custom-template

RUN chown minecraft:minecraft -R /home/minecraft-overviewer/

WORKDIR /home/minecraft-overviewer/

USER minecraft

VOLUME "/home/minecraft-overviewer/render/"

CMD ["bash", "/home/minecraft-overviewer/entrypoint.sh"]
