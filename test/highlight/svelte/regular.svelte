<script lang="ts">
	import { baz } from 'foo/bar';

	baz({a: {b: {c: 'd'}}});
</script>

<style>
	p {
		font-size: 2em;
	}
</style>

<svelte:head>
	<title>Test page</title>
	<meta name="description" content="A test page" />
</svelte:head>

<h1>A test page for Svelte</h1>

<form action="?/herp/derp" method="post">
	<p>This is a paragraph</p>
	<hr/>
	<ul>
		{#each ["foo", "bar", "baz"] as x}
		<li class="some-class">{ x }</li>
		{/each}
	</ul>
	{# if True}
	<p>Some text </p>
	{/if}
</form>
