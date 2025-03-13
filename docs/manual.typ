#import "@preview/mantys:1.0.1": *
#import "../src/lib.typ": pavemat

#let show-module(name, ..tidy-args) = tidy-module(
  name,
  read("../src/" + name + ".typ"),
  // Some defaults you want to set
  legacy-parser: true,
  ..tidy-args.named(),
)

#show: mantys(
  abstract: [
    Pavemat provides a simple function `pavemat` for creating styled matrices with customizable paths, strokes, and fills. It allows users to define how paths should be drawn through the matrix, apply different strokes to these paths, and fill specific cells with various colors. This can be used for visualizing data structures and matrices, and creating custom grid layouts.
  ],

  examples-scope: (scope: (pavemat: pavemat)),

  ..toml("../typst.toml"),
)

= Syntax

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


=== Custom Direction Characters

If you prefer `UDLR` to `WASD`, you can customize control characters in through arguments. See usage.


== Position

A position string is formatted as `"{x}-{y}"` or `"[{x}-{y}]"`. Examples include `"0-1"`, `"top-left"`, `"bottom-2"`, and `"[2-right]"`.

- `{x}`: Can be an integer or the literal `top` or `bottom`.
- `{y}`: Can be an integer or the literal `left` or `right`.

In the `fills` parameter, position strings determine which cells to fill with the specified color. By default, a position string without brackets (`"{x}-{y}"`) fills the connected block of cells containing `(x, y)`. When enclosed in brackets (`"[{x}-{y}]"`), it only fills the specified single cell.

= API Reference

== pavemat

#show-module(
  "pavemat",
  show-outline: false,
  omit-private-parameters: true,
  sort-functions: false,
)
