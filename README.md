# The `rdf-exam` Package
<div align="center">Version 0.1.0</div>

This is a [typst](https://typst.app/home) template for creating consistent looking exams.
The RDF logo can be replaced by your schools/institution logo.

`rdf-exam` uses [`ttt-utils`](https://typst.app/universe/package/ttt-utils) under the hood. Please refer to the docs of `ttt-utils` about how to structure assignments and questions.

## Getting Started

To create an exam you need to `import` the package and init it with the `show` rule.

```typ
#import "@preview/rdf-exam:0.1.0": *

#show: exam.with(
  title: "1. Exam",
)
```

## Usage

There are a few arguments which you can set for an exam.
If you don't need a full cover page you can disable it. Instead you can use the `header-block()` function for a small header. It uses the metadata which you set on the exam by default.

```typ
#import "@preview/rdf-exam:0.1.0": *

#show: exam.with(
  title: "1. Exam",
  subject: "IT",
  class: "10B",
  authors: "unknown",
  date: datetime.today(),
  cover: false // Disable the default cover
)

// create a custom cover where you overwrite the logo
#header-block()

#assignment[
  Aufgabe

  #question(points: 2)[Was ist $1+1$]
  #question(points: 3)[Was ist größer als das?]
]

```


### Customizing

You can replace the RDF logo with your own logo by disabling the default cover and adding a `cover-page` where you set the logo. Same works with the `header-block` If you don't plan to use `ttt-utils` assignments and questions you can still use the cover by adding a custom value for the total points of your exam.

```typ
#import "@preview/rdf-exam:0.1.0": *

#show: exam.with(
  title: "1. Exam",,
  cover: false // Disable the default cover
)

// create a custom cover where you overwrite the logo
#cover-page(
  logo: stack(
    circle(fill: blue),
    rect(width: 30pt, fill: red),
    line(stroke: 4pt+ green, length: 3cm)
  )
  total-points: 100
)
```
