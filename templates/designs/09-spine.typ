// 09 · Spine: a narrow coloured spine on the left carrying the name rotated vertically; everything else in a wide single column with a right meta gutter. Plum.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#6d28d9")
#set page(paper: "us-letter", margin: 0pt)
#set text(font: ("Helvetica Neue", "Arial"), size: 8.8pt, fill: rgb("#1f1f1f"))
#set par(leading: 0.48em)
#let section(t) = block(above: 1.3em, below: 0.5em, text(size: 8pt, weight: 700, tracking: 0.18em, fill: accent, upper(t)))
#let role(r) = block(breakable: true, below: 0.6em, grid(columns: (1fr, 19%), column-gutter: 12pt,
  [#text(size: 10.5pt, weight: 700, r.title) #v(0.05em) #bullets(r.bullets, marker: [–]) #pills(r.tags, accent)],
  [#set par(justify: false); #text(size: 8pt, fill: accent, weight: 600, r.dates) \ #text(size: 8pt, fill: luma(100), r.org)]))

#grid(columns: (44pt, 1fr),
  block(fill: accent, width: 100%, height: 100%, align(center + bottom, pad(bottom: 26pt, rotate(-90deg, reflow: true, text(size: 28pt, weight: 800, fill: white, tracking: 0.02em, d.name))))),
  block(inset: (x: 26pt, y: 26pt))[
    #grid(columns: (1fr, auto), align: (left, right),
      [#text(size: 12pt, fill: accent, weight: 600, d.headline.join("  ·  ")) \ #v(0.3em) #text(size: 9pt, fill: luma(60), d.summary)],
      [#set text(size: 8.2pt); #for c in d.contact [#contact-line(c, accent) \ ]])
    #v(0.4em) #line(length: 100%, stroke: 0.5pt + luma(200))
    #section[Experience] #for r in d.experience { role(r) }
    #section[Projects] #for r in d.projects { role(r) }
    #line(length: 100%, stroke: 0.5pt + luma(200))
    #grid(columns: (1fr, 1fr, 1fr), column-gutter: 16pt,
      [#section[Education] #for e in d.education { edu-entry(e, accent) }],
      [#section[Skills] #for s in d.skills [#text(weight: 700, s.at(0)) \ #text(size: 8.2pt, s.at(1).join(" · ")) #v(0.3em)]],
      [#section[Awards] #bullets(d.awards) #section[Publications] #text(size: 8.2pt, d.publications) #section[Languages] #d.languages])])
