@(:ant :bee
  :cat :dog
  :elephant :fox
  :giraffe :heron
  :iguana :janet)

@["Archimedes" "Bohm"
  "Cantor" "Deming"
  "Erdos" "Feynman"
  "Gauss" "Houdini"
  "Ishikawa" "Janet"]

{"Ada"
 {:file-extensions [".adb" ".ads"]
  :people ["Jean Ichbiah"]
  :year 1983}

 "Bash"
 {:file-extensions [".sh"]
  :people ["Brian Fox"
           "Chet Ramey"]
  :year 1989}

 "C"
 {:file-extensions [".c" ".h"]
  :people ["Dennis Ritchie"]
  :year 1972}

 "Dart"
 {:file-extensions [".dart"]
  :people ["Lars Bak"
           "Kasper Lund"]
  :year 2011}

 "Emacs Lisp"
 {:file-extensions [".el" ".elc" ".eln"]
  :people ["Richard Stallman"
           "Guy L. Steele, Jr."]
  :year 1985}

 "Forth"
 {:file-extensions [".fs" ".fth" ".4th" ".f" ".forth"]
  :people ["Charles H. Moore"]
  :year 1970}

 "Go"
 {:file-extensions [".go"]
  :people ["Robert Griesemer"
           "Rob Pike"
           "Ken Thompson"]
  :year 2009}

 "Haskell"
 {:file-extensions [".hs" ".lhs"]
  :people ["Lennart Augustsson"
           "Dave Barton"
           "Brian Boutel"
           "Warren Burton"
           "Joseph Fasel"
           "Kevin Hammond"
           "Ralf Hinze"
           "Paul Hudak"
           "John Hughes"
           "Thomas Johnsson"
           "Mark Jones"
           "Simon Peyton Jones"
           "John Launchbury"
           "Erik Meijer"
           "John Peterson"
           "Alastair Reid"
           "Colin Runciman"
           "Philip Wadler"]
  :year 1990}

 "Idris"
 {:file-extensions [".idr" ".lidr"]
  :people ["Edwin Brady"]
  :year 2007}

 "Janet"
 {:file-extensions [".cgen" ".janet" ".jdn"]
  :people ["Calvin Rose"]
  :year 2017}}

~@{:main
   (some :input)
   #
   :input
   (choice :non-form
           :form)
   #
   :non-form
   (choice :whitespace
           :comment)
   #
   :whitespace
   (choice (some (set " \0\f\t\v"))
           (choice "\r\n"
                   "\r"
                   "\n"))
   #
   :comment
   (sequence "#"
             (any (if-not (set "\r\n") 1)))
   #
   :form
   (choice :reader-macro
           :collection
           :literal)
   #
   :reader-macro
   (choice :fn
           :quasiquote
           :quote
           :splice
           :unquote)
   #
   :fn
   (sequence "|"
             (any :non-form)
             :form)
   #
   :quasiquote
   (sequence "~"
             (any :non-form)
             :form)
   #
   :quote
   (sequence "'"
             (any :non-form)
             :form)
   #
   :splice
   (sequence ";"
             (any :non-form)
             :form)
   #
   :unquote
   (sequence ","
             (any :non-form)
             :form)
   #
   :literal
   (choice :number
           :constant
           :buffer
           :string
           :long-buffer
           :long-string
           :keyword
           :symbol)
   #
   :collection
   (choice :array
           :bracket-array
           :tuple
           :bracket-tuple
           :table
           :struct)
   #
   :number
   (drop (cmt
           (capture (some :name-char))
           ,scan-number))
   #
   :name-char
   (choice (range "09" "AZ" "az" "\x80\xFF")
           (set "!$%&*+-./:<?=>@^_"))
   #
   :constant
   (sequence (choice "false" "nil" "true")
             (not :name-char))
   #
   :buffer
   (sequence "@\""
             (any (choice :escape
                          (if-not "\"" 1)))
             "\"")
   #
   :escape
   (sequence "\\"
             (choice (set `"'0?\abefnrtvz`)
                     (sequence "x" [2 :h])
                     (sequence "u" [4 :h])
                     (sequence "U" [6 :h])
                     (error (constant "bad escape"))))
   #
   :string
   (sequence "\""
             (any (choice :escape
                          (if-not "\"" 1)))
             "\"")
   #
   :long-string :long-bytes
   #
   :long-bytes
   {:main (drop (sequence :open
                          (any (if-not :close 1))
                          :close))
    :open (capture :delim :n)
    :delim (some "`")
    :close (cmt (sequence (not (look -1 "`"))
                          (backref :n)
                          (capture (backmatch :n)))
                ,=)}
   #
   :long-buffer
   (sequence "@"
             :long-bytes)
   #
   :keyword
   (sequence ":"
             (any :name-char))
   #
   :symbol (some :name-char)
   #
   :array
   (sequence "@("
             (any :input)
             (choice ")"
                     (error (constant "missing )"))))
   #
   :tuple
   (sequence "("
             (any :input)
             (choice ")"
                     (error (constant "missing )"))))
   #
   :bracket-array
   (sequence "@["
             (any :input)
             (choice "]"
                     (error (constant "missing ]"))))
   #
   :bracket-tuple
   (sequence "["
             (any :input)
             (choice "]"
                     (error (constant "missing ]"))))
   :table
   (sequence "@{"
             (any :input)
             (choice "}"
                     (error (constant "missing }"))))
   #
   :struct
   (sequence "{"
             (any :input)
             (choice "}"
                     (error (constant "missing }"))))
   }
