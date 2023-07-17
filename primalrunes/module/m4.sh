# Primal Runes's m4 compiler interface
using messages
using module/dirs
using assert_dir

if [ -z "$M4" ]; then
	using find_program
	find_program M4 m4
fi

# m4_target OUT IN [...]
m4_target() {
	assert_dir "$BINARY_DIR"
	status_message "Creating $1... "
	declare -a tmp=()
	for target; do
		tmp=( "$target" "${tmp[@]}" )
	done
	$M4 -P -I"$SOURCE_DIR" m4rc ${tmp[@]:0:$((${#tmp[@]} - 1 ))} >"$BINARY_DIR/$1"
	status_report "UNKNOWN"
}

