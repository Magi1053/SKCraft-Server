FROM adoptopenjdk/openjdk8:alpine

RUN apk add --no-cache bash curl htop

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && chown minecraft:minecraft /home/minecraft

EXPOSE 25565 25575

COPY --from=itzg/minecraft-server /usr/local/bin/rcon-cli /usr/local/bin
RUN ln -s /usr/local/bin/rcon-cli /usr/local/bin/console
COPY --from=itzg/minecraft-server /usr/local/bin/mc-server-runner /usr/local/bin

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*	

VOLUME ["/home/minecraft"]
WORKDIR /home/minecraft
USER minecraft

ENTRYPOINT [ "start" ]
#CMD ["-Dfml.queryResult=confirm"]

ENV ENABLE_RCON=true RCON_PORT=25575 RCON_PASSWORD=minecraft
ENV SERVER_NAME=Minecraft GAMEKEY="" PRIORITY=1
ENV MEMORY=2048 COUNTDOWN=300
