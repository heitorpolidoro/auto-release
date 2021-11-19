FROM alpine

RUN apk add --no-cache \
    bash \
    git \
    github-cli

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN git clone https://github.com/heitorpolidoro/auto-release.git
COPY . /auto-release

WORKDIR /auto-release

ENTRYPOINT ["/entrypoint.sh"]