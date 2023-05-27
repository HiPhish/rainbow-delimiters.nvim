#include <vector>
#include <iostream>
#include <cstdio>

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

__global__ void add_array(int *a, int size) {
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    if (i < size) {
        a[i] += 1;
    }
}

void call_device() {
	int *dev_a;
	cudaMalloc(&dev_a, 10 * sizeof(int));
	add_array<<<1, 10, 1>>>(dev_a, 10);
	cudaFree(dev_a);
}

int main(int argc, char *argv[]) {
	auto a {10};
	auto b (5);
	auto result = add(a, b);
	printf("The sum of %d and %d is %d", ((((a)))), b, result);
	int indices[] = {0, };
	auto i = indices[indices[indices[indices[indices[indices[0]]]]]];
	return 0;
}
