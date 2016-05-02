dockerfile_build_image(){
	local is_major
	local is_patch
	local is_beta
	local last
	local version
	local confirm

	while getopts bmph OPT; do
		case $OPT in
			m)
				is_major=1
				;;
			p)
				is_patch=1
				;;
			b)
				is_beta=1
				;;
			h)
				echo "usage: ./build.sh [-m] [-p] [-b]"
				exit 1
				;;
		esac
	done

	last=$(docker images --format "{{.Tag}}" $repository | sort | tail -1)
	dockerfile_build_next_version

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
dockerfile_build_next_version(){
	local major
	local minor
	local patch
	local tip

	if [ -z "$last" ]; then
		if [ -n "$is_major" ]; then
			major=1
		else
			if [ -n "$is_patch" ]; then
				major=0
				minor=0
				patch=1
			else
				major=0
				minor=1
			fi
		fi
	else
		major=${last%%.*}

		if [ -n "$is_major" ]; then
			major=$(( $major+1 ))
			minor=
			patch=
			tip=
		else
			case "$last" in
				*.*)
					tip=${last#*.}
					;;
				*)
					tip=
					;;
			esac
			case "$tip" in
				*.*)
					minor=${tip%%.*}
					tip=${tip#*.}
					case "$tip" in
						*.*)
							patch=${tip%%.*}
							tip=${tip#*.}
							;;
						*)
							patch=$tip
							tip=
							;;
					esac
					;;
				*)
					minor=$tip
					tip=
					;;
			esac

			if [ -n "$is_beta" ]; then
				minor=999

				if [ -z "$patch" ]; then
					patch=1
				else
					patch=$(( $patch+1 ))
				fi
			else
				if [ -n "$is_patch" ]; then
					if [ -z "$patch" ]; then
						patch=1
					else
						patch=$(( $patch+1 ))
					fi
				else
					patch=
					if [ -z "$minor" ]; then
						minor=1
					else
						minor=$(( $minor+1 ))
					fi
				fi
			fi
		fi
	fi

	if [ "$minor" = 1000 ]; then
		major=$(( $major+1 ))
		minor=
		patch=
		tip=
	fi

	version=$major
	if [ -n "$minor" ]; then
		version=$version.$minor
	fi
	if [ -n "$patch" ]; then
		version=$version.$patch
	fi
	if [ -n "$tip" ]; then
		version=$version.$tip
	fi
}
