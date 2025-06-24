#import "../src/lib.typ": pavemat
#import "utils.typ": render-examples

#show: render-examples.with(scope: (pavemat: pavemat))

#set heading(numbering: none)

#show heading.where(level: 1): it => {
  block(
    above: 1.5em,
    below: 1.0em,
    fill: blue.lighten(95%),
    stroke: blue.lighten(70%) + 1pt,
    radius: 6pt,
    inset: 12pt,
    width: 100%,
    {
      set text(size: 16pt, weight: "bold", fill: blue.darken(20%))
      it.body
    },
  )
}

#show heading.where(level: 2): it => {
  block(
    above: 1.2em,
    below: 0.8em,
    fill: gray.lighten(95%),
    stroke: (left: blue + 3pt),
    inset: (left: 10pt, rest: 4pt),
    width: 100%,
    {
      set text(size: 13pt, weight: "semibold", fill: gray.darken(30%))
      it.body
    },
  )
}

= Syntax Reference

== Direction Characters
#grid(
  columns: 2,
  gutter: 12pt,
  [
    - `W`/`w`: Up (w = hidden)
    - `S`/`s`: Down (s = hidden)
  ],
  [
    - `A`/`a`: Left (a = hidden)
    - `D`/`d`: Right (d = hidden)
  ],
)

== Fill Position Strings
#table(
  columns: 2,
  stroke: gray + 0.5pt,
  inset: 0.5em,
  fill: (col, row) => if row == 0 { gray.lighten(95%) } else { white },
  [*Format*], [*Description*],
  [`"x-y"`], [Flood fill from cell (x,y)],
  [`"[x-y]"`], [Fill only cell (x,y)],
  [`""`], [Global fill],
  [`"top-left"`, etc.], [Named positions],
)

== Common Patterns
#block(fill: blue.lighten(98%), stroke: blue.lighten(85%) + 0.5pt, radius: 4pt, inset: 10pt, width: 100%, {
  grid(
    columns: 2,
    gutter: 16pt,
    [
      ```typ
      "DD"           // Horizontal line
      "SS"           // Vertical line
      ```
    ],
    [
      ```typ
      "DSDS"         // Diagonal steps
      "DDSSAAWW"     // Complete border
      ```
    ],
  )
})

== Stroke Styles
#block(fill: green.lighten(98%), stroke: green.lighten(85%) + 0.5pt, radius: 4pt, inset: 10pt, width: 100%, {
  grid(
    columns: 2,
    gutter: 16pt,
    [
      ```typ
      red + 2pt                           // Color + thickness
      (paint: blue, thickness: 3pt)       // Dictionary style
      ```
    ],
    [
      ```typ
      (dash: "dashed")                    // Dashed line
      (dash: "dotted")                    // Dotted line
      ```
    ],
  )
})

== Multiple Paths
#block(fill: purple.lighten(98%), stroke: purple.lighten(85%) + 0.5pt, radius: 4pt, inset: 10pt, width: 100%, {
  ```typ
  pave: (
    (path: "DD", stroke: red + 2pt),
    (path: "SS", from: "top-right", stroke: blue + 1pt)
  )
  ```
})

= Basic Examples

== Simple Path

```typst
#pavemat(
  $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) $,
  pave: "DDSSAA"
)
```

== Path + Fills

```typst
#pavemat(
  $ mat(a, b, c; d, e, f; g, h, i) $,
  pave: "DDSS",
  fills: (
    "0-0": red.transparentize(80%),
    "[2-2]": blue.transparentize(80%)
  )
)
```

== Styled Paths

```typst
#pavemat(
  $ mat(1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12) $,
  pave: "DDD(paint: red, thickness: 2pt)SS(paint: blue, dash: 'dotted')AAA"
)
```

== Multiple Paths

```typst
#pavemat(
  $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) $,
  pave: (
    (path: "DD", stroke: red + 2pt),
    (path: "SS", from: "top-right", stroke: blue + 2pt),
    (path: "AA", from: "bottom-right", stroke: green + 2pt)
  )
)
```

= Advanced Examples

== Custom Directions

```typst
#pavemat(
  $ mat(α, β, γ; δ, ε, ζ; η, θ, ι) $,
  pave: "RRDDUULL",
  dir-chars: (up: "U", down: "D", left: "L", right: "R"),
  stroke: purple + 1.5pt
)
```

== Matrix Separator

```typst
#pavemat(
  $ mat(2, 1, 3, 8; 1, -1, 0, 2; 3, 2, -1, 1) $,
  pave: (path: "SSS", from: (0, 3), stroke: black),
  fills: (
    "[0-3]": blue.transparentize(80%),
    "[1-3]": blue.transparentize(80%),
    "[2-3]": blue.transparentize(80%)
  ),
  delim: "["
)
```

== Style Scoping

```typst
#pavemat(
  $ mat(1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12; 13, 14, 15, 16) $,
  pave: "D(paint: red, thickness: 2pt)DD(paint: blue)S(thickness: 3pt)SS]A]A]A",
  fills: ("1-1": yellow.transparentize(80%))
)
```

= Use Cases

== Data Analysis

```typst
#let data = $ mat(12, 34, 56, 78; 23, 45, 67, 89; 34, 56, 78, 90; 45, 67, 89, 01) $
#pavemat(
  data,
  pave: (
    (path: "DDDSSS", stroke: red + 2pt),           // Main path
    (path: "DSDSDS", stroke: (paint: blue, thickness: 1pt, dash: "dashed"))  // Flow
  ),
  fills: (
    "": gray.transparentize(95%),                  // Background
    "[0-3]": red.transparentize(80%),              // Max
    "[3-0]": green.transparentize(80%)             // Min
  )
)
```

== Algorithm Steps

```typst
#pavemat(
  $ mat(5, 2, 8, 1; 2, 5, 8, 1; 2, 5, 1, 8; 1, 2, 5, 8) $,
  pave: (
    (path: "D", from: (1,0), stroke: red + 2pt),     // Step 1
    (path: "D", from: (2,0), stroke: orange + 2pt),  // Step 2
    (path: "D", from: (3,1), stroke: blue + 2pt)     // Step 3
  ),
  fills: (
    "[3-0]": green.transparentize(80%),
    "[3-1]": green.transparentize(80%),
    "[3-2]": green.transparentize(80%),
    "[3-3]": green.transparentize(80%)
  )
)
```
