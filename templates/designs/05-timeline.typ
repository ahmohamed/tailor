// 05 · Timeline: a vertical rail with dots per role in the main column; compact identity strip on top. Indigo.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#4338ca"); #let rail = accent.lighten(60%)
#set page(paper: "us-letter", margin: (x: 0.55in, y: 0.5in))
#set text(font: ("Helvetica Neue", "Arial"), size: 8.8pt, fill: rgb("#18181b"))
#set par(leading: 0.48em)
#let section(t) = block(above: 1.2em, below: 0.6em, text(size: 13pt, weight: 700, fill: accent, t))
#let tl-role(r, last: false) = grid(columns: (14pt, 1fr), column-gutter: 6pt,
  // rail cell: dot on a continuous rail (the rail is drawn by the grid cell's left stroke)
  grid.cell(stroke: if last { none } else { (right: 1.2pt + rail) }, inset: (right: 5.5pt), align(right + top, move(dx: 4.2pt, circle(radius: 3.5pt, fill: accent, stroke: 2pt + white)))),
  block(below: 0.9em)[#text(size: 8pt, fill: accent, weight: 600, r.dates) \
    #text(size: 10pt, weight: 700, r.title) #h(5pt) #text(size: 8.4pt, fill: luma(100), r.org) #v(0.05em)
    #bullets(r.bullets, marker: [–]) #pills(r.tags, accent, filled: true)])

#grid(columns: (1fr, auto), align: (left, right),
  [#text(size: 26pt, weight: 800, fill: accent)[#d.name] \ #text(size: 11pt, fill: luma(90), d.headline.join(" · "))],
  [#set text(size: 8.4pt); #for c in d.contact [#contact-line(c, accent) \ ]])
#v(0.3em) #line(length: 100%, stroke: 2pt + accent) #v(0.3em)
#grid(columns: (1fr, 30%), column-gutter: 20pt,
  [#text(fill: luma(70), d.summary)
   #section[Experience]
   #for (i, r) in d.experience.enumerate() { tl-role(r, last: i == d.experience.len() - 1) }
   #section[Projects]
   #for (i, r) in d.projects.enumerate() { tl-role(r, last: i == d.projects.len() - 1) }],
  [#grid(columns: (1fr,) * 2, column-gutter: 6pt, row-gutter: 6pt, ..d.stats.map(s => box(width: 100%, inset: 6pt, fill: accent.lighten(90%), radius: 4pt, align(center)[#text(size: 14pt, weight: 800, fill: accent, s.at(0)) \ #text(size: 7pt, fill: luma(90), s.at(1))])))
   #section[Education] #for e in d.education { edu-entry(e, accent) }
   #section[Skills] #for s in d.skills { skill-group(s, accent, marker: [–]) }
   #section[Awards] #bullets(d.awards)
   #section[Publications] #d.publications
   #section[Languages] #d.languages])
