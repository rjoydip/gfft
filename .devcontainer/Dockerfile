# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 16, 14, 12, 16-bullseye, 14-bullseye, 12-bullseye, 16-buster, 14-buster, 12-buster
ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

USER nonroot

# Copy .nvmrc and package.json files
COPY .nvmrc /tmp/.nvmrc

# Set the SHELL option
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    curl=7.74.0-1ubuntu2.3 \
    bash=5.1-2ubuntu2.1 && \
  rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install Node.js and PNPM
RUN source "$HOME/.nvm/nvm.sh" \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] \
    && . "$NVM_DIR/nvm.sh" \
    && VERSION="$(cat /tmp/.nvmrc)" \
    && nvm install "$VERSION" \
    && nvm use "$VERSION" \
    && npm install -g pnpm@latest

# Add a HEALTHCHECK instruction
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
