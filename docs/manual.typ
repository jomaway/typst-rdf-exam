#import "@preview/tidy:0.4.3"
#import "/src/lib.typ": cover-page

// extract version from typst.toml package file.
#let pkg-data = toml("/typst.toml").package
#let version = pkg-data.at("version")
#let authors = pkg-data.at("authors").first()
#let import_statement = raw(block: true, lang: "typ", "#import \"@preview/gentle-clues:" + version +"\": *")


#set document(author: "jomaway", title: "Manual for the rdf-exam package")
#set page(
  "a4",
  margin: 2cm,
  header: {
    set text(luma(120))
    align(end)[`rdf-exam` manual]
  },
  numbering: "1/1"
)
#show link: set text(blue)

#page(
  header: none,
  footer: {
    // Footer message: Default Good luck
    set align(center)
    text(10pt, weight: "semibold")[
      Viel Erfolg #emoji.leaf.clover.four
    ]
  },
  // foreground: place(top + end, dx: -3cm, box(height: 2cm, inset: 1em, fill: blue.darken(20%), image("/src/assets/rdf.svg"), stroke: 0pt)),
  {
    grid(
      columns: 1fr,
      rows: (2fr, 1fr, 1fr),
      align: horizon,
      {
        set text(22pt, font: "Rubik", weight: 300)
        set align(center)

        let logo = box(height: 2cm, image("/src/assets/rdf.svg"))
        if logo != none { place(top + end, box(height: 5cm, logo)) }

        grid(
          align: center,
          row-gutter: 1em,
          text(32pt, weight: 600)[Manual],
          [for the `rdf-exam` package],
          box(width: 85%, text(16pt)[
            `rdf-exam` uses #link("https://typst.app/universe/package/ttt-utils", `ttt-utils`) under the hood. \
            Please refer to the docs of `ttt-utils` about how to structure assignments and questions.])
        )
      },
      grid(
        columns: (1fr, auto),
        row-gutter: 1cm,
        {
          set text(18pt)
          grid(
            columns: (auto, 6cm),
            align: (end + horizon, start + horizon),
            stroke: (x, y) => if (1 == x) { (bottom: 0.5pt) },
            inset: (x: 2pt, y: 5pt),
            row-gutter: 1em,
            column-gutter: 5pt,
            smallcaps("Name:"), `rdf-exam`,
            smallcaps("Version:"), raw(version),
            smallcaps("Authors:"), raw(authors.split(" ").first()),
            smallcaps("License:"), `MIT`
          )
        },
        [
          *Note:*
          #rect(width: 3cm, height: 3cm)[#align(center + horizon, text(32pt, weight: 700, red, "1"))
          ]
        ],
      ),
      outline(depth: 2)
    )
  },
)
#counter(page).update(1)


#let docs_exam = tidy.parse-module(read("/src/exam.typ"), name: "Exam")
#let docs_cover = tidy.parse-module(read("/src/cover.typ"), name: "Cover")
#let docs_points = tidy.parse-module(read("/src/points.typ"), name: "Points")

#tidy.show-module(docs_exam)

#pagebreak()
#tidy.show-module(docs_cover)

#pagebreak()
#tidy.show-module(docs_points)
