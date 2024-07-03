using System;

// Arrays and nested arrays
class Program {
    static void Main() {
        int[,,] array3D = new int[,,] {
        	{ {1}, {2} },
        	{ {3}, {4} },
        	{ {5}, {6} },
    		{ {7}, {8} },
    	};
    	int[] indices = new int[] {0};
    	int i = array3D[0, 0, 0];
        var implicitArray = new[] { "" };
    	int j = indices[indices[indices[indices[0]]]];
    }
}
