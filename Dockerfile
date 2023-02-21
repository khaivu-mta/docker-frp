FROM alpine

ENV FRP_VERSION=v0.47.0

ADD entrypoint.sh /entrypoint.sh

WORKDIR /build

RUN apk add --no-cache curl \
 && curl -fSL https://github.com/fatedier/frp/releases/download/${FRP_VERSION}/frp_${FRP_VERSION:1}_linux_386.tar.gz -o frp.tar.gz \
 && tar -zxv -f frp.tar.gz \
 && rm -rf frp.tar.gz \
 && mkdir /config \
 && mv frp_*_linux_386 /frp \
 && mv /frp/*.ini /config \
 && mv /entrypoint.sh /frp/

WORKDIR /frp

EXPOSE 6000 6001 7000 7001

CMD ["/frp/entrypoint.sh"]