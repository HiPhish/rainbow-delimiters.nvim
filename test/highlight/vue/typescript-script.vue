<!-- A script element in Typescript -->

<script setup lang="ts">
// Function with nested function
function add(x: number, y: number): number {
	function iter(i: number, acc: number) {
		if (i == 0) {
			return accu;
		}
		return iter(i - 1, acc + 1);
	}
	return iter(y, x)
}
</script>
