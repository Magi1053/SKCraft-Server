FROM adoptopenjdk/openjdk8:alpine

RUN apk add --no-cache bash curl py2-pip git lua htop
RUN pip install mcstatus speedtest-cli

HEALTHCHECK --start-period=10m CMD healthcheck

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && chown minecraft:minecraft /home/minecraft

EXPOSE 25565 25575 23000

COPY --from=itzg/minecraft-server /usr/local/bin/rcon-cli /usr/local/bin
RUN ln -s /usr/local/bin/rcon-cli /usr/local/bin/console
COPY --from=itzg/minecraft-server /usr/local/bin/mc-server-runner /usr/local/bin

ADD http://builds.enginehub.org/job/warmroast/4523/download/warmroast-1.0.0-SNAPSHOT.jar /usr/local/lib/warmroast.jar
RUN chmod +r /usr/local/lib/warmroast.jar
ADD http://www.modcoderpack.com/files/mcp940.zip /tmp/mcp.zip
RUN unzip -q /tmp/mcp.zip 'conf/*' -d /tmp \
  && mv /tmp/conf /usr/local/share/mappings \
  && rm -f /tmp/mcp.zip

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*	

VOLUME ["/home/minecraft"]
WORKDIR /home/minecraft
USER minecraft

ENTRYPOINT [ "start" ]
#CMD ["-Dfml.queryResult=confirm"]

ENV ENABLE_RCON=true RCON_PORT=25575 RCON_PASSWORD=minecraft
ENV SERVER_NAME=Minecraft GAMEKEY='' PRIORITY=1
ENV MEMORY=8192 COUNTDOWN=300
