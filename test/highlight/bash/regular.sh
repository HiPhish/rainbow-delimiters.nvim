#!/bin/bash

# Command substitution
echo $(basedir $(pwd))

# Variable expansion
echo ${FOO:-${BAR:-${BAZ}}}

# Test expression (using the `test` command)
if [ -d "herp/derp/" ]; then
	echo "Yay"
fi

# Test expression (bashism)
if [[ -d "herp/derp/" ]]; then
	echo "Yay"
fi

# Sub-shells
(true; false; (true; true; (false; true)))

person() {
	array=(
		[Alice]="$((2 ^ 10))"
		[Bob]=2048
	)
	echo "${array[$1]}"
}

person "Alice"
