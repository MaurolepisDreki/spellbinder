# Primal Rune's perl interpreter interface
using messages
using module/dirs
using colors

if [ -z "$PERL" ]; then
	using find_program
	find_program PERL perl
fi

# PERL_SWINCDIR -> perl switch: include directory
if [ -z "$PERL_SWINCDIR" ]; then
	status_message "checking perl's include directory switch... "
	if $PERL -Iyes -e 'die unless $INC[0] =~ m/^yes$/;'; then
		declare -g PERL_SWINCDIR='-I'
	fi

	if [ -n "$PERL_SWINCDIR" ]; then
		status_report "\e[4m$PERL_SWINCDIR\e[24m"
	else
		status_report "\e[33mNONE\[39m"
	fi
fi

perl_run() {
	declare -a transargs=()
	for arg; do
		if [ -n "$BINARY_DIR" -a -f "$BINARY_DIR/$arg" ]; then
			transargs=( "${transargs[@]}" "$BINARY_DIR/$arg" )
		elif [ -n "$SOURCE_DIR" -a -f "$SOURCE_DIR/$arg" ]; then
			transargs=( "${transargs[@]}" "$SOURCE_DIR/$arg" )
		else
			transargs=( "${transargs[@]}" "$arg" )
		fi
	done

	$PERL $(if [ -n "$BINARY_DIR" ]; then echo -n "$PERL_SWINCDIR$BINARY_DIR"; fi) $(if [ -n "$SOURCE_DIR" ]; then echo -n "$PERL_SWINCDIR$SOURCE_DIR"; fi) $(for incdir in ${USINGDIRS[@]}; do echo -n "$PERL_SWINCDIR$incdir "; done) ${transargs[@]}
	return $?
}

perl_test() {
	declare name="$1"
	if [ "$#" -gt '1' ]; then
		shift
	fi

	status_message "Testing $name... "
	if perl_run "$1"; then
		status_report "${COLOR_GREEN}OK${COLOR_DEFAULT}"
	else
		exit 1
	fi
}
