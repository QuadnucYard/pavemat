set shell := ["nu", "-c"]

export TYPST_ROOT := "."


default:
  @just --list

doc:
  typst c docs/manual.typ

test:
  tt run

render-examples:
  typst c examples/examples.typ -f pdf
  @just _render-example 1
  @just _render-example 2
  @just _render-example 4
  @just _render-example 5

_render-example index:
  typst c examples/render.typ "examples/example{{index}}.svg" --input "example-index={{index}}"
