(1..<2)/*
    there's no special AST node for this range syntax, and the (ERROR) node here
    isn't correct, this code is valid and runs
*/.each { i -> // closjure
    def _n = (1 + 3) // declaration
    _n = (3 + 1)     // assignment

    // ternary_op, binary_op
    x = ((i % 2) == 0) ? "even" : "odd"

    // if_statement
    if (x == "even") {
        println "Even number: $i"
    } else {
        println("Odd number: $i") // argument_list
    }
    // for_parameters
    for (x=0; x<3; x++) {
        print "."
    }
    // for_in_loop
    for (y in ([1, [2, 3], 4])) { // FIXME: the nesting here
        println "y = $y"
    }
}

def henlo(name="fren") // parameter_list
{
    println "henlo $name"
}

{
    key = "hysm"
    map = [(key): "ra3d"] // map, map_item
    def abcd = [a: [b: [c: [d: [:]]]]] // map nesting
    _ = map["hysm"] // index
    list = [0, [1, [2, [3, []]]]] // list
    println "${map.hysm}" // interpolation

    if ("${map.hysm}" =~ /r${/.?/}3d/) { // regex, with nesting
        println "hysm is r3d"
    }
}() // this immediate lambda invocation is valid groovy but produces broken AST in the default TS grammar

x = 7.23
String result
switch (x) {
    case "foo": result = "found foo"
    // fall through
    case [4, 5, 6, 'inList']:
        result = "my list"
        break
    case ~/[0-9]+/:
        result = "numeric string"
        break
    case { it > 3 }: {
        result = "number > 3"
        break
    }
    default: result = "default"
}
assert result == "number > 3"
assert (result == "number > 3") // assertion

while ((1+2) != 3) {} // while_loop

List <List<Map<String, Integer>>> _trash = [[[mazen: 5]]] // generics
return ( // return
    "henlo" +
    " fren"
)
