package main

import (
	"strings"
)

HumanA: {
	name: "Bob"
	description: "A human named \(strings.ToUpper(name))"
}

_#ComplexType: (int | string) | bool

ok: _#ComplexType & 13

numList: [...int] & [ 1, 2, 3, 4 ]

elems: [Name=_]: {name: Name}
elems: {
	one: {}
	two: {}
}

_env:  string | *"dev" @tag(env,type=string)
host: "\(_env).example.com"

environments: (_env): "\(numList[1])"
