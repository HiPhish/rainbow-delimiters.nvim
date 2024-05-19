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

    async method(): Promise<Array<Record<string, number>>> {
        return []
    }
}

interface Request {
	body: RequestProp['body'];
}

enum A {
	Foo = "Bar",
}

// Template strings
const who = 'world';
console.log(`Hello, ${who}`);

// Nested object
let some_object = {
	a: {
		b: {
			c: {},
		}
	}
};

// Subscript expressions
const zeroes = [0];
console.log(zeroes[zeroes[zeroes[0]]])

let a = 1

switch(a) {
    case 1:
        break;
}

// Parenthesized expressions
console.log(1 + (2 + (3 + (4 + (5 + 6)))))
