FROM gitpod/workspace-full:latest

COPY .nvmrc /tmp/.nvmrc
# Copy the package.json file to the Docker image
COPY package.json /tmp/package.json

# Read the Node.js version from the .nvmrc file
RUN export NODE_VERSION=$(cat /tmp/.nvmrc) \
  && echo "Installing Node.js version $NODE_VERSION" \
  && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
  && export NVM_DIR="/root/.nvm" \
  && . "$NVM_DIR/nvm.sh" \
  && nvm install $NODE_VERSION \
  && nvm use $NODE_VERSION

# Install PNPM
RUN npm install -g pnpm

# Set up the workspace
USER gitpod
RUN mkdir -p /home/gitpod/.npm-global/bin \
  && echo 'export PATH="/home/gitpod/.npm-global/bin:$PATH"' >> /home/gitpod/.bashrc

ENV PATH="/home/gitpod/.npm-global/bin:${PATH}"

# Set up the project
WORKDIR /workspace

# Copy your project files
COPY . .

# Install project dependencies
RUN pnpm install
