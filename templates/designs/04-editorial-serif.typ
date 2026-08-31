// 04 · Editorial: single column, serif display, hairline rules, small-caps labels. Academic and calm.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#7a1f1f"); #let serif = ("Georgia", "Times New Roman"); #let sans = ("Helvetica Neue", "Arial")
#set page(paper: "us-letter", margin: (x: 0.75in, y: 0.6in))
#set text(font: sans, size: 8.8pt, fill: rgb("#1a1a1a"))
#set par(justify: true, leading: 0.5em)
#let section(t) = block(above: 1.3em, below: 0.6em)[#line(length: 100%, stroke: 0.4pt) #v(0.2em) #text(font: serif, size: 13pt, style: "italic", fill: accent, t)]
#let role(r) = block(breakable: true, below: 0.5em)[
  #grid(columns: (1fr, auto), [#text(font: serif, size: 10.5pt, weight: 700, r.title) #h(6pt) #text(fill: luma(90), r.org)], text(size: 8pt, fill: luma(110), smallcaps(r.dates)))
  #v(0.05em) #bullets(r.bullets, marker: [·], color: accent)
  #if r.tags.len() > 0 { text(size: 7.8pt, fill: accent, tracking: 0.05em, upper(r.tags.join("   ·   "))) }]

#align(center)[#text(font: serif, size: 30pt, weight: 400)[#d.name] \ #v(0.1em)
  #text(size: 9.5pt, tracking: 0.15em, fill: accent, upper(d.headline.join("   ·   "))) \ #v(0.4em)
  #text(size: 8.4pt, fill: luma(80), d.contact.map(c => [#icon(c.icon, size: 8pt, fill: accent) #h(3pt) #c.text]).join([ #h(10pt) ]))]
#v(0.4em)
#text(font: serif, size: 10pt, style: "italic", fill: luma(60), d.summary)
#section[Experience] #for r in d.experience { role(r) }
#section[Projects] #for r in d.projects { role(r) }
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 18pt,
  [#section[Education] #for e in d.education { edu-entry(e, accent) }],
  [#section[Skills] #for s in d.skills [#text(weight: 700, s.at(0)): #text(size: 8.4pt, s.at(1).join(", ")) #v(0.3em)]],
  [#section[Awards] #bullets(d.awards, marker: [·], color: accent) #v(0.4em) #text(size: 8.2pt, d.publications) \ #v(0.3em) #text(size: 8.2pt)[Languages: #d.languages]])
