<!-- A plain default Vue.js program using the default languages -->

<template>
    {{ errCode }}
    {{ $t(errMsg) }}
    <a-button type="primary" @click="goToHome">goToHome</a-button>
    <template #footer>
        <a-button type="primary" @click="goToHome">{{ $t(errMsg) }}</a-button>
    </template>
</template>

<script setup>
// Template strings
let who = 'world';
console.log(`Hello, ${who}`);
// Nested object
let some_object = {
	a: {
		b: {
			c: {},
		}
	}
};
</script>

<style>
.foo {
	color: #ffffff;
}
@media (not (color)) {
	.foo {
		color: #ffffff;
	}
}
</style>
