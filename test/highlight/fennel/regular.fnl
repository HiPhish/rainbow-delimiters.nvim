(print (.. "foo" "bar"))

{ :a { :b { :c { :d {} } } } }

[0 [1 [2 [3 []]]]]

(fn add-partial [x]
  (fn [y]
    (fn [z] (+ x y z))))

(λ sub-partial [x]
   (λ [y]
      (λ [z] (- x y z))))

(let [a 1]
  (let [b 2]
    (let [c 3]
      (+ a b c))))

(let [t {:a 4 :b 8}]
  (set t.a 2) t)

(each [key value (pairs {"a" 1 "b" 2})]
  (print key value))

(for [i 1 10]
  (print i))

(var numbers [1 2 3 4 5 6])

(icollect [_ x (ipairs numbers)]
  (+ x 1))

(collect [_ x (ipairs numbers)]
  (values x true))

(accumulate [acc 0 _ x (ipairs numbers)]
  (+ acc x))
