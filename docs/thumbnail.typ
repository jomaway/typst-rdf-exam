#import "/src/lib.typ" as my-package: *

// #set page(fill: none)

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#set text(white) if theme == "dark"

#set text(size: 12pt, font: "Rubik", weight: 300, lang: "de")
#set par(spacing: 1.2em)

#cover-page(
  title: "1. Schulaufgabe",
  class: "ETV1",
  subject: "IT",
  date: datetime.today(),
  total-points: 30
)
