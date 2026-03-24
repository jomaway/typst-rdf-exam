root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual
doc:
  typst compile docs/manual.typ docs/manual.pdf
  typst compile docs/thumbnail.typ thumbnail.png
  magick thumbnail.png -resize 400 thumbnail.png

test case:
    @echo "Starting test {{case}}..."
    typst compile "tests/test-{{case}}.typ"
    @echo "Test {{case}} passed!"

pack:
  chase pack . @preview --overwrite
