FROM alpine

RUN apk add --no-cache \
    bash \
    git \
    github-cli \
    python3 py3-pip

RUN python3 -m pip install --upgrade pip
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]