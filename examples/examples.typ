#import "../src/lib.typ": pavemat

#{
  set math.mat(row-gap: 0.25em, column-gap: 0.1em)
  set text(size: 2em)

  show: align.with(center)

  pavemat(
    pave: ("SDS(dash: 'solid')DDD]WW", (path: "sdDDD", stroke: aqua.darken(30%))),
    fills: (
      "0-0": green.transparentize(80%),
      "1-1": blue.transparentize(80%),
      "[0-0]": green.transparentize(60%),
      "[1-1]": blue.transparentize(60%),
    ),
  )[$mat(P, a, v, e; "", m, a, t)$]
}

#let a = $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9; 10, 11, 12) $

This is the original matrix:

$ display(#a) $

Let's add some dashed lines and fillings!

#pavemat(
  a,
  pave: "dSDSDSLLAAWASSDD",
  fills: (
    "1-1": red.transparentize(80%),
    "1-2": blue.transparentize(80%),
    "3-0": green.transparentize(80%),
  ),
)

It is possible to customize stroke of path segments!

#pavemat(
  a,
  pave: (
    path: "AA(paint: red, thickness: 2pt)WdD(paint: blue)Ww(thickness: 1pt, dash: 'dotted')AaS]Aw]W]D",
    from: "bottom-right",
  ),
  fills: maroon.transparentize(90%),
)

Turn `debug` on to see the hidden lines.

#pavemat(
  a,
  pave: (
    path: "AA(paint: red, thickness: 2pt)WdD(paint: blue)Ww(thickness: 1pt, dash: 'dotted')AaS]Aw]W]D",
    from: "bottom-right",
  ),
  fills: maroon.transparentize(90%),
  debug: true,
)

With more paths and default fill.

#pavemat(
  a,
  pave: (
    (path: "WASD", from: (2, 2)),
    (path: "WDSA", from: "bottom-left", stroke: red + 0.5pt),
    (path: "DSAW", from: (3, 2)),
  ),
  stroke: blue + 1pt,
  fills: (
    "": green.transparentize(80%),
    "0-0": red.transparentize(80%),
    "3-2": blue.transparentize(80%),
  ),
)

You can also pass a ```typ math.mat``` to it instead of a `math.equation`.
If you don't like `WASD`, you can just overwrite it, but be careful of case-sensitivity!

#pavemat(
  math.mat(..range(5).map(i => range(5).map(j => i * 5 + j))),
  pave: (
    (path: "DDDDDRUUUUU", from: (0, 2)),
    (path: "RRRRRDLLLLL", from: (2, 0)),
  ),
  fills: (
    "": green.transparentize(80%),
    "top-left": red.transparentize(80%),
    "3-right": blue.transparentize(80%),
    "[bottom-left]": blue.transparentize(80%),
  ),
  dir-chars: (up: "U", down: "D", left: "L", right: "R"),
  block: true,
)
