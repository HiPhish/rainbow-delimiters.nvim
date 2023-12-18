defmodule Regular do
    @moduledoc """
    A dummy test module.
    """

    def first_plus_five([head | tail]) do
        IO.puts "The first value is #{head}"
        head + (((1 + (2 + 3))))
    end

    def first_plus_five({a, b}) do
        IO.puts "The first value is #{a}"
        a + (((1 + (2 + 3))))
    end

    def first_plus_five(<<r, g, b>>) do
        IO.puts "The first value is #{r}"
        r + (((1 + (2 + 3))))
    end

    def first_plus_five(%{head => _}) do
        IO.puts "The first value is #{head}"
        head + (((1 + (2 + 3))))
    end

    defp accessLookup(map, x) do
        map[map[map[map[x]]]]
    end
end

# Keyword list syntactic sugar
IO.puts inspect([a: 1, b: [c: 3, d: [e: 5, f: []]]])

# Map syntactic sugar
IO.puts inspect(%{a => 1, b => %{c => 3, d => %{e => 5, f => %{}}}})
