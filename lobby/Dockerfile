FROM openjdk:jdk-alpine

RUN apk add --no-cache bash curl py2-pip docker nodejs-npm
RUN pip install mcstatus speedtest-cli
RUN npm install -g toml-to-env

HEALTHCHECK --start-period=5m CMD healthcheck

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && chown minecraft:minecraft /home/minecraft

EXPOSE 25565 25575 23000

COPY --from=itzg/minecraft-server /usr/local/bin/rcon-cli /usr/local/bin
RUN ln -s /usr/local/bin/rcon-cli /usr/local/bin/console
COPY --from=itzg/minecraft-server /usr/local/bin/mc-server-runner /usr/local/bin

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

VOLUME ["/home/minecraft","/var/run/docker.sock"]
WORKDIR /home/minecraft

ENTRYPOINT [ "start" ]
CMD [""]

ENV ENABLE_RCON=true RCON_PORT=25575 RCON_PASSWORD=minecraft
ENV JVM_OPTS="-XX:+UseG1GC -Xms1G -Xmx1G -Dpaper.disableChannelLimit=true"

USER minecraft