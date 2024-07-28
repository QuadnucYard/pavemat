#import "../src/lib.typ": pavemat

#let logo = {
  set math.mat(row-gap: 0.25em, column-gap: 0.1em)
  set text(size: 2em)

  pavemat(
    pave: ("SDS(dash: 'solid')DDD]WW", (path: "sdDDD", stroke: aqua.darken(30%))),
    fills: (
      "0-0": green.transparentize(80%),
      "1-1": blue.transparentize(80%),
      "[0-0]": green.transparentize(60%),
      "[1-1]": blue.transparentize(60%),
    ),
    delim: "["
  )[$mat(P, a, v, e; "", m, a, t)$]
}


#set page(width: 104pt, height: 70pt, fill: white)
#logo
