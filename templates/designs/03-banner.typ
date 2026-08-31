// 03 · Full-width colour banner header (name, headline, stat tiles), then two columns. Deep green.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#1b4332"); #let light = rgb("#d8f3dc")
#set page(paper: "us-letter", margin: 0pt)
#set text(font: ("Helvetica Neue", "Arial"), size: 8.8pt, fill: rgb("#1d1d1f"))
#set par(leading: 0.48em)
#let section(t) = block(above: 1.2em, below: 0.5em, text(size: 12pt, weight: 700, fill: accent, t))
#let role(r) = block(breakable: true, below: 0.3em)[#role-row(r, accent) #v(0.1em) #bullets(r.bullets, marker: [•], color: accent)]
#let stat(s) = box(width: 1fr, inset: 8pt, fill: white.transparentize(85%), radius: 4pt,
  align(center)[#text(size: 16pt, weight: 700, fill: white, s.at(0)) \ #text(size: 7.5pt, fill: light, upper(s.at(1)))])

#block(fill: accent, width: 100%, inset: (x: 28pt, y: 22pt))[
  #grid(columns: (1fr, auto), align: (left, right),
    [#text(size: 26pt, weight: 700, fill: white)[#d.name] \ #text(size: 11pt, fill: light, d.headline.join(" · "))],
    [#set text(fill: light, size: 8.4pt); #for c in d.contact [#contact-line(c, light, icon-fill: light) \ ]])
  #v(8pt)
  #grid(columns: (1fr,) * d.stats.len(), column-gutter: 8pt, ..d.stats.map(stat))
]
#block(inset: (x: 28pt, y: 14pt))[
  #grid(columns: (1fr, 30%), column-gutter: 22pt,
    [#text(fill: luma(70), d.summary)
     #section[Experience] #for r in d.experience { role(r); pills(r.tags, accent) }
     #section[Projects] #for r in d.projects { role(r) }],
    [#section[Education] #for e in d.education { edu-entry(e, accent) }
     #section[Skills] #for s in d.skills { skill-group(s, accent, marker: [•], color: accent) }
     #section[Awards] #bullets(d.awards, marker: [•], color: accent)
     #section[Publications] #d.publications
     #section[Languages] #d.languages])
]
