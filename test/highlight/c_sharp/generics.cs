using System;

public class A<T> { }

public struct B<T> { }

public interface C<T> : A<IEnumerable<T>> { }

// Nested generic parameters
class Program {
    static void Main(List<List<List<T>>> l) {
    }
}

