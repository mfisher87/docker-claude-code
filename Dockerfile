FROM ubuntu:24.04

WORKDIR /workdir

RUN apt update
RUN apt install -y curl
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/root/.local/bin:${PATH}"
