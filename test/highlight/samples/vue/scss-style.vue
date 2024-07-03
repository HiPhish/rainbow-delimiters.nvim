<!-- A style elemet written in SCSS -->

<style lang="scss" scoped>
.foo {
  color: red;
  background: #000;
  .bar {
    color: red;
    cursor: pointer;
  }
}

@media (not (color)) {
	.foo {
		color: #ffffff;
	}
}
</style>
