# Userspace command locator utility
using get_program
using messages

# find_program VAR CMD
#    A userspace wrapper for the get_program primitive
find_program() {
	status_message "looking for $2... "
	get_program "$1" "$2"
	if [ -z "${!1}" ]; then
		status_report "\e[31mNOT FOUND\e[0m"
	else
		status_report "\e[32m${!1}\e[0m"
	fi
}

