#!/usr/bin/env nu

# Render example SVGs

def render_example [index: int] {
    ^typst c examples/render.typ $"examples/example($index).svg" --input $"example-index=($index)"
}

print "Rendering examples..."
render_example 1
render_example 2
render_example 4
render_example 5
print "Examples rendered successfully!"
