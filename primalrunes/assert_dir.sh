# Ensure a directory's exixstance (create if not exists)
using messages
using errors

# assert_dir DIR
assert_dir() {
	if [ "$#" -gt '1' ]; then
		for target; do
			assert_dir "$target"
		done
	elif [ -n "$(echo "$1" | sed -e 's/[^\/]//g')" ]; then
		declare -a path_split=( $( echo "$1" | sed -e 's/\// /' ) )
		assert_dir "${path_split[0]}"
		message "In dir ${path_split[0]}/:"
		add_indent "   "
		pushd "${path_split[0]}" >/dev/null
		assert_dir "${path_split[1]}"
		popd >/dev/null
		del_indent
	elif [ -e "$1" -a ! -d "$1" ]; then
		fatal_error "primalrunes/assert_dir.sh" "\`$1\' exists, but is not a directory"
	else
		status_message "Checking dir $1... "
		if [ -d "$1" ]; then
			status_report "\e[32mEXISTS\e[39m"
		else
			mkdir "$1"
			if [ -d "$1" ]; then
				status_report "\e[32mCREATED\e[39m"
			else
				status_report "\e[31mCREATION FAILED\e[39m"
				silent_error
			fi
		fi
	fi
}
