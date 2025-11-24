#import "@preview/ttt-utils:0.1.4": assignments, helpers
#import "cover.typ": cover-page
#import "snippets.typ": copyright-snippet, page-counter-snippet, update-last-page-counter

/// Defines the layout and metadata for an exam.
#let exam(
  /// The exam and document title.
  /// -> string | none
  title: "Leistungsnachweis",

  /// Optional subtitle for the exam.
  /// -> string | content | none
  subtitle: none,

  /// Date of the exam.
  /// -> string | datetime | content | none
  date: none,

  /// Class name or code.
  /// -> string | none
  class: none,

  /// Subject of the exam.
  /// -> string | none
  subject: none,

  /// Author(s) of the exam.
  /// -> string
  authors: "RDF",

  /// Whether to include a cover page.
  /// -> boolean
  cover: true,

  /// Total points. If `auto` it get's auto generated. This is mostly what you want.
  /// -> int | auto
  total-points: auto,

  /// The exam content body.
  /// -> content
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  // set page properties
  set page(
    margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
    footer: {
      copyright-snippet(year: auto, authors: authors)
      h(1fr)
      page-counter-snippet()
    },
    header: context if counter(page).get().first() > 1 {
      align(end)[
        #set text(luma(100))
        #title #if (subject != none) [\- #subject]
      ]
    },
  )
  // default settings
  set text(size: 12pt, font: "Rubik", weight: 300, lang: "de")
  set par(spacing: 1.2em)
  if "solution" in sys.inputs.keys() {
    assignments.set-solution-mode(helpers.bool-input("solution"))
  }


  // metadata (label needs content so we wrap inside a block)
  [
    #metadata( (
      title: title,
      subtitle: subtitle,
      class: class,
      subject: subject,
      date: date,
    )) <rdf-exam-data>
  ]

  // cover
  if (cover) {
    cover-page(
      total-points: total-points
    )
  }

  // Content-Body
  body
  update-last-page-counter()
}


/// A utility function to create an appendix.
/// The page count is not included in the exam.
#let appendix(
  /// The appendix title. If `auto`, uses "Anhang".
  /// -> string | auto
  title: auto,
  /// Additional arguments for page setup.
  /// -> arguments
  ..args,
  /// The appendix body content.
  /// -> content
  body,
) = [
  #update-last-page-counter()
  #set page(margin: 2cm, footer: auto, header: none, numbering: "[A]", ..args.named())
  #context {
    if query(selector(<appendix>).before(here())).len() == 0 {
      counter(page).update(1)
    }
  }
  #metadata((appendix: true)) <appendix>
  #helpers.if-auto-then(title, heading("Anhang"))

  #body
]
