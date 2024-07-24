BEGIN {
	print "Hello world"
}

/(foo | (bar | baz))/ {
	print "One of foo, bar or baz"
	print (1 + (2 + (3 + 4)))
	print foo[bar[baz[herp[derp]]]]
	print foo(bar(baz(herp(derp))))
	if (false) {
		if (false) {
			if (false) {
				print "This never happens"
			}
		}
	}

	while (false) {
		do {
			for (i = 1; i < 5; i++) {
				print "This never happens"
			}
			for (var in array) {
				print "This never happens"
			}
		} while (false)
	}

	switch (expr) {
		case 1:
			print "One"
			break
		case 2:
			print "Two"
			break
		default:
			print "Something else"
	}
}
