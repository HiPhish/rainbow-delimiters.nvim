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

defmodule DoEndBlocks do
    @moduledoc """
    Testing do end block nesting.
    """

    def check(x) do
        if x > 0 do
            :ok
        else
            :error
        end
    end

    def nested(x) do
        if x > 0 do
            if x > 10 do
                :big
            else
                :small
            end
        else
            :negative
        end
    end

    def try_example(x) do
        try do
            x + 1
        rescue
            _ -> :error
        end
    end
end

# Keyword list syntactic sugar
IO.puts inspect([a: 1, b: [c: 3, d: [e: 5, f: []]]])

# Map syntactic sugar
IO.puts inspect(%{a => 1, b => %{c => 3, d => %{e => 5, f => %{}}}})
