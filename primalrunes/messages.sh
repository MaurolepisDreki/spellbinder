# Userspace Messaging Utility
using indent

# message MSG [...]
#    display a basic message
message() {
	indent
	echo -e "$@"
}

# status_message MSG [...]
#    display a status message (no newline)
status_message() {
	indent
	echo -n -e "$@"
}

# status_report
#    display followup status message (no indent)
status_report() {
	echo -e "$@"
}

