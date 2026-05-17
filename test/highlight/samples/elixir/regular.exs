defmodule Regular do
  @moduledoc """
  A dummy test module.
  """

  def first_plus_five([head | tail]) do
    IO.puts("The first value is #{head}")
    head + (1 + (2 + 3))
  end

  def first_plus_five({a, b}) do
    IO.puts("The first value is #{a}")
    a + (1 + (2 + 3))
  end

  def first_plus_five(<<r, g, b>>) do
    IO.puts("The first value is #{r}")
    r + (1 + (2 + 3))
  end

  def first_plus_five(%{head => _}) do
    IO.puts("The first value is #{head}")
    head + (1 + (2 + 3))
  end

  defp accessLookup(map, x) do
    map[map[map[map[x]]]]
  end
end

# Keyword list syntactic sugar
IO.puts(inspect(a: 1, b: [c: 3, d: [e: 5, f: []]]))

# Map syntactic sugar
IO.puts(inspect(%{a => 1, b => %{c => 3, d => %{e => 5, f => %{}}}}))

defmodule AllBlocks do
  def with_example(opts) do
    with {:ok, a} <- Keyword.fetch(opts, :a),
         {:ok, b} <- Keyword.fetch(opts, :b) do
      a + b
    else
      :error -> :missing
    end
  end

  def nested_with(opts) do
    with {:ok, a} <- Keyword.fetch(opts, :a),
         {:ok, b} <- Keyword.fetch(opts, :b) do
      with {:ok, c} <- Keyword.fetch(opts, :c),
           {:ok, d} <- Keyword.fetch(opts, :d) do
        a + b + c + d
      else
        :error -> :inner_missing
      end
    else
      :error -> :outer_missing
    end
  end

  def fn_example do
    add = fn x, y ->
      x + y
    end

    nested = fn x ->
      fn y ->
        x + y
      end
    end

    add.(1, nested.(2).(3))
  end

  def unless_example(x) do
    unless x == 0 do
      :nonzero
    else
      :zero
    end
  end

  def case_example(x) do
    case x do
      :a -> 1
      :b -> 2
      _ -> 3
    end
  end

  def nested_case(x, y) do
    case x do
      :a ->
        case y do
          :c -> 1
          _ -> 2
        end

      _ ->
        3
    end
  end

  def cond_example(x) do
    cond do
      x > 10 -> :big
      x > 0 -> :small
      true -> :nonpositive
    end
  end

  def for_example do
    for x <- [1, 2, 3] do
      x * 2
    end

    for x <- [1, 2, 3],
        y <- [:a, :b] do
      {x, y}
    end
  end

  def receive_example do
    receive do
      {:msg, value} -> value
      :stop -> :done
    after
      5000 -> :timeout
    end
  end

  def nested_receive do
    receive do
      {:outer, pid} ->
        receive do
          {:inner, value} -> send(pid, value)
        after
          1000 -> :inner_timeout
        end
    after
      5000 -> :outer_timeout
    end
  end

  def if_example(x) do
    if x > 0 do
      :ok
    else
      :error
    end
  end

  def nested_if(x) do
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

  defmacro my_macro(expr) do
    quote do
      unquote(expr) + 1
    end
  end

  def try_full(x) do
    try do
      if x > 0 do
        :ok
      else
        raise "error"
      end
    rescue
      e in RuntimeError -> {:error, e}
    catch
      :exit, reason -> {:exit, reason}
    after
      IO.puts("done")
    end
  end
end
