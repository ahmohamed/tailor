// 01 · Sidebar left: grey identity column, blue ruled sections, tag pills. The classic.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#2f5f8f"); #let muted = luma(90)
#set page(paper: "us-letter", margin: 0pt)
#set text(font: ("Helvetica Neue", "Helvetica", "Arial"), size: 8.8pt, fill: rgb("#1d1d1f"))
#set par(justify: true, leading: 0.48em)
#let section(t) = block(above: 1.3em, below: 0.6em, grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
  text(size: 16pt, fill: accent, weight: 300, t), line(length: 100%, stroke: 0.8pt + accent)))
#let role(r) = block(breakable: true, below: 0.3em)[#role-row(r, accent) #v(0.1em) #bullets(r.bullets)]

#let side = [
  #set par(justify: false)
  #text(size: 21pt, fill: accent)[#d.name] \ #v(0.3em)
  #text(size: 11pt, fill: muted, d.headline.join("\n")) #v(0.8em)
  #for c in d.contact [#contact-line(c, accent) \ ]
  #section[Education] #for e in d.education { edu-entry(e, accent) }
  #section[Skills] #for s in d.skills { skill-group(s, accent) }
  #section[Awards] #bullets(d.awards)
  #section[Publications] #d.publications
  #section[Languages] #d.languages
]
#let main = [
  #block(below: 0.4em, d.summary)
  #section[Professional Experience]
  #for r in d.experience { role(r); pills(r.tags, accent) }
  #section[Side Projects]
  #for r in d.projects { role(r); pills(r.tags, accent) }
]
#grid(columns: (33%, 67%),
  block(fill: rgb("#e9eaec"), width: 100%, height: 100%, inset: (x: 18pt, y: 24pt), side),
  block(inset: (x: 20pt, y: 24pt), main))
