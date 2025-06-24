#!/usr/bin/env nu

# Package the library
# Use out/ as the default target directory, or use the first argument if provided

def main [target_dir: string = "out"] {
    print $"Packaging to ($target_dir)..."

    # If the target directory exists, remove its contents; otherwise, create it
    if ($target_dir | path exists) {
        rm -rf $"($target_dir)/*"
    } else {
        mkdir $target_dir
    }

    # Copy files and directories to the target directory
    mkdir $"($target_dir)/examples"

    try { cp examples/*.svg $"($target_dir)/examples/" } catch { print "No SVG files to copy" }
    try { cp -r src $target_dir } catch { print "No src directory to copy" }
    try { cp LICENSE $target_dir } catch { print "No LICENSE file to copy" }
    try { cp README.md $target_dir } catch { print "No README.md file to copy" }
    try { cp typst.toml $target_dir } catch { print "No typst.toml file to copy" }

    print $"Packaging complete. Files copied to ($target_dir)/"
    print "Package contents:"
    ls $target_dir
}
