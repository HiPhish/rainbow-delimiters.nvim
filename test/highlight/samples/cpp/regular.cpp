#include <iostream>
#include <vector>
#include <cstdio>

namespace herp {
	const int derpiness = 9000;
	int get_derpiness() {
		return derpiness;
	}
}

enum color {
	RED,
	GREEN,
	BLUE,
};

/* A function declaration */
int add(int, int);

// Structure and class definitions
struct Point2D {
public:
	int x;
	int y;
};

class Point3D {
public:
	int x;
	int y;
	int z;
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

template <typename T> T myMax(T x, T y) {
	return (x > y) ? x : y;
}

float int2float(int i) {
	return (float)i;
}

void do_nothing_with_vector(std::vector<std::vector<std::vector<int>>> v) {
	return;
}

int main(int argc, char *argv[]) {
	auto a {10};
	auto b = (5);
    auto c = new int[b];
	auto result = add(a, b);
	printf("The sum of %d and %d is %d", ((((a)))), b, result);
	int indices[] = {0, };
	auto some_lambda = [] {};
	auto i = indices[indices[indices[indices[indices[indices[0]]]]]];
	for (auto i : {1, 2, 3}) {
		std::cout << i;
	}
	return 0;
}
