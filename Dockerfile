FROM ubuntu:24.04

RUN apt-get update && apt-get install --no-install-recommends -y \
   ca-certificates \
   wget \
   && rm -rf /var/lib/apt/lists/*

WORKDIR /wowmuchdocker
EXPOSE 22556
ARG VERSION="1.14.9"
  
RUN wget https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
    tar -xvzf ./dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
    rm ./dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
	mv ./dogecoin-${VERSION} ./dogecoin-node && \
    cd ./dogecoin-node && \
    mkdir data && \
    cd ../..

CMD ["/wowmuchdocker/dogecoin-node/bin/dogecoind", "-conf=/etc/doge/dogecoin.conf", "-datadir=/etc/doge", "-printtoconsole"]
