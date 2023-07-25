# Primal Runes's m4 compiler interface
using messages
using module/dirs
using assert_dir

if [ -z "$M4" ]; then
	using find_program
	find_program M4 m4
fi

# m4_make OUT IN [...]
m4_make() {
	assert_dir "$BINARY_DIR"
	status_message "Creating $1... "
	declare -a tmp=()
	for target; do
		tmp=( "$target" "${tmp[@]}" )
	done
	$M4 -P -I"$SOURCE_DIR" m4rc ${tmp[@]:0:$((${#tmp[@]} - 1 ))} >"$BINARY_DIR/$1"

	if [ -f "$BINARY_DIR/$1" ]; then
		status_report "\e[32mDONE\e[39m"
	else
		status_report "\e[31mFAILED\e[39m"
	fi
}

