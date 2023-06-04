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
console.log(1 + (2 + (3 + 4)))

function hello() {
	console.log('Hello, world!');
}

function app() {
	return (
		<div>
			<p>
				This is an <a href="https://example.com">Example link</a>.
			</p>
			<p>
				This is an <a href="https://example.com">Example<br/>link</a> with<br/> line <br/>break.
			</p>
			<ComponentWithChildren>
				{someFunction().map((x) => <div></div>)}
			</ComponentWithChildren>
			<button onClick={hello}>Click me!</button>
		</div>
	)
}
