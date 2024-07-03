// Named imports
import { useState } from 'react'

// Template strings
const who = 'world';
console.log(`Hello, ${who}`);

// Function with nested function
function add(x, y) {
	function iter(i, acc) {
		if (i == 0) {
			return acc;
		}
		return iter(i - 1, acc + 1);
	}
	return iter(y, x)
}

// Loops
function iterate() {
	for (let i = 0; i <= 2; i++) {
		break;
	}

	let list = []
	for (let element of list) {
		console.log(element);
	}
}

// Arrow function definition
const multiply = (x, y) => x * y;

// Nested object and array
let some_object = {
	a: {
		b: {
			c: {},
		},
	d: [[1, 2, 3]]
	}
};

// object pattern
const destructuredFunction = ({ value }) => {
	return {}
}

// Subscript expressions
const zeroes = [0];
console.log(zeroes[zeroes[zeroes[0]]])

// Destructuring assignment
const [x, y] = array;

// Parenthesized expressions
console.log(1 + (2 + (3 + 4)))

let a = 1

switch(a) {
    case 1:
        break;
}

// export clause
export { zeroes }
