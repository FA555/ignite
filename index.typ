#let config-dir = "config"
// #let data-dir = "data"
#let data-dir = sys.inputs.at("data-dir", default: "data")

#let serif-fonts = read(config-dir + "/serif-fonts.txt").split("\n")
#let sans-fonts = read(config-dir + "/sans-fonts.txt").split("\n")
#let font-size = 11pt

#set text(
  size: font-size,
  font: serif-fonts,
  lang: "zh",
  region: "cn",
)

#set page(
  flipped: true,
  margin: (top: 4%, bottom: 4%, left: 4%, right: 4%),
)

#show heading: set block(
  above: .95em,
  below: .65em,
)

#show heading.where(level: 1): it => {
  let foreground = red.darken(40%)
  let stroke = (paint: foreground, cap: "round", thickness: .75pt)
  set text(
    font: sans-fonts,
    fill: foreground,
  )
  grid(
    align: horizon,
    columns: 3,
    column-gutter: .5em,
    line(stroke: stroke, length: .5em),
    it,
    line(stroke: stroke, length: 100%),
  )
}

#let data-alphabetic = read(data-dir + "/index_alphabetic.txt").split("\n").filter(line => line.trim() != "").map(line => {
  let parts = line.split()
  (parts.slice(0, -2).join(" "), parts.at(-2), parts.at(-1))
})

#let initial = none

#columns(
  4,
  gutter: 3.5%,
  {
    for (i, entry) in data-alphabetic.enumerate() {
      let cur-initial = entry.at(-1).at(0)
      if cur-initial != initial {
        heading(bookmarked: false, numbering: none, cur-initial)
      }
      initial = cur-initial
      
      let (body, page-no, _) = entry
      
      grid(
        columns: (auto, 1fr, auto),
        column-gutter: .5em,
        align: (left + top, right + bottom),
        body,
        repeat(text(fill: gray)[.]),
        text(page-no),
      )
    }
  },
)

#pagebreak()

#let data-chapter = read(data-dir + "/index_unsorted.txt").split("\n").filter(line => line.trim() != "").map(line => {
  let parts = line.split()
  (parts.slice(0, -2).join(" "), parts.at(-2), parts.at(-1))
})

#columns(
  4,
  gutter: 3.5%,
  {
    for (i, entry) in data-chapter.enumerate() {
      let (body, page-no, is-heading) = entry
      
      if is-heading != "None" {
        heading(bookmarked: false, numbering: none, body)
      } else {
        grid(
          columns: (auto, 1fr, auto),
          column-gutter: .5em,
          align: (left + top, right + bottom),
          body,
          repeat(text(fill: gray)[.]),
          text(page-no),
        )
      }
    }
  },
)
