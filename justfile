set shell := ["nu", "-c"]

export TYPST_ROOT := justfile_directory()


default:
  @just --list

# Build documentation website to docs/dist/
build-docs:
  nu scripts/build-docs.nu

[working-directory: 'docs/dist']
preview-docs:
  bunx serve

test:
  tt run --no-fail-fast

# package the library into the specified destination folder
package target="out":
  nu scripts/package.nu {{target}}
