(print (.. "foo" "bar"))

(local abcd { :a { :b { :c { :d {}}}}})

(let [one 1 two 2 tbl { : one : two}]
  tbl)

;;; Destructuring a table binding
(let [{:a {:b {:c {:d d}}}} abcd]
  (print d))

[0 [1 [2 [3 []]]]]

;; NOTE: the single ":" on the second line could also be a delimiter
{:a :b
 : abcd}

;;; Get AST root
(fn get-root [bufnr]
  ;;; Get current buffer
  (local bufnr (or bufnr
                   (vim.api.nvim_get_current_buf)))

  ;;; Early return if not in a Nix file
  (when (not= (. vim :bo bufnr :filetype)
              :nix)
    (vim.notify_once "This is meant to be used with Nix files")
    (lua "return nil"))

  (let [parser (vim.treesitter.get_parser bufnr :nix {})
        [tree] (parser:parse)]
    (tree:root)))

(macro -m?> [val ...]
  "Thread (maybe) a value through a list of method calls"
  (assert-compile
    val
    "There should be an input value to the pipeline")
  (var res# (gensym))
  (var res `(do (var ,res# ,val)))
  (each [_ [f & args] (ipairs [...])]
    (table.insert
      res
      `(when (and (not= nil ,res#)
                  (not= nil (. ,res# ,f)))
         (set ,res# (: ,res# ,f ,(unpack args))))))
  res)

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

(let [(a b c) (values 1 2 3)]
  (+ a b c))

(match (add-partial 5 6 7)
  [1 [2] 3] (print "osuhow")
  12        :dont
  x         x)

(each [key value (pairs {"a" 1 "b" 2})]
  (print key value))

(for [i 1 10]
  (print i))

(var numbers [1 2 3 4 5 6])

(collect [_ x (ipairs numbers)]
  (values x true))

(icollect [_ x (ipairs numbers)]
  (+ x 1))

(fcollect [i 0 10 2]
  (if (> i 2) (* i i)))

(accumulate [acc 0 _ x (ipairs numbers)]
  (+ acc x))

(faccumulate [n 0 i 1 5] (+ n i)) ; => 15

(#(faccumulate [n 1 i 1 $] (* n i)) 5) ; => 120 (factorial!)
((hashfn (faccumulate [n 1 i 1 $] (* n i))) 5) ; => 120 (factorial!)
