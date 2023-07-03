# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 16, 14, 12, 16-bullseye, 14-bullseye, 12-bullseye, 16-buster, 14-buster, 12-buster
ARG VARIANT=16-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# Copy .nvmrc and package.json files
COPY .nvmrc /tmp/.nvmrc

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && apt-get -y install curl \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# [Optional] Uncomment if you want to install an additional version of node using nvm
RUN source ~/.nvm/nvm.sh && \
  export NVM_DIR="$HOME/.nvm" && \
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
  export VERSION=$(cat /tmp/.nvmrc) && \
  nvm install $VERSION && \
  nvm use $VERSION && \
  npm install -g pnpm

# [Optional] Uncomment if you want to install more global node modules
RUN su node -c "npm install -g pnpm@7.27.0"
