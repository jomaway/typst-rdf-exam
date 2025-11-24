#import "@preview/ttt-utils:0.1.4": assignments, helpers
#import "points.typ": *

#let get-meta-field(name) = context {
  let data = query(<rdf-exam-data>).first(default: none)
  let field = if data != none { data.value.at(name, default: none) } else { none }

  if type(field) == datetime { field.display("[day].[month].[year]") } else { field }
}

#let cover-page(
  /// The logo to display on the cover page.
  logo: box(height: 2cm, image("assets/rdf.svg")),

  /// The main title of the exam.
  title: auto,

  /// Optional subtitle for the exam.
  subtitle: auto,

  /// The class name or code.
  class: auto,

  /// The subject of the exam.
  subject: auto,

  /// The date of the exam.
  date: auto,

  /// The total amount of achivable points
  total-points: auto,
) = {
  page(
    header: none,
    footer: {
      // Footer message: Default Good luck
      set align(center)
      text(10pt, weight: "semibold")[
        Viel Erfolg #emoji.leaf.clover.four
      ]
    },
    {
      // Extract date string.
      date = if type(date) == datetime { date.display("[day].[month].[year]") } else { date }

      grid(
        columns: 1fr,
        rows: (2fr, 1fr, 1fr),
        align: horizon,
        {
          set text(22pt)
          set align(center)

          if logo != none { place(top + end, box(height: 5cm, logo)) }

          grid(
            align: center,
            row-gutter: 1em,
            text(22pt, weight: 500, helpers.if-auto-then(title, get-meta-field("title"))),
            helpers.if-auto-then(subtitle, get-meta-field("subtitle")),
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
              smallcaps("Name:"), context if assignments.is-solution-mode() { text(red, "Lösung") },
              smallcaps("Klasse:"), helpers.if-auto-then(class, get-meta-field("class")),
              smallcaps( "Fach:"), helpers.if-auto-then(subject, get-meta-field("subject")),
              smallcaps("Datum:"), helpers.if-auto-then(date, get-meta-field("date"))
            )
          },
          [
            *Note:*
            #rect(width: 3cm, height: 3cm)[#context if assignments.is-solution-mode() {
              align(center + horizon, text(32pt, weight: 700, red, "X"))
            }]
          ],
        ),
        align(end, block[
          #set align(start)
          *Punkte:* \
          #point-sum-box(total-points: total-points)
        ])
      )
    },
  )
  counter(page).update(1)
}


#let header-block(
  /// The logo to display on the cover page.
  logo: box(height: 2cm, image("assets/rdf.svg")),

  /// The main title of the exam.
  title: auto,

  /// Optional subtitle for the exam.
  subtitle: auto,

  /// The class name or code.
  class: auto,

  /// The subject of the exam.
  subject: auto,

  /// The date of the exam.
  date: auto,

  /// The total amount of achivable points
  total-points: auto,
) = {
  date = if type(date) == datetime { date.display("[day].[month].[year]") } else { date }

  table(
    columns: (3fr, 5fr, 35mm),
    rows: (25mm, 10mm),
    inset: 0.7em,
    table.cell(align: horizon)[
      #set par(leading: 1em)
      #smallcaps("Klasse:") #helpers.if-auto-then(class, get-meta-field("class")) \
      #smallcaps("Fach:") #helpers.if-auto-then(subject, get-meta-field("subject")) \
      #smallcaps("Datum:") #helpers.if-auto-then(date, get-meta-field("date"))
    ],
    table.cell(align: center + horizon)[

      #if logo != none {
        context {
          let size = measure(box(height: 2cm, logo))
          if (size.width * 0.4 > size.height) {
            grid(
              align: center,
              rows: 1fr,
              row-gutter: (8pt, 4pt),
              box(height: 0.7cm, logo),
              text(16pt, weight: 500, title),
              if subtitle != none { subtitle },
            )
          } else {
            grid(
              columns: 2,
              column-gutter: 12pt,
              align: horizon,
              box(height: 2cm, width: calc.min(size.width, 2cm), logo),
              {
                text(16pt, strong(delta: 200, helpers.if-auto-then(title, get-meta-field("title"))))
                linebreak()
                helpers.if-auto-then(subtitle, get-meta-field("subtitle"))
              },
            )
          }
        }
      } else {
        text(16pt, weight: 500, helpers.if-auto-then(title, get-meta-field("title")))
        linebreak()
        helpers.if-auto-then(subtitle, get-meta-field("subtitle"))
      }
    ],
    table.cell(rowspan: 2)[#align(top + start)[#smallcaps(
        "Note:",
      )] #context if assignments.is-solution-mode() { align(center + horizon, text(32pt, weight: 700, red, "X")) }],
    table.cell(colspan: 2)[#smallcaps("Name:") #context if assignments.is-solution-mode() {
        text(red, "Lösung")
      }],
  )
}
