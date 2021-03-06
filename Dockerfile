FROM debian:jessie

ADD . /app/src/github.com/die-net

ENTRYPOINT ["/app/bin/fotomat"]

CMD ["-listen=:3520"]

EXPOSE 3520

RUN apt-get -q update && \
    apt-get -y -q dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends ca-certificates curl gcc git libmagickwand-6.q16-dev && \
    apt-get clean && \
    mkdir -p /usr/local/go /app/pkg /app/bin && \
    curl -sS https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz | \
        tar --strip-components=1 -C /usr/local/go -xzf - && \
    GOPATH=/app /usr/local/go/bin/go get github.com/die-net/fotomat && \
    rm -rf /usr/local/go /app/pkg && \
    apt-get -y -q remove gcc git && \
    apt-get -y -q autoremove
