FROM gitpod/workspace-full:2022-04-11-18-21-27

COPY .nvmrc /tmp/.nvmrc
# Copy the package.json file to the Docker image
COPY package.json /tmp/package.json

ENV NVM_DIR $HOME/nvm

SHELL ["/bin/bash", "--login", "-c"]
RUN source ~/.nvm/nvm.sh && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    export VERSION=$(cat /tmp/.nvmrc) && \
    nvm install $VERSION && \
    nvm use $VERSION && \
    npm install -g pnpm

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install PNPM
RUN npm install -g pnpm

# Set up the workspace
RUN mkdir -p /home/gitpod/.npm-global/bin \
  && echo 'export PATH="/home/gitpod/.npm-global/bin:$PATH"' >> /home/gitpod/.bashrc

ENV PATH="/home/gitpod/.npm-global/bin:${PATH}"

# Set up the project
WORKDIR /workspace

# Copy your project files
COPY . .

# Install project dependencies
RUN pnpm install

# Add a HEALTHCHECK instruction
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
