// Copied from https://quickshell.org/docs/v0.2.0/guide/qml-language/


// QML Import statement
import QtQuick 6.0

// Javascript import statement
import "myjs.js" as MyJs

// Root Object
Item {
  // Id assignment

  id: root
  // Property declaration
  property int myProp: 5;

  // Property binding
  width: 100

  // Property binding
  height: width

  // Multiline property binding
  prop: {
    // ...
    5
  }

  // Object assigned to a property
  objProp: Object {
    // ...
  }

  // Object assigned to the parent's default property
  AnotherObject {
    someArray: ['a', 'b', 'c', 'd']
    someObject: {
    	'a': 1,
    	'b': 2,
    	'c': 3,
    }
    // ...
  }

  // Signal declaration
  signal foo(bar: int)

  // Signal handler
  onSignal: console.log("received signal!")

  // Property change signal handler
  onWidthChanged: console.log(`width is now ${width}!`)

  // Multiline signal handler
  onOtherSignal: {
    console.log("received other signal!");
    console.log(`5 * 2 is ${dub(5)}`);
    // ...
  }

  // Attached property signal handler
  Component.onCompleted: MyJs.myfunction()

  // Function
  function dub(x: int): int {
    return x * 2
  }

  // Inline component
  component MyComponent: Object {
    // ...
  }
}
