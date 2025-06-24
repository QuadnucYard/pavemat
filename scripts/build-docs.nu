#!/usr/bin/env nu

# Build documentation website to docs/dist/

print "Cleaning previous build..."
mkdir docs/dist
rm -rf docs/dist/*

print "Building documentation PDFs..."
^typst c docs/manual.typ docs/dist/manual.pdf
^typst c docs/quick-reference.typ docs/dist/quick-reference.pdf
^typst c docs/tutorial.typ docs/dist/tutorial.pdf
^typst c examples/examples.typ docs/dist/examples.pdf

print "Copying website files..."
cp docs/template/index.html docs/dist/
cp docs/template/style.css docs/dist/

print "Copying example SVGs..."
cp examples/*.svg docs/dist/

print "Documentation website built in docs/dist/"
print "Files created:"
ls docs/dist/
