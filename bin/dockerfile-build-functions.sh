. version-functions.sh

dockerfile_build_image(){
  local repository
  local mode
  local last
  local version
  local confirm

  if [ $# -lt 1 ]; then
    echo 'dockerfile_build_image: usage: dockerfile_build_image <REPOSITORY_NAME> [mode] [version]'
    return
  fi

  repository=$1; shift
  mode=$1; shift
  last=$1; shift

  if [ -z "$mode" ]; then
    mode=patch
  fi
  if [ -z "$last" ]; then
    last=$(docker images --format "{{.Tag}}" $repository | sort | tail -1)
  fi

  version_build_next $mode $last
  echo "version: $version"

  read -p "OK? [y/n] " confirm
  case "$confirm" in
    y*)
      echo "version: $version build start..."
      docker build --rm -t $repository:$version .
      ;;
    *)
      echo "abort"
      exit
      ;;
  esac
}
