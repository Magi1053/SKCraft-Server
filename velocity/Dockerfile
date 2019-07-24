FROM openjdk:jdk-alpine

RUN apk add --no-cache bash wget

RUN addgroup -g 1000 velocity \
  && adduser -Ss /bin/false -u 1000 -G velocity -h /home/velocity velocity \
  && chown velocity:velocity /home/velocity

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

EXPOSE 25577
VOLUME ["/home/velocity"]
WORKDIR /home/velocity
ENTRYPOINT ["start"]
CMD [""]
USER velocity