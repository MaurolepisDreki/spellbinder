# Ensure a directory's exixstance (create if not exists)
using messages
using errors

# assert_dir DIR
assert_dir() {
	if [ "$#" -gt '1' ]; then
		for target; do
			assert_dir "$target"
		done
	elif [ -e "$1" -a ! -d "$1" ]; then
		fatal_error "primalrunes/assert_dir.sh" "\`$1\' exists, but is not a directory"
	else #< [ ! -e "$1" ]
		status_message "Checking dir $1... "
		if [ -d "$1" ]; then
			status_report "\e[32mEXISTS\e[39m"
		else
			status_report "\e[33mMISSING\e[39m"
			if [ "$(dirname "$1")" != '.' ]; then
				add_indent "   "
				assert_dir "$(dirname "$1")"
				del_indent
			fi
			status_message "Creating dir $1... "
			mkdir "$1"
			if [ -d "$1" ]; then
				status_report "\e[32mCREATED\e[39m"
			else
				status_report "\e[31mFAILED\e[39m"
				silent_error
			fi
		fi
	fi
}
