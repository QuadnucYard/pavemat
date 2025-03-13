#!/bin/sh

render_example() {
    index=$1
    typst c examples/render.typ "examples/example${index}.svg" --input "example-index=${index}"
}

render_example 1
render_example 2
render_example 4
render_example 5
