def foo []: [nothing -> nothing] {
  (1 + (2 * 3))
  echo ...([1])
  null
}

def bar (
  --long (-f) # flag capsule
) {
  # closure
  let c = {|foo bar| $foo + $bar }
  # record
  let r = {key: val key2: [1 2 3] ...{key: val}}
  # list
  let l = [1 2 [3] ...[1 2]]
  # table
  let t = [[h1 h2]; [1 2]]
  # block
  if true {
    ()
  }
  # match
  match true {
    true => ()
    _ => ()
  }
}

let foo: record<bar: list<int>> = {bar: [1 2 3]}
