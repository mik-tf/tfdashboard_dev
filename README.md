<h1> ThreeFold Dashboard Development Environment Container</h1>
<h2>Table of Contents</h2>

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Building the Image](#building-the-image)
- [Running the Container](#running-the-container)
  - [1. With Automatic Startup (recommended)](#1-with-automatic-startup-recommended)
  - [2. Interactive Shell (for debugging or custom commands)](#2-interactive-shell-for-debugging-or-custom-commands)
- [Container Specifications](#container-specifications)
  - [Environment Configuration](#environment-configuration)
- [Troubleshooting](#troubleshooting)
- [Technical Notes](#technical-notes)

## Introduction

We present a basic Docker-based development environment with essential tools and configurations.

## Project Structure

```
.
├── Dockerfile
├── README.md
└── startup.sh
```

## Prerequisites

- Docker installed on your system

## Building the Image

From the directory containing the `Dockerfile` and `startup.sh`, run:

```bash
docker build -t dashboarddev .
```

## Running the Container

There are two ways to run the container. In both cases, you need to run it from the `tfgrid-sdk-ts` git repository.

### 1. With Automatic Startup (recommended)

This will automatically execute the startup script which runs:
- `yarn install`
- `make build`
- `make run project=playground`

```bash
docker run --network=host -v $(pwd):/workspace -it dashboarddev
```

### 2. Interactive Shell (for debugging or custom commands)

This will give you a bash shell in the container without running the startup script:

```bash
docker run --network=host -v $(pwd):/workspace -it --entrypoint /bin/bash dashboarddev
```

## Container Specifications

The container includes:
- Ubuntu (latest)
- Build essentials
- Python3
- Git
- Node.js 18 (via NVM)
- Yarn

### Environment Configuration
- Working directory: `/workspace`
- NVM configured with Node.js 18
- Git safe directory configured for `/workspace/tfgrid-sdk-ts`

## Troubleshooting

If you need to rebuild the image after making changes:
```bash
docker build --no-cache -t dashboarddev .
```

For permission issues with mounted volumes, verify your local directory permissions.

## Technical Notes

- Uses host network (`--network=host`)
- Local directory mounted to `/workspace`
- Changes in `/workspace` persist on the host machine
- Includes automatic NVM sourcing in startup script