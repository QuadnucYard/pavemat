
#let render-examples(body, scope: (:)) = {
  show raw.where(lang: "typst", block: true): it => {
    show: block.with(
      fill: blue.lighten(97%),
      stroke: gray.lighten(50%) + 0.5pt,
      radius: 4pt,
      inset: 0.8em,
      width: 100%,
      breakable: false,
    )

    block(width: 100%, radius: 0.5em, fill: gray.transparentize(90%), inset: 0.5em, it)

    v(0.5em, weak: true)

    // Add a subtle separator
    line(length: 100%, stroke: gray.lighten(50%) + 0.5pt)

    v(0.5em, weak: true)

    // Parse and evaluate the code to show the result
    block(inset: (x: 0.5em, y: 0.4em), width: 100%, {
      set text(size: 10pt)
      let code = it.text
      eval(code, mode: "markup", scope: scope)
    })
  }

  body
}
