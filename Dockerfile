FROM ubuntu:24.04

WORKDIR /workdir

RUN apt update
RUN apt install -y curl git

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin/:$PATH"

# Install pixi
RUN curl -fsSL https://pixi.sh/install.sh | sh
ENV PATH="/root/.pixi/bin:${PATH}"

# Install gh cli
RUN pixi global install gh

# Install jq
RUN pixi global install jq

# Install nodejs & pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
  apt install -y nodejs

ARG PNPM_VERSION=10.33.0
RUN set -eu; \
  curl -fsSL "https://github.com/pnpm/pnpm/releases/download/v${PNPM_VERSION}/pnpm-linuxstatic-x64" > /usr/local/bin/pnpm; \
  chmod 0755 /usr/local/bin/pnpm

# Disable Claude Code auto-updates
ENV DISABLE_AUTOUPDATER=1

# Install specific version of Claude Code
ARG CLAUDE_CODE_VERSION
RUN test -n "${CLAUDE_CODE_VERSION}" || (echo "ERROR: CLAUDE_CODE_VERSION build argument is required" && exit 1)
RUN curl -fsSL https://claude.ai/install.sh | bash -s ${CLAUDE_CODE_VERSION}
ENV PATH="/root/.local/bin:${PATH}"

RUN claude plugin marketplace add anthropics/claude-plugins-official
RUN claude plugin install superpowers@claude-plugins-official
