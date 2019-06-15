FROM openjdk:jdk-alpine
COPY --from=docker:stable /usr/local/bin/docker /usr/local/bin

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*
VOLUME ["/var/run/docker.sock"]
