#let template(doc) = {
  set page(paper: "a4", margin: (x: 2cm, y: 3cm))
  set heading(numbering: "1.1")
  set par(justify: true, leading: 0.55em)

  show heading: it => {
    set block(above: 1.6em, below: 1em)
    it
  }

  doc
}

#show: template

= Typst

Typst is a markup language for typesetting documents. It is designed to be an
alternative to LaTeX and other document processing tools.

This is a #[nested section #[of text with #[multiple layers of nesting.]]]

Maths can either be typeset inline: $A = pi r^2$; or as a separate block:
$ frac(a^(2x), (5x + (3))) $

We can also put #[maths inside other content blocks: $V = 4/3 (pi r^3)$].


// vim:ft=typst
