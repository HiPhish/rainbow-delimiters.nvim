// Define a simple class with a primary constructor
class Person<T>(private val name: String, private val age: Int, private val t: T) {
    // Secondary constructor
    constructor(name: String) : this(name, 0)

    class Hello {
        class Goodbye {
        }
    }

    init {
        println("New person created with name $name")
    }

    // Member function
    fun greet() {
        println("Hello, my name is $name and I am $age years old.")
    }
}

// Extension function
fun String.exclaim() = "$this!"

// Top-level function
fun calculateFactorial(n: Int): Int {
    return if (n == 1) n else n * calculateFactorial(n - 1)
}

// Main function - entry point of the program
fun main() {
    val person = Person<Map<String, String>>("Alice", 30, emptyMap())
    person.greet()

    // Using the extension function
    println("Wow".exclaim())

    // Conditional
    val number = 5
    if (number % 2 == 0) {
        println("$number is even")
    } else {
        println("$number is odd")
    }

    // Loop
    for (i in 1..5) {
        println("Factorial of $i is: ${calculateFactorial(i)}")
    }

    // Using a map
    val map = mapOf("a" to 1, "b" to 2, "c" to 3)
    for ((key, value) in map) {
        println("Key: $key, Value: $value")
    }

    // Lambda expression
    val numbers = listOf(1, 2, 3, 4, 5)
    val doubled = numbers.map { it * 2 }
    println("Doubled numbers: $doubled")
}

val list = listOf(1, 2, 3)
list.forEach { item ->
    println(item)
}

fun operateOnNumbers(a: Int, b: Int, operation: (Int, Int) -> Int): Int {
    return operation(a, b)
}

val sum = operateOnNumbers(2, 3) { x, y -> x + y }
println("Sum: $sum")


val multiply = fun(x: Int, y: Int): Int {
    return x * y
}

println("Product: ${multiply(2, 3)}")

val x = 2
when (x) {
    1 -> println("x == 1")
    2 -> println("x == 2")
    else -> println("x is neither 1 nor 2")
}

when {
    1 == 1 -> print("1")
    else -> print("not")
}


val rows = 2
val cols = 3
val matrix = Array(rows) { IntArray(cols) }

// Fill the array
for (i in matrix.indices) {
    for (j in matrix[i].indices) {
        matrix[i][j] = i + j
    }
    matrix[matrix[i][i]]
}

// Print the 2D array
for (row in matrix) {
    for (col in row) {
        print("$col ")
    }
    println()
}

