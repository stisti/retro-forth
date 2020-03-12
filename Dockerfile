FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y build-essential
ADD http://forthworks.com/retro/r/RETRO12-2019.7.tar.gz /build/
RUN cd /build && tar zxf RETRO12*.tar.gz
RUN cd /build && make -C RETRO12-2019.7
RUN mkdir -p /app/man/man1
RUN cd /build && make -C RETRO12-2019.7 install PREFIX=/app
WORKDIR /app

FROM debian:buster-slim
WORKDIR /app
COPY --from=0 /app .
ENTRYPOINT [ "/app/bin/retro" ]
