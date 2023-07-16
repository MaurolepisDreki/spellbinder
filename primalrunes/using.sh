# **INCLUDE THIS FILE FIRST!  AND ONLY ONCE!***
#
# Userspace include wrapper w/ automatic guard

# Primitive utility functions
if [ -z "$(command -v include_tag)" ]; then
	if [ -z "$(command -v tr)" ]; then
		# TODO: SHOULD NOT BE FATAL!  Need alternative implimentations (e.g. perl, sed &c.)
		echo "primalrunes/using.sh: FATAL: required command \`tr\` does not exist" >&2
		exit 1
	else
		include_tag() {
			echo "INCLUDED_$(echo "$1" | tr "[:lower:]/ ." "[:upper:]___")"
		}
	fi
fi

if [ -z "$(command -v indirect)"]; then
	indirect() {
		echo "${!1}"
	}
fi

if [ -z "$(command -v isdef)" ]; then
	isdef() {
		test "$(indirect "$1")"
		return $?
	}
fi

# Self-include guard
# TODO: SHOULD NOT BE FATAL!  Need better method of skiping source script!
if isdef "$(include_tag "primalrunes/using.sh")"; then
	echo "primalrunes/using.sh: FATAL: Included more than once!" >&2
	exit 1
else
	declare -g INCLUDED_PRIMALRUNES_USING_SH="primalrunes/using.sh"
fi

if isdef USINGDIRS; then
	echo "primalrunes/using.sh: ERROR: variable USINGDIRS is already defined" >&2
	echo "   --- using anyway (operation undefined)" >&2
fi
declare -a USINGDIRS

if [ -n "$(command -v using_dir)" ]; then
	echo "primalrunes/using.sh: ERROR: command using_dir is already defined" >&2
	echo "   --- command override" >&2
fi
using_dir() {
	USINGDIRS=( "$@" "${USINGDIRS[@]}" )
}

using_dir `pwd` "$(pwd)/primalrunes"

if [ -n "$(command -v using)" ]; then
	echo "primalrunes/using.sh: ERROR: command using is already defined" >&2
	echo "   --- command override" >&2
fi
using() {
	if [ "$#" -gt '1' ]; then
		declare rc=0	
		for target; do
			using "$target"
			rc=$(($rc + $?))
		done
		return $rc
	else
		for dir in "${USINGDIRS[@]}"; do
			if test -z "$(indirect "$(include_tag "$1")")" -a \( -f "$dir/$1" -o -h "$dir/$1" \); then
				declare -g "$(include_tag "$1")=$dir/$1"
				source "$dir/$1"
				return 0 # TRUE
			elif test -z "$(indirect "$(include_tag "$1.sh")")" -a \( -f "$dir/$1.sh" -o -h "$dir/$1.sh" \); then
				declare -g "$(include_tag "$1.sh")=$dir/$1.sh"
				source "$dir/$1.sh"
				return 0 # TRUE
			fi
		done
		if ! isdef "$(include_tag "$1")" && ! isdef "$(include_tag "$1.sh")"; then
			if [ -z "$(command -v warning)" ]; then
				echo -e "primalrunes/using.sh: \e[33mWARNING\e[39m   module \`$1' \e[31mNOT FOUND\e[39m"
			else
				warning "primalrunes/using.sh" "module \`$1' \e[31mNOT FOUND\e[39m"
			fi
		fi
		return 1 # FALSE
	fi
}

