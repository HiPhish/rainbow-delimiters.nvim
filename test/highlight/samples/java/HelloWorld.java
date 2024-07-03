@Author(name = "John Doe")
public class HelloWorld {
	// Constructor body
	public HelloWorld() {
	}

	// Method with formal parameters
	public static void main(String[] args) {
		System.out.println("Hello, world!");
		System.out.println(args[0]);
	}

	public static void printList(List<List<List<T>>> l) {
		// Array initializer
		String[] names = {"Alice", "Bob", "Carol", "Dan"};
		// Multi-dimensional dimensions and a dimensions expression
		Integer[][] inputArrays = new Integer[3][];

		// Enhanced for statement (for-each)
		for (var name: names) {
			var msg = String.format("Hello, %s.", name);
			System.out.println(msg);
		}

		// Regular for-statement
		for (var i = 0; i < 3; ++i) {
			System.out.print(i);
		}

		// Parentheses around condition
		if (false) {
			System.err.println("This will never print");
		}

		// Parentheses around catch clause
		try {
			// A parenthesized expression
			System.out.print(((3/0)));
		} catch(ArithmeticException e) {
			System.err.print(e);
		}


		// Nested bodies
		for (var item1: l) {
			for (var item2: item1) {
				for (var item3: item2) {
					System.out.format("%d", item3)
				}
			}
		}

		// Try resource specification
		try (FileWriter fw = new FileWriter("test");
				BufferedWriter bw = new BufferedWriter(fw)) {
			bw.close();
		} catch (IOException e) {
			System.out.println(e);
		}

		double d = 13.37;
		int i = (int) d; // cast expression
	}
}

// vim:noexpandtab
