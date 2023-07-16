# math utilities

# sum NUM [...]
#    adds up a series of numbers
sum() {
	if [ "$#" -lt '1' ]; then
		sum 0
	elif [ "$#" -eq '1' ]; then
		echo "$1"
	else
		sum "$(($1+$2))" "${@:3:$(($#-2))}"
	fi
}

