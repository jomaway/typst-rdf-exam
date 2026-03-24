#import "utils.typ": grading, helpers

#let get-total-points() = context grading.get_points().sum(default: 0)

/// Show a box with the total points
#let point-sum-box(
  /// The total points. If `auto` it will be auto generated.
  /// -> int | auto
  total-points: auto
) = {
  box(stroke: 1pt, inset: 0.8em, radius: 3pt)[
    #set align(bottom)
    #stack(
      dir:ltr,
      spacing: 0.5em,
      box[#text(1.4em, sym.sum) :],
      line(stroke: 0.5pt), "/",
      [#helpers.if-auto-then(total-points, get-total-points()) #smallcaps[PTs]]
    )
  ]
}


/// Show a table with point distribution
#let point-table(
  /// A list of names for each assignment.
  /// The default is just increasing numbers.
  /// -> list | auto
  assignment-names: auto
) = {
  context {
    let points = grading.get_points()

    let header-names = if assignment-names == auto {
      points.enumerate().map(((i,_)) => [#{i+1}])
    } else {
      assert(type(assignment-names) == array, message: "must be of type auto or array, found " + str(type(assignment-names)))
      assert(assignment-names.len() == points.len(), message: "number of names must match number of assignments")
      assignment-names
    }
    box(radius: 5pt, clip: true, stroke: 1pt,
      table(
        align: (col, _) => if (col == 0) { end } else { center },
        inset: (x: 1em, y:0.6em),
        fill: (x,y) =>  if (x == 0 or y == 0) { luma(230) },
        rows: (auto, auto, 1cm),
        columns: (auto, ..((auto,) * points.len()), auto),
        "Aufgabe", ..header-names, "Gesamt",
        "Punkte", ..points.map(str), get-total-points(),
        "Erreicht",
      )
    )
  }
}
