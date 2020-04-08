FROM adoptopenjdk/openjdk8:alpine-jre

RUN apk add --no-cache bash wget

RUN addgroup -g 1000 velocity \
  && adduser -Ss /bin/false -u 1000 -G velocity -h /home/velocity velocity \
  && chown velocity:velocity /home/velocity

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 25577
VOLUME ["/home/velocity"]
WORKDIR /home/velocity
ENTRYPOINT ["/start.sh"]
USER velocity
ENV MEMORY=1024