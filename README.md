# dockerfile build functions

docker build utility functions

## Usage

```bash
. dockerfile_build_functions.sh

build_<REPOSITORY_NAME>_main(){
	local repository
	repository=<REPOSITORY_NAME>
	build_image "$@"
}
build_<REPOSITORY_NAME>_mainl "$@"
```

## Installation

```bash
clone https://github.com/sanzen-sekai/dockerfile-build-functions.git
PATH=$PATH:/path/to/dockerfile-build-functions/bin
```
