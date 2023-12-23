#include <stdio.h>


#define PI 3.14
/* These aren't highlight correctly. A problem with the parser? */
#define TESTMACRO (-1)
#define min(X,Y) ((X) < (Y) ? (X) : (Y))


/* Declaration with parentheses, a function pointer */
static void (*callback)(int);
int c_init() { return 1; }

/* Macro type specifier */
#define Map int Foo
static Map(char *c_str) {return 4;}

typedef enum {
  E1,
  E2,
  E3
  // comment
} Myenum;

/* A function declaration */
int add(int, int);

struct Point2D {
	int x;
	int y;
};

/* Compound literal expression */
struct Point2D v = (struct Point2D){ 0, 0 };

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
