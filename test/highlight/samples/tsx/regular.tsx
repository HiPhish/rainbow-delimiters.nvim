// Function with nested function
function add(x: number, y: number): number {
	function iter(i: number, acc: number) {
		if (i == 0) {
			return acc;
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

// Parenthesized expressions
console.log(1 + (2 + (3 + (4 + (5 + 6)))))


function hello() {
	console.log('Hello, world!');
}

function app() {
	return (
		<div style={{ display: 'flex' }}>
			<p>
				This is an <a href="https://example.com">Example link</a>.
			</p>
			<p>
				This is an <a href="https://example.com">Example<br/>link</a> with<br/> line <br/>break.
			</p>
			<button onClick={hello}>Click me!</button>
			<ComponentWithChildren>
				{someFunction().map((x) => <div></div>)}
			</ComponentWithChildren>
			<ComponentWith.property>
				{someFunction().map((x) => <div></div>)}
			</ComponentWith.property>
			<ComponentWith.property bool={true} arr={[1, 2, 3]} />
			<CustomComponent bool={true} arr={[1, 2, 3]} />
		</div>
	)
}
