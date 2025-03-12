/// Used for development.

#import "../src/lib.typ": pavemat

#show math.equation: set text(font: "Cambria Math")
#set math.mat(gap: 0pt, delim: none)

#let bbox = box.with(stroke: red + 0.2pt)
#let a = $
  mat(#bbox[-], a(), j; j, #bbox[j()], j(); x, #bbox[j()], a; j(), \_, #bbox[j])
$

$ display(#a) $

#let b = pavemat(a, display-style: true, block: true, fills: ("": teal))
#b
#context {
  let size0 = measure($ display(#a) $)
  let size1 = measure(b)
  [#size0\ #size1]
  assert(size0 == size1, message: "The two should look exactly the same")
}
