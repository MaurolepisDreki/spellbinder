# Message Indentation Controls
using math
declare -a MSGIND

# add_indent IND [...]
#    Append IND to MSGIND
add_indent() {
	MSGIND=( "${MSGIND[@]}" "$@" )
}

# del_indent COUNT
#    Pop last entries from MSGIND
del_indent() {
	if [ "$#" -lt '1' ]; then
		del_indent 1
	elif [ "$#" -gt '1' ]; then
		del_indent $(sum $@)
	elif [ "$1" -ge "${#MSGIND[@]}" ]; then
		MSGIND=()
	elif [ "$1" -lt "0" ]; then 
		echo "init: del_indent: not a natural number (negative value)" >&2
	elif [ "$1" -gt "0" ]; then
		MSGIND=( "${MSGIND[@]:0:$((${#MSGIND[@]}-$1))}" )
	fi
}

# indent [MSG ...]
#   copy-out indent string along with optional MSG
#   if MSG is not provided, no newline is written
indent() {
	if [ "$#" -lt '1' ]; then
		for pre in "${MSGIND[@]}"; do
			echo -n "$pre"
		done
	else
		indent
		echo $@
	fi
}


