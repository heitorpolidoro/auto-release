FROM alpine

RUN apk add --no-cache \
    bash \
    git \
    github-cli \
    python3 py3-pip

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]