# Userspace command locator utility
using get_program
using indent

# find_program VAR CMD
#    A userspace wrapper for the get_program primitive
find_program() {
	indent
	echo -n "looking for $2... "
	get_program "$1" "$2"
	if [ -z "${!1}" ]; then
		echo -e "\e[31mNOT FOUND\e[0m"
	else
		echo -e "\e[32m${!1}\e[0m"
	fi
}

