# dockerfile build functions

docker build utility functions

## Requirements

* https://github.com/sanzen-sekai/version-functions
* permission of access to docker (docker group)

## Usage

```bash
# build.sh
. dockerfile-build-functions.sh
dockerfile_build_image <REPOSITORY_NAME> "$@"
```

```bash
./build.sh [major|minor|patch|beta|exact] [version]
```

## Installation

```bash
git clone https://github.com/sanzen-sekai/dockerfile-build-functions.git
PATH=$PATH:/path/to/dockerfile-build-functions/bin
```
