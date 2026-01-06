let
  { UserSchema, .. } = {
    UserSchema = {
      name | std.contract.any_of [String, Number],
    },
  },

  display = match {
    [x, y] => 'Pair {fst = x, snd = y},
    {format = 'elf64, ..} => "64 bits format",
    'Ok msg => "Ok value: %{msg}!",
    'Error err => m%"It's not ok :( (%{err})"%,
    _ => "Unexpected value"
  },

  first_elem = fun array =>
    if array == [] then
      'Error "empty array"
    else
      'Ok (std.array.elem 0 array),
in
{
  op : Number = 5 * (1 + 2),
  op_func = (*) 5 3,
  users | Array UserSchema = [
    { name = "Alice" },
    { name = "Bob" },
  ],
  ok_value = display ('Ok "good"),
  array = [1] @ [2, 3],
}
