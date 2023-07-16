# check existance of command and return proper invocation path

# get_program CMD
#    locate CMD and return path
#
# get_program VAR CMD
#    locate CMD and store path in VAR
get_program() {
	if [ $# -eq '1' ]; then
		command -v "$1"
	elif [ $# -eq '2' ]; then
		declare -g "$1=`get_program "$2"`"
	else
		echo "init: find_program: invalid argument count ($#)" >&2
	fi
}

