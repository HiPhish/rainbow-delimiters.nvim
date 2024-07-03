.PHONY: all

all: herp derp

herp: a.txt
	# Command substitution
	echo $(basedir $(pwd))

	# Variable expansion
	echo ${FOO${BAR${BAZ}}}

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
