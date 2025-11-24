#let default-counter-name = "last-page-number"

#let update-last-page-counter(
  /// The name of the counter to update. Defaults to "last-page-number".
  counter-name: default-counter-name
) = context {
  let last-page-number = counter(counter-name)
  if last-page-number.get() == (0,) {
    last-page-number.update(counter(page).get())
  }
}

#let page-counter-snippet(
  /// The name of the counter to display. Defaults to "last-page-number".
  counter-name: default-counter-name
) = context [#counter(page).display("1") /  #counter(counter-name).final().at(0)]


#let copyright-snippet(
  /// The year to display. If `auto`, uses the current year.
  year: auto,
  /// The authors to display.
  authors: none
) = {
  // Copyright symbol
  sym.copyright
  // year
  if (year == auto) {
    datetime.today().display(" [year] ")
  } else {
    year
  }
  // Authors
  authors
}
