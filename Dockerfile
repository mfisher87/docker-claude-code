FROM ubuntu:24.04

WORKDIR /workdir

ARG CLAUDE_CODE_VERSION
RUN test -n "${CLAUDE_CODE_VERSION}" || (echo "ERROR: CLAUDE_CODE_VERSION build argument is required" && exit 1)

RUN apt update
RUN apt install -y curl
RUN curl -fsSL https://claude.ai/install.sh | bash -s ${CLAUDE_CODE_VERSION}
ENV PATH="/root/.local/bin:${PATH}"
