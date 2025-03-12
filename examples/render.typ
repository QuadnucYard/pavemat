#import "examples.typ" as examples

#let index = sys.inputs.at("example-index", default: "1")
#set page(width: auto, height: auto, margin: 0.5em)
#dictionary(examples).at("e" + index, default: none)
