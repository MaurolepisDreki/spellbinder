# Standardized Error Handling

# fatal_error WHERE MSG
fatal_error() {
	echo -e "$1: \e[31mFATAL\e[39m   $2"
	exit 1
}

# silent_error
#    register an error internally, but do not display any message
silent_error() {
	return
}

