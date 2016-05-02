# dockerfile build functions

docker build utility functions

## Usage

```bash
# build.sh

. dockerfile-build-functions.sh

build_<REPOSITORY_NAME>_main(){
	local repository
	repository=<REPOSITORY_NAME>
	build_image "$@"
}
build_<REPOSITORY_NAME>_main "$@"
```

```bash
./build.sh    # minor version up
./build.sh -m # major version up
./build.sh -p # patch version up
./build.sh -b # beta version up => minor 999 version's patch version up
```

## Installation

```bash
clone https://github.com/sanzen-sekai/dockerfile-build-functions.git
PATH=$PATH:/path/to/dockerfile-build-functions/bin
```
