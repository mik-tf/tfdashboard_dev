FROM ubuntu:latest

# Set working directory
WORKDIR /workspace

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install nvm, node, and yarn
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=20

# Install NVM and Node.js
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g yarn

# Add node and npm to path so the commands are available
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Configure git safe directory
RUN git config --global --add safe.directory /workspace/tfgrid-sdk-ts

# Copy startup script
COPY startup.sh /
RUN chmod +x /startup.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/startup.sh"]
