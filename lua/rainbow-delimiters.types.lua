---@meta

--# Utility Library #--

---Strategy to use for highlighting with rainbow-delimiters
---Must implement `on_attach`, `on_detach` and `on_reset`
---@class rainbow_delimiters.strategy
---`on_attach`: setup the highlighting on attach
---@field on_attach fun(bufnr: integer, settings: rainbow_delimiters.buffer_settings)
---`on_detach`: remove any unneccesary remaining setup on detach
---@field on_detach fun(bufnr: integer)
---`on_reset`: update the highlighting on reset
---@field on_reset fun(bufnr: integer, settings: rainbow_delimiters.buffer_settings)

---@class (exact) rainbow_delimiters.buffer_settings
---@field strategy rainbow_delimiters.strategy
---@field parser vim.treesitter.LanguageTree
---@field lang string

--# Config #--

---Configuration table for rainbow-delimiters
---@class (exact) rainbow_delimiters.config
---Strategy to use for highlighting
---@field strategy rainbow_delimiters.config.strategies?
---Query to use for highlighting
---@field query rainbow_delimiters.config.queries?
---Highlight priority of rainbow delimiters
---@field priority rainbow_delimiters.config.priorities?
---Highlight colors
---@field highlight string[]?
---Whitelist for languages to highlight
---@field whitelist rainbow_delimiters.language[]?
---Blacklist for languages not to highlight
---@field blacklist rainbow_delimiters.language[]?
---Dynamic condition whether to enable rainbow highlighting
---@field condition (fun(bufnr: number): boolean)?
---Logging with log file and log level
---@field log rainbow_delimiters.logging?

---@class rainbow_delimiters.config.strategies
---@field ['']         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field astro        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field bash         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field c            (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field c_sharp      (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field clojure      (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field commonlisp   (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field cpp          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field css          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field cuda         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field cue          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field dart         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field elixir       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field elm          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field fennel       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field fish         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field glsl         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field go           (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field groovy       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field haskell      (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field hcl          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field html         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field janet_simple (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field java         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field javascript   (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field json         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field json5        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field jsonc        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field jsonnet      (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field julia        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field kdl          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field kotlin       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field latex        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field lua          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field luadoc       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field make         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field markdown     (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field nim          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field nix          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field nu           (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field ocaml        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field odin         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field perl         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field php          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field python       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field query        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field r            (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field racket       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field rasi         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field regex        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field rst          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field ruby         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field rust         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field scheme       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field scss         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field sql          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field starlark     (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field templ        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field terraform    (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field toml         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field tsx          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field typescript   (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field typst        (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field verilog      (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field vim          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field vimdoc       (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field vue          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field wgsl         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field yaml         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field yuck         (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---@field zig          (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?
---User defined language, not part of rainbow_delimiters support
---@field [string]     (string | rainbow_delimiters.strategy | fun(bufnr: integer): string | rainbow_delimiters.strategy?)?

---@class rainbow_delimiters.config.queries
---@field ['']         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field astro        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field bash         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field c            (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field c_sharp      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field clojure      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field commonlisp   (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cpp          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field css          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cuda         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field cue          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field dart         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field elixir       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field elm          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field fennel       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field fish         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field glsl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field go           (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field groovy       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field haskell      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field hcl          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field html         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field janet_simple (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field java         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field javascript   (('rainbow-delimiters' | 'rainbow-parens' | 'rainbow-delimiters-react' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | 'rainbow-delimiters-react' | string))?
---@field json         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field json5        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field jsonc        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field jsonnet      (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field julia        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field kdl          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field kotlin       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field latex        (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field lua          (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field luadoc       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field make         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field markdown     (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nim          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nix          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field nu           (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field ocaml        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field odin         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field perl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field php          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field python       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field query        (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field r            (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field racket       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rasi         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field regex        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rst          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field ruby         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field rust         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field scheme       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field scss         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field sql          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field starlark     (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field templ        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field terraform    (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field toml         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field tsx          (('rainbow-delimiters' | 'rainbow-parens' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | string))?
---@field typescript   (('rainbow-delimiters' | 'rainbow-parens' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-parens' | string))?
---@field typst        (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field verilog      (('rainbow-delimiters' | 'rainbow-blocks' | string) | fun(bufnr: integer): ('rainbow-delimiters' | 'rainbow-blocks' | string))?
---@field vim          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field vimdoc       (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field vue          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field wgsl         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field yaml         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field yuck         (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---@field zig          (('rainbow-delimiters' | string) | fun(bufnr: integer): ('rainbow-delimiters' | string))?
---User defined language, not part of rainbow_delimiters support
---@field [string]     (string | fun(bufnr: integer): string)?

---@class rainbow_delimiters.config.priorities
---@field ['']         (integer | fun(bufnr: integer): integer)?
---@field astro        (integer | fun(bufnr: integer): integer)?
---@field bash         (integer | fun(bufnr: integer): integer)?
---@field c            (integer | fun(bufnr: integer): integer)?
---@field c_sharp      (integer | fun(bufnr: integer): integer)?
---@field clojure      (integer | fun(bufnr: integer): integer)?
---@field commonlisp   (integer | fun(bufnr: integer): integer)?
---@field cpp          (integer | fun(bufnr: integer): integer)?
---@field css          (integer | fun(bufnr: integer): integer)?
---@field cuda         (integer | fun(bufnr: integer): integer)?
---@field cue          (integer | fun(bufnr: integer): integer)?
---@field dart         (integer | fun(bufnr: integer): integer)?
---@field elixir       (integer | fun(bufnr: integer): integer)?
---@field elm          (integer | fun(bufnr: integer): integer)?
---@field fennel       (integer | fun(bufnr: integer): integer)?
---@field fish         (integer | fun(bufnr: integer): integer)?
---@field glsl         (integer | fun(bufnr: integer): integer)?
---@field go           (integer | fun(bufnr: integer): integer)?
---@field groovy       (integer | fun(bufnr: integer): integer)?
---@field haskell      (integer | fun(bufnr: integer): integer)?
---@field hcl          (integer | fun(bufnr: integer): integer)?
---@field html         (integer | fun(bufnr: integer): integer)?
---@field janet_simple (integer | fun(bufnr: integer): integer)?
---@field java         (integer | fun(bufnr: integer): integer)?
---@field javascript   (integer | fun(bufnr: integer): integer)?
---@field json         (integer | fun(bufnr: integer): integer)?
---@field json5        (integer | fun(bufnr: integer): integer)?
---@field jsonc        (integer | fun(bufnr: integer): integer)?
---@field jsonnet      (integer | fun(bufnr: integer): integer)?
---@field julia        (integer | fun(bufnr: integer): integer)?
---@field kdl          (integer | fun(bufnr: integer): integer)?
---@field kotlin       (integer | fun(bufnr: integer): integer)?
---@field latex        (integer | fun(bufnr: integer): integer)?
---@field lua          (integer | fun(bufnr: integer): integer)?
---@field luadoc       (integer | fun(bufnr: integer): integer)?
---@field make         (integer | fun(bufnr: integer): integer)?
---@field markdown     (integer | fun(bufnr: integer): integer)?
---@field nim          (integer | fun(bufnr: integer): integer)?
---@field nix          (integer | fun(bufnr: integer): integer)?
---@field nu           (integer | fun(bufnr: integer): integer)?
---@field ocaml        (integer | fun(bufnr: integer): integer)?
---@field odin         (integer | fun(bufnr: integer): integer)?
---@field perl         (integer | fun(bufnr: integer): integer)?
---@field php          (integer | fun(bufnr: integer): integer)?
---@field python       (integer | fun(bufnr: integer): integer)?
---@field query        (integer | fun(bufnr: integer): integer)?
---@field r            (integer | fun(bufnr: integer): integer)?
---@field racket       (integer | fun(bufnr: integer): integer)?
---@field rasi         (integer | fun(bufnr: integer): integer)?
---@field regex        (integer | fun(bufnr: integer): integer)?
---@field rst          (integer | fun(bufnr: integer): integer)?
---@field ruby         (integer | fun(bufnr: integer): integer)?
---@field rust         (integer | fun(bufnr: integer): integer)?
---@field scheme       (integer | fun(bufnr: integer): integer)?
---@field scss         (integer | fun(bufnr: integer): integer)?
---@field sql          (integer | fun(bufnr: integer): integer)?
---@field starlark     (integer | fun(bufnr: integer): integer)?
---@field templ        (integer | fun(bufnr: integer): integer)?
---@field terraform    (integer | fun(bufnr: integer): integer)?
---@field toml         (integer | fun(bufnr: integer): integer)?
---@field tsx          (integer | fun(bufnr: integer): integer)?
---@field typescript   (integer | fun(bufnr: integer): integer)?
---@field typst        (integer | fun(bufnr: integer): integer)?
---@field verilog      (integer | fun(bufnr: integer): integer)?
---@field vim          (integer | fun(bufnr: integer): integer)?
---@field vimdoc       (integer | fun(bufnr: integer): integer)?
---@field vue          (integer | fun(bufnr: integer): integer)?
---@field wgsl         (integer | fun(bufnr: integer): integer)?
---@field yaml         (integer | fun(bufnr: integer): integer)?
---@field yuck         (integer | fun(bufnr: integer): integer)?
---@field zig          (integer | fun(bufnr: integer): integer)?
---User defined language, not part of rainbow_delimiters support
---@field [string]     (integer | fun(bufnr: integer): integer)?

---@alias rainbow_delimiters.language
---| 'astro'
---| 'bash'
---| 'c'
---| 'c_sharp'
---| 'clojure'
---| 'commonlisp'
---| 'cpp'
---| 'css'
---| 'cuda'
---| 'cue'
---| 'dart'
---| 'elixir'
---| 'elm'
---| 'fennel'
---| 'fish'
---| 'go'
---| 'groovy'
---| 'haskell'
---| 'hcl'
---| 'html'
---| 'janet_simple'
---| 'java'
---| 'javascript'
---| 'json'
---| 'json5'
---| 'jsonc'
---| 'jsonnet'
---| 'julia'
---| 'kdl'
---| 'kotlin'
---| 'latex'
---| 'lua'
---| 'luadoc'
---| 'make'
---| 'markdown'
---| 'nim'
---| 'nix'
---| 'nu'
---| 'ocaml'
---| 'odin'
---| 'perl'
---| 'php'
---| 'python'
---| 'query'
---| 'r'
---| 'racket'
---| 'rasi'
---| 'regex'
---| 'rst'
---| 'ruby'
---| 'rust'
---| 'scheme'
---| 'scss'
---| 'sql'
---| 'starlark'
---| 'templ'
---| 'terraform'
---| 'toml'
---| 'tsx'
---| 'typescript'
---| 'typst'
---| 'verilog'
---| 'vim'
---| 'vimdoc'
---| 'vue'
---| 'wgsl'
---| 'yaml'
---| 'yuck'
---| 'zig'
---User defined language, not part of rainbow_delimiters support
---| string

---@class (exact) rainbow_delimiters.logging
---@field file ('rainbow_delimiters.log' | string)?
---@field level integer
