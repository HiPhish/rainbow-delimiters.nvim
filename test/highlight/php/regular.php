<?php
// parenthesized expression
$var = ((3 + (18 - 5)) * 8);

// arguments
var_dump(max($var, 12));

// declaration list
class AddOp {

    // encapsed string
    private $innerValue = "var = {$var} - var value";

    // formal parameters
    public function concatStr($x, $y) {
        // array creation expression
        $arr = [1, 2, [3, [4, 5, 6]]];
        $idx = [0, 1, 2];

        // subscript expression
        echo $arr[$idx[1]];

        // compound statement
        if ($x == $y) {
            if ($x != $y) {
                return $x . $y;
            }
        }
        return $this->innerValue;
    }

}
