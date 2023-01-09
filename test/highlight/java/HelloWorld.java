public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello, world!");
		System.out.println(args[0]);
	}

	public static void printList(List<List<List<T>>> l) {
		for (var item1: l) {
			for (var item2: item1) {
				for (var item3: item2) {
					System.out.format("%d", item3)
				}
			}
		}
	}
}
