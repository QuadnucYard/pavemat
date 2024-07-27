#import "@preview/mantys:0.1.4": *
#import "@preview/mantys:0.1.4": theme
#import "../src/lib.typ": pavemat

#show: mantys.with(
  name: "pavemat",
  title: [Pavemat],
  // subtitle: [A subtitle for the manual],
  // info: [A short descriptive text for the package.],
  authors: "QuadnucYard",
  license: "MIT",
  url: "https://github.com/QuadnucYard/pavemat",
  version: "0.1.0",
  date: "2024-7-27",
  abstract: [
    The pavemat is a versatile tool for creating styled matrices with custom paths, strokes, and fills. It allows users to define how paths should be drawn through the matrix, apply different strokes to these paths, and fill specific cells with various colors. This function is particularly useful for visualizing complex data structures, mathematical matrices, and creating custom grid layouts.
  ],

  examples-scope: (pavemat: pavemat),

  titlepage: titlepage.with(toc: false),
  index: none,
)

= Basics

== Pave string

A pave string defines paths through the matrix.
This string consists of directional characters that guide the path from one cell to another. It can also include styled segments and custom control characters for more advanced configurations.

=== Basic Directional Characters

A pave string primarily uses the following basic directional characters to move through the matrix:

- `W`, `w`: Move up
- `S`, `s`: Move down
- `A`, `a`: Move left
- `D`, `d`: Move right

If a lowercase letter is used, this segment will not be displayed.

=== Styled Segments

To apply styles to specific segments of the path, you can enclose the style specifications in parentheses. These styles, *which affect only the subsequent segment until the closing parenthesis or the end of the segment*, can include changes to stroke properties such as dash pattern, color, and thickness. The style is evaluated as dictionary and then passed to `grid.hline.stroke` and `grid.vline.stroke`. *Styles can be overlaid.*

*Examples:*

- Solid Stroke: ```typc "SS(dash: 'solid')DDD"```
- Colored Stroke: ```typc "SS(paint: red)DDD"```
- Thickness and Dash: ```typc `SS(thickness: 2pt, dash: "dotted")DDD`.text```

Single quotes (`'`) in the string will be simply replaced by double quotes (`"`), so there is no need to escape them.

In the example ```typc "SS(dash: 'solid')DDD"```, the path first moves down twice and then uses a solid stroke for the next segment that moves right three times.

The style has its scope, ended by a right bracket `]`. You can optionally add one `[` after style parenthesis `)`, which is just ignored.

*Examples:*

```typc
"AA(paint: red, thickness: 2pt)WdD(paint: blue)Ww(thickness: 1pt, dash: 'dotted')AaS]Aw]W]D"
```

*Explanations:*

- `AA`:
  - Moves left twice (`AA`).
- `(paint: red, thickness: 2pt)WdD`
  - The stroke is red and 2pt thick.
  - Moves up (`W`), then down (`d`, hidden), and right (`D`).
- `(paint: blue)Ww`:
  - The stroke changes to blue, while thickness is still 2pt.
  - Moves up (`W`) and up again(`w`, hidden).
- `(thickness: 1pt, dash: 'dotted')AaS]`:
  - The stroke changes to 1pt thick with a dotted pattern.
  - Moves left (`A`), left (`a`), and down (`S`).
  - When encountering `]`, the style resets to the previous state (in this case, blue stroke).


=== Custom Control Characters

If you prefer `UDLR` to `WASD`, you can customize control characters in through arguments. See usage.


== Position

A position string is formatted as `"{x}-{y}"` or `"[{x}-{y}]"`. Examples include `"0-1"`, `"top-left"`, `"bottom-2"`, and `"[2-right]"`.

- `{x}`: Can be an integer or the literal `top` or `bottom`.
- `{y}`: Can be an integer or the literal `left` or `right`.

In the `fills` parameter, position strings determine which cells to fill with the specified color. By default, a position string without brackets (`"{x}-{y}"`) fills the connected block of cells containing `(x, y)`. When enclosed in brackets (`"[{x}-{y}]"`), it only fills the specified single cell.

= Usage

#command(
  "pavemat",
  arg[eq],
  arg(pave: ()),
  arg(stroke: ()),
  arg(fills: (:)),
  arg(dir-chars: (:)),
  arg(display-style: true),
  arg(block: auto),
  arg(debug: false),
)[
  The pavemat function in Typst allows for the creation of styled and filled matrices with custom paths, strokes, and fills.

  #argument("eq", types: ("math.equation", "math.mat", "array"))[
    The input matrix expression to be styled. It can be a mathematical equation or a matrix. Specifically,

    - A ```typc math.equation```. It should contains only a `math.mat` as its body. Example: ```typ $mat(1, 2; 3, 4)$```. ```typc math.display``` in the equation is not supported yet.
    - A `math.mat`. Example: ```typc math.mat((1, 2), (3, 4))```.
    - A nested array. Example: ```typc ((1, 2), (3, 4))```.

    If a matrix type is given, pavemat will use its style, including `row-gap`, `column-gap` and `delim`.
  ]

  #argument("pave", types: ("string", "dictionary", "array"), default: ())[
    Describes the pavement lines. It accepts the following formats:

    - A path string like `"WASD"`.
    - A dictionary with fields: `path`, `from` (optional, default: ```typc "top-left"```), `stroke` (optional, default: empty). The path is a pave string.
    - An array whose item type is either string or dictionary described above.
  ]

  #argument("stroke", types: ("length", "color", "gradient", "pattern", "dictionary"))[
    The global stroke style applying to all segments. This argument will be passed to `cell.stroke`.

    Accepts anything can be use as stroke. Examples: ```typc blue + 1pt```, ```typc (dash: "dashed", thickness: 0.5pt)```.
  ]

  #argument("fills", types: ("color", "gradient", "pattern"))[
    Specifies the fill colors for specific cells. The key represents a position, and the value is the color passed to `cell.fill`. An empty key `""` is used for global fill.
  ]

  #argument("dir-chars", types: "dictionary", default: (:))[
    Controls whether the output is in display style. Its fields will override the default ```typc (up: "W", down: "S", left: "A", right: "D")```.

    Example: ```typc (up: "U", down: "D", left: "L", right: "R")```
  ]

  #argument("block", types: (auto, "bool"), default: auto)[
    Controls whether the output is block-style. If set to auto, it uses the block setting of the input equation.
  ]

  #argument("delim", types: (auto, "str"), default: auto)[
    The delimiter of the matrix. If set to auto, it uses the delimiter of the input matrix.
  ]

  #argument("display-style", types: "bool", default: true)[
    Controls whether the output is in display style. If set to `true`, the result will be granted a ```typc math.display(...)```.
  ]

  #argument("debug", types: ("bool"), default: false)[
    Enables debug mode to show hidden lines. If set to a non-boolean value, it defines the debug stroke style.
  ]

  Example:

  #example[```
    #pavemat(
      $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9; 10, 11, 12) $,
      pave: "dSDSDSLLAAWASSDD",
      fills: (
        "1-1": red.transparentize(80%),
        "1-2": blue.transparentize(80%),
        "3-0": green.transparentize(80%),
      ),
    )
    ```]
]
