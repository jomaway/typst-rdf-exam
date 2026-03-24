// import ttt-utils
#import "@preview/ttt-utils:0.2.0": assignments, components, grading, rubric as rubric_utils, helpers


/// Get the default rubric levels for a given count of levels. Only 2, 3 or 4 levels are supported.
#let get_rubric_levels(
  /// The number of levels. Must be between 2 and 5.
  /// -> int
  count
) = {
  assert.eq(type(count), int, message: "count must be of type int, found " + str(type(count)))
  assert(count >= 2 and count <= 5, message: "count must be between 2 and 5, found " + str(count))

  let levels = ("Garnicht erfüllt", "Vollständig erfüllt",)

  if count >= 3 {
    levels.insert(1, "Teilweise erfüllt")
  }

  if count >= 4 {
    levels.insert(1, "Ansatz erkennbar")
  }

  if count >= 5 {
    levels.insert(3, "Fast erfüllt")
  }

  levels

}

/// A wrapper around the rubric function from ttt-utils that adds some default behavior for the criteria and levels.
#let rubric(
  /// The criteria for the rubric, given as an array of strings.
  /// -> array
  criteria,
  /// The levelcount or levels for the rubric.
  /// -> int
  levels: 4,
  /// Additional arguments for the rubric function from ttt-utils.
  ..rest
) = {
  let levels = if type(levels) == int { get_rubric_levels(levels) } else { levels }
  criteria = if type(criteria) == array { ("Bewertungskriterium", ..criteria) } else { criteria }

  rubric_utils.rubric(criteria, levels: levels, ..rest)
}
