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

## Options

```bash
# build.sh
. dockerfile-build-functions.sh

dockerfile_build_pre(){
  # pre build
  # if you want cancel, return non-zero value
  echo $version # => build version
}
dockerfile_build_post(){
  # post build
  # if build failed, this function not execute
  echo $version # => build version
}

dockerfile_build_image <REPOSITORY_NAME> "$@"
```

## push

```bash
# build.sh
. dockerfile-build-functions.sh

dockerfile_build_post(){
  dockerfile_build_push <REPOSITORY_URL>
}

dockerfile_build_image <REPOSITORY_NAME> "$@"
```
