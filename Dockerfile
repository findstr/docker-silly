FROM debian:stretch-slim
ADD luaiconv.c /luaiconv.c
ADD Makefile /Makefile
RUN set -x &&\
	apt-get update &&\
	apt-get install --no-install-recommends --no-install-suggests -y \
		git ca-certificates autoconf build-essential\
		libreadline-dev libssl-dev wget unzip && cd / && \
	git clone https://github.com/findstr/silly.git -b dev &&\
	cd silly && patch -p1 < ssl.patch && make && cd ../ && make linux&& \
	rm -rf silly/deps silly/.git silly/silly-src silly/lualib-src &&\
	apt-get remove --purge --auto-remove -y git ca-certificates build-essential autoconf libreadline-dev &&\
	rm -rf /var/lib/apt/lists/*
WORKDIR /
ENTRYPOINT ["/silly/silly"]

