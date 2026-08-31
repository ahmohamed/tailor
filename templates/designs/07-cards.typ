// 07 · Cards: each role on a soft rounded card with an icon badge; light grey canvas. Amber accent.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#d97706"); #let canvas = rgb("#f5f5f4"); #let ink = rgb("#1c1917")
#set page(paper: "us-letter", margin: (x: 0.5in, y: 0.45in), fill: canvas)
#set text(font: ("Avenir Next", "Helvetica Neue", "Arial"), size: 8.7pt, fill: ink)
#set par(leading: 0.47em)
#let section(t, ic) = block(above: 1.1em, below: 0.5em)[#icon(ic, fill: accent, size: 10pt) #h(6pt) #text(size: 12pt, weight: 700, t)]
#let card(body) = block(width: 100%, fill: white, radius: 6pt, inset: 10pt, below: 7pt, stroke: 0.5pt + luma(225), breakable: true, body)
#let role(r) = card[#role-row(r, accent) #v(0.1em) #bullets(r.bullets, marker: [•], color: accent) #pills(r.tags, accent, filled: true)]

#card[#grid(columns: (auto, 1fr, auto), column-gutter: 14pt, align: horizon,
  box(width: 46pt, height: 46pt, radius: 23pt, fill: accent, align(center + horizon, text(size: 20pt, weight: 800, fill: white, d.name.split(" ").map(w => w.first()).join()))),
  [#text(size: 22pt, weight: 800)[#d.name] \ #text(size: 10pt, fill: accent, weight: 600, d.headline.join(" · ")) \ #v(0.2em) #text(size: 8.4pt, fill: luma(80), d.summary)],
  [#set text(size: 8.2pt); #for c in d.contact [#contact-line(c, accent) \ ]])]
#grid(columns: (1fr, 31%), column-gutter: 8pt,
  [#section([Experience], "briefcase") #for r in d.experience { role(r) }
   #section([Projects], "rocket") #for r in d.projects { role(r) }],
  [#section([Education], "graduation") #card[#for e in d.education { edu-entry(e, accent) }]
   #section([Skills], "code") #card[#for s in d.skills { skill-group(s, accent, marker: [•], color: accent) }]
   #section([Awards], "award") #card[#bullets(d.awards, marker: [•], color: accent)]
   #section([Publications], "book") #card[#d.publications]
   #section([Languages], "language") #card[#d.languages]])
