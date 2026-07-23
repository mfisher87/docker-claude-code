FROM ubuntu:24.04

WORKDIR /workdir

RUN apt update
RUN apt install -y curl git libatomic1

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

# Install pnpm & nodejs
ARG PNPM_VERSION=11.16.0
RUN set -eu; \
  curl -fsSL https://get.pnpm.io/install.sh | env SHELL="$(which bash)" sh -
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="$PNPM_HOME/bin:$PATH"
RUN pnpm runtime set node lts -g

# Disable Claude Code auto-updates
ENV DISABLE_AUTOUPDATER=1

# Install specific version of Claude Code
ARG CLAUDE_CODE_VERSION
RUN test -n "${CLAUDE_CODE_VERSION}" || (echo "ERROR: CLAUDE_CODE_VERSION build argument is required" && exit 1)
RUN curl -fsSL https://claude.ai/install.sh | bash -s ${CLAUDE_CODE_VERSION}
ENV PATH="/root/.local/bin:${PATH}"

RUN claude plugin marketplace add anthropics/claude-plugins-official
RUN claude plugin install superpowers@claude-plugins-official
