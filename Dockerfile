FROM ubuntu:17.10

RUN apt-get update && \
    apt-get install -y curl \
        libx11-xcb1 \
        apt-transport-https && \
    curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | \
    tee -a /etc/apt/sources.list.d/signal-xenial.list && \
    apt update && \
    apt install -y signal-desktop && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/usr/local/bin/signal-desktop" ]
