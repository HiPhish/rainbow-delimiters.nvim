package sample

import "core:fmt"

@(private)
S :: struct($T: typeid) {
	x, y: T,
	arr:  [5]int,
}

E :: enum {
	A,
	B,
}

U :: union {
	int,
	rune,
}

// i have no idea how this work
B :: bit_field int {}

foo :: proc() -> (int, string) {
	return 1, "hello"[1:3]
}

main :: proc() {
	st := S(int) {
		x   = 10,
		y   = 4,
		arr = {1, 2, 3, 4, 5},
	}

	_ = st.arr[1]

	m: map[rune]int = map[rune]int { 	// for the sake of example
		'w' = 1,
		's' = 2,
	}

	bs: bit_set[E] = bit_set[E]{.A, .B, .A}

	new_arr := [3]int{1, 2, 3}

	may: Maybe(string)

	exp := 5 * (1 + 2)

	mat: matrix[2, 3]int
	mat = matrix[2, 3]int{
		1, 2, 3, 
		4, 5, 6, 
	}

	switch v in may {
	case nil:
	case string:
	}

	fmt.printfln("%v, %v", st, m['w'])
}
