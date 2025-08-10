FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl unzip git sudo ca-certificates \
    libicu70 \
    libkrb5-3 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m runner && mkdir /actions-runner && chown runner:runner /actions-runner
USER runner
WORKDIR /actions-runner

RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | grep tag_name | cut -d '"' -f 4) \
    && curl -L -o actions-runner.tar.gz https://github.com/actions/runner/releases/download/${LATEST_VERSION}/actions-runner-linux-x64-${LATEST_VERSION#v}.tar.gz \
    && tar xzf actions-runner.tar.gz \
    && rm actions-runner.tar.gz

COPY start.sh /start.sh
ENTRYPOINT ["/bin/bash", "/start.sh"]
