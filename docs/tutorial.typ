#import "@preview/pavemat:0.2.0": pavemat
#import "utils.typ": render-examples

#let matrix = $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) $

#show: render-examples.with(scope: (pavemat: pavemat, matrix: matrix))

= Getting Started with Pavemat

Learn to create styled matrices with paths and highlights for mathematical concepts, data structures, and algorithms.

== Step 1: Your First Pavemat

Let's start with a simple 3×3 matrix:

```typst
#import "@preview/pavemat:0.2.0": pavemat

#let matrix = $ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) $
#pavemat(matrix)
```

This creates a basic matrix without styling—identical to a regular Typst matrix since we haven't added paths or fills.

== Step 2: Adding Your First Path

Add a simple path using directional characters:

```typst
#pavemat(
  matrix,
  pave: "DD"  // Move right twice
)
```

The path `"DD"` draws a horizontal line from the top-left corner, moving right two steps.

== Step 3: Understanding Direction Characters

Pavemat uses WASD gaming convention by default:
- `W` = Up ⬆️
- `A` = Left ⬅️
- `S` = Down ⬇️
- `D` = Right ➡️

Try different path patterns:

```typst
// L-shaped path (right then down)
#pavemat(matrix, pave: "DDSS")
```

```typst
// Complete border around the matrix
#pavemat(matrix, pave: "DDSSAAWW")
```

```typst
// Diagonal-like steps
#pavemat(matrix, pave: "DSDS")
```

== Step 4: Adding Cell Highlights

Add color to specific cells using position strings:

```typst
#pavemat(
  matrix,
  pave: "DSDS",
  fills: (
    "0-0": red.transparentize(80%),     // Top-left cell
    "1-1": blue.transparentize(80%),    // Center cell
    "2-2": green.transparentize(80%)    // Bottom-right cell
  )
)
```

*Note*: Position strings like `"0-0"` use (row, column) coordinates starting from 0.

== Step 5: Understanding Fill Types

There are two types of fills:
- `"x-y"`: Flood fill (fills connected regions)
- `"[x-y]"`: Single cell fill (fills only that specific cell)

```typst
#pavemat(
  matrix,
  pave: "DDSS",  // Creates barriers
  fills: (
    "0-0": red.transparentize(80%),      // Flood fill from top-left
    "[2-2]": blue.transparentize(80%),   // Only the bottom-right cell
  )
)
```

Red fills the entire connected region; blue fills only the single specified cell.

== Step 6: Styling Your Paths

Make paths more visually appealing:

```typst
#pavemat(
  matrix,
  pave: "DSDS",
  stroke: red + 2pt,  // Red color, 2pt thickness
  fills: ("1-1": yellow.transparentize(80%))
)
```

== Step 7: Multiple Paths with Different Styles

Add multiple paths, each with its own style and starting position:

```typst
#pavemat(
  matrix,
  pave: (
    (path: "DD", stroke: red + 2pt),                         // Horizontal red line
    (path: "SS", from: "top-right", stroke: blue + 2pt),     // Vertical blue line
    (path: "AA", from: "bottom-right", stroke: green + 2pt)  // Horizontal green line
  )
)
```

== Step 8: Using Starting Positions

Paths start from top-left by default. Specify different starting points using named positions or coordinates:

```typst
#pavemat(
  matrix,
  pave: (
    (path: "DDSS", from: "top-left", stroke: red + 1pt),     // From corner
    (path: "WASD", from: (1, 1), stroke: blue + 1pt)         // From center grid point
  )
)
```

*Important*: The `from` parameter uses grid coordinates (intersection points), not cell coordinates. For a 3×3 matrix, grid coordinates range from (0,0) to (3,3).

== Step 9: Advanced Styling Within Paths

Change styles mid-path using inline style specifications:

```typst
#pavemat(
  matrix,
  pave: "D(paint: red, thickness: 3pt)D(paint: blue, dash: 'dotted')SS",
  fills: ("": gray.transparentize(95%))
)
```

This creates a path where the first segment is thick red, the second is dotted blue, with dotted style continuing.
