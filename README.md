# Pavemat

![version](https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2FQuadnucYard%2Fpavemat%2Frefs%2Fheads%2Fmain%2Ftypst.toml&query=%24.package.version&label=version&color=green)
[![Universe](https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Fpavemat&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%2339cccc)](https://typst.app/universe/package/pavemat)
[![Repo](https://img.shields.io/badge/GitHub-repo-blue)](https://github.com/QuadnucYard/pavemat)

<div align="center">
  <img src="./examples/logo.svg"/>
  <p><strong> <u>pave</u>ment + <u>mat</u>rix </strong></p>
</div>

## Introduction

Pavemat provides a simple function `pavemat` for creating styled matrices with customizable paths, strokes, and fills. It allows users to define how paths should be drawn through the matrix, apply different strokes to these paths, and fill specific cells with various colors. This can be used for visualizing data structures and matrices, and creating custom grid layouts.

## Key Features

- **Custom Paths**: Easily define matrix paths using directional characters.
- **Stroke Styles**: Customize the appearance of path lines with different dash patterns, thicknesses, and colors.
- **Cell Fills**: Highlight specific cells (even connected blocks) with chosen colors.
- **Custom Direction Characters**: Override default directional characters when needed.
- **Debug Mode**: Visualize hidden lines to assist with troubleshooting.
- **Style Inheritance**: Contextual styles (e.g., gaps and alignment) are automatically applied to pavemat, though you can explicitly set them if desired.

> [!NOTE]
> Pavemat uses a slightly different layout model than `math.mat` when handling gaps. Extra row gaps are added as cell insets above the first row and below the last row. On the other hand, this meets the needs of cell filling.

## How it works

Since `math.mat` lacks support for cell fills and strokes, pavemat rebuilds the layout using a grid. Each matrix element becomes an individual cell with its own fill, and delimiters are provided by a `math.vec` wrapper.

To prevent overlapping just as `math.mat` and make elements in each row align with baselines, pavemat measures the bounds of each row, inserts zero-width boxes to adjust text top edges, and sets row heights based on bounding box dimensions. This approach works reliably in many cases, though it may not be perfect for every display style.

## Examples

The logo example:

```typst
#import "@preview/pavemat:0.1.0": pavemat

#set math.mat(row-gap: 0.25em, column-gap: 0.1em)
#set text(size: 2em)

#pavemat(
  pave: (
    "SDS(dash: 'solid')DDD]WW",
    (path: "sdDDD", stroke: aqua.darken(30%))
  ),
  stroke: (dash: "dashed", thickness: 1pt, paint: yellow),
  fills: (
    "0-0": green.transparentize(80%),
    "1-1": blue.transparentize(80%),
    "[0-0]": green.transparentize(60%),
    "[1-1]": blue.transparentize(60%),
  ),
  delim: "[",
)[$mat(P, a, v, e; "", m, a, t)$]
```

More examples can be found in `examples/examples.typ`:

![](./examples/example1.svg)
![](./examples/example2.svg)
![](./examples/example4.svg)
![](./examples/example5.svg)

## License

This project is licensed under the terms of the MIT License. See the [LICENSE](./LICENSE) file for details.
