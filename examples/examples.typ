#import "../src/lib.typ": pavemat
#import "logo.typ": logo

#align(center, logo)

#show: columns.with(2)

#let a = $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9; 10, 11, 12) $

This is the original matrix:

$ display(#a) $

Let's convert it to a _pavemat_!

#let e0 = pavemat(a, fills: ("": teal))
#e0

These two should look exactly the same with zero gaps. Note that there will be extra top and bottom insets, compared with the original mat.

Then add some dashed lines and fillings.

#let e1 = pavemat(
  a,
  pave: "dSDSDSLLAAWASSDD",
  fills: (
    "1-1": red.transparentize(80%),
    "1-2": blue.transparentize(80%),
    "3-0": green.transparentize(80%),
  ),
)
#e1

It is possible to customize stroke of path segments!

#let e2 = pavemat(
  a,
  pave: (
    path: "AA(paint: red, thickness: 2pt)WdD(paint: blue)Ww(thickness: 1pt, dash: 'dotted')AaS]Aw]W]D",
    from: "bottom-right",
  ),
  fills: maroon.transparentize(90%),
)
#e2

Turn `debug` on to see the hidden lines.

#let e3 = pavemat(
  a,
  pave: (
    path: "AA(paint: red, thickness: 2pt)WdD(paint: blue)Ww(thickness: 1pt, dash: 'dotted')AaS]Aw]W]D",
    from: "bottom-right",
  ),
  fills: maroon.transparentize(90%),
  debug: true,
)
#e3

With more paths, a default fill and a different delimiter.

#let e4 = pavemat(
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
  delim: "[",
)
#e4

You can also pass a ```typ math.mat``` to it instead of a `math.equation`.
If you don't like `WASD`, you can just overwrite it, but be careful of case-sensitivity!
Additionally, it will automatically inherit parameters of `math.mat`.

#let e5 = pavemat(
  math.mat(..range(5).map(i => range(5).map(j => i * 5 + j)), align: right),
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
  delim: none,
)
#e5
