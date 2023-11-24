#include <stdio.h>

#define MACRO 0

/* A function declaration */
int add(int, int);

struct Point2D {
	int x;
	int y;
};


/* A function definition */
int add(int x, int y) {
	if (!y) {
		if (1) {
			if (1) {
				if (1) {
					return x;
				}
			}
		}
	}

	while (0) {
		while (0) {
			while (0) {
				;
			}
		}
	}

	for (int i = 0; i < 0; i++) {
		for (int j = 0; j < 0; j++) {
			for (int k = 0; k < 0; k++) {
				;
			}
		}
	}

	return add(x + 1, y - 1);
}

float int2float(int i) {
	return (float)i;
}

int main(int argc, char *argv[]) {
	int a = 10, b = 5;
	int result = add(a, b);
	printf("The sum of %d and %d is %d", ((((a)))), b, result);
	int indices[] = {0, };
	int i = indices[indices[indices[indices[indices[indices[0]]]]]];
	#if 0
		/* A language server may mark this block semantically as a comment */
		printf("The sum of %d and %d is %d", ((((a)))), b, result);
	#endif
	return 0;
}
