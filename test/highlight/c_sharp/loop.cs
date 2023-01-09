using System;


// Nested loops
class Program {
	static int[] integers = {0, 1, 2, 3};

    static void Main() {
        foreach (int i in integers) {
        	foreach (int i in integers) {
        		foreach (int i in integers) {
        			foreach (int i in integers) {
        				while (false) {
        					Console.WriteLine("Hello, world!");
        				}
        			}
        		}
        	}
        }
    }
}
