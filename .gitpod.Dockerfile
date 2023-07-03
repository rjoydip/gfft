FROM gitpod/workspace-full:2022-04-11-18-21-27

USER root

COPY .nvmrc /tmp/.nvmrc
# Copy the package.json file to the Docker image
COPY package.json /tmp/package.json

# Create the /usr/local/nvm directory
RUN mkdir -p /usr/local/nvm && chown -R gitpod:gitpod /usr/local/nvm
ENV NVM_DIR /usr/local/nvm

USER gitpod

SHELL ["/bin/bash", "--login", "-c"]
# Read the Node.js version from the .nvmrc file
ENV NODE_VERSION $(cat /tmp/.nvmrc)

RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

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
