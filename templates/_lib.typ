// Shared building blocks for designs. Each design sets its own palette/fonts and composes these.
#import "_icons.typ": icon

#let pill(t, accent, filled: false, size: 8pt) = box(inset: (x: 5pt, y: 2.5pt), radius: 3pt,
  stroke: if filled { none } else { 0.7pt + accent },
  fill: if filled { accent.lighten(85%) } else { none },
  text(size: size, fill: if filled { accent.darken(20%) } else { black }, t))
#let pills(ts, accent, ..args) = if ts.len() > 0 { block(above: 0.45em, below: 0.8em, ts.map(t => pill(t, accent, ..args)).join(h(4pt))) }

#let bullets(items, marker: [–], color: luma(90), spacing: 0.42em) = {
  set list(marker: text(fill: color, marker), indent: 0pt, body-indent: 0.45em, spacing: spacing)
  list(..items)
}

// title / org / dates on one line, dates right-aligned
#let role-row(r, accent, org-size: 8.4pt, date-fill: luma(90)) = grid(
  columns: (auto, 1fr, auto), column-gutter: 7pt, align: (left, left, right),
  text(weight: 700, r.title), text(size: org-size, r.org), text(size: 8pt, fill: date-fill, r.dates))

#let contact-line(c, accent, size: 8.6pt, icon-fill: none) = {
  let body = text(size: size, c.text)
  [#icon(c.icon, size: size, fill: if icon-fill == none { accent } else { icon-fill }) #h(5pt) #if c.url != none { link(c.url, body) } else { body }]
}

#let edu-entry(e, accent, date-fill: luma(90)) = block(below: 0.5em)[
  #text(weight: 600, e.at(0)) #h(3pt) #text(size: 8pt, fill: date-fill, e.at(2)) \ #text(size: 8.4pt, e.at(1))
]
#let skill-group(s, accent, ..lst) = block(below: 0.55em)[#text(weight: 700, s.at(0)) #v(-0.25em) #bullets(s.at(1), ..lst)]
