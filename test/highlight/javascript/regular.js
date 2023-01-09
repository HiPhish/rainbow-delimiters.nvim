// Template strings
let who = 'world';
console.log(`Hello, ${who}`);

// Nested object
let some_object = {
	a: {
		b: {
			c: {},
		}
	}
};

// Function with nested function
function add(x, y) {
	function iter(i, acc) {
		if (i == 0) {
			return accu;
		}
		return iter(i - 1, acc + 1);
	}
	return iter(y, x)
}

// Class with method
class Foo {
	method() {
		console.log('Hi!');
	}
}
