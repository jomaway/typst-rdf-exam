root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual
doc:
  typst-v14 compile docs/manual.typ docs/manual.pdf
  typst-v14 compile docs/thumbnail.typ thumbnail.png
  magick thumbnail.png -resize 400 thumbnail.png

pack:
  chase pack . @preview --overwrite
