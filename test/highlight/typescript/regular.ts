// Function with nested function
function add(x: number, y: number): number {
	function iter(i: number, acc: number) {
		if (i == 0) {
			return accu;
		}
		return iter(i - 1, acc + 1);
	}
	return iter(y, x)
}

// Function with generic type parameter
function id<T>(x: T): T {
    return x;
}

// Class with members
class Person {
    private name: string;
    private age: number;
    private salary: number;

    constructor(name: string, age: number, salary: number) {
        this.name = name;
        this.age = age;
        this.salary = salary;
    }

    toString(): string {
        return `${this.name} (${this.age}) (${this.salary})`; // As of version 1.4
    }
}

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
