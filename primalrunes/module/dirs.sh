# Primal Runes Directory Controls
#    Utilities for handling source and destination directory stacks in a
#    standardized way

declare -g -a SOURCE_DIR
declare -g -a BINARY_DIR

push_src_dir() {
	SOURCE_DIR=( "$1" "${SOURCE_DIR[@]}" )
}

push_bin_dir() {
	BINARY_DIR=( "$1" "${BINARY_DIR[@]}" )
}

pop_src_dir() {
	SOURCE_DIR=( "${SOURCE_DIR[@]:1:$((${#SOURCE_DIR[@]} - 1))}" )
}

pop_bin_dir() {
	BINARY_DIR=( "${SOURCE_DIR[@]:1:$((${#BINARY_DIR[@]} - 1))}" )
}

