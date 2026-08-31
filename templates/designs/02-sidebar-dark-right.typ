// 02 · Dark navy sidebar on the right, white text; main column in warm white. Teal accent.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let navy = rgb("#14213d"); #let accent = rgb("#2ec4b6"); #let paper = rgb("#fdfcf9")
#set page(paper: "us-letter", margin: 0pt, fill: paper, background: place(right, rect(width: 34%, height: 100%, fill: navy)))
#set text(font: ("Avenir Next", "Helvetica Neue", "Arial"), size: 8.8pt, fill: rgb("#1c1c1c"))
#set par(justify: false, leading: 0.5em)
#let section(t, light: false) = block(above: 1.3em, below: 0.55em)[
  #text(size: 9pt, weight: 700, tracking: 0.12em, fill: accent, upper(t)) #v(-0.5em) #line(length: 24pt, stroke: 1.5pt + accent)]
#let role(r) = block(breakable: true, below: 0.25em)[
  #text(size: 10.5pt, weight: 600, r.title) #h(1fr) #text(size: 8pt, fill: luma(110), r.dates) \
  #text(size: 8.5pt, fill: navy.lighten(30%), weight: 500, r.org) #v(0.05em)
  #bullets(r.bullets, marker: [▸], color: accent)]

#let main = [
  #text(size: 26pt, weight: 700, fill: navy)[#d.name] \ #v(0.1em)
  #text(size: 11pt, fill: accent.darken(30%), weight: 500, d.headline.join("  ·  ")) #v(0.6em)
  #text(size: 9pt, fill: luma(60), d.summary)
  #section[Experience]
  #for r in d.experience { role(r); pills(r.tags, accent.darken(25%), filled: true) }
  #section[Projects]
  #for r in d.projects { role(r); pills(r.tags, accent.darken(25%), filled: true) }
]
#let side = [
  #set text(fill: white, size: 8.6pt)
  #for c in d.contact [#contact-line(c, accent, icon-fill: accent) \ ]
  #section[Education] #for e in d.education [#text(weight: 600, e.at(0)) \ #text(size: 8pt, fill: luma(200), e.at(1) + " · " + e.at(2)) #v(0.35em)]
  #section[Skills] #for s in d.skills [#text(weight: 700, fill: accent, s.at(0)) \ #text(size: 8.2pt, fill: luma(215), s.at(1).join(" · ")) #v(0.4em)]
  #section[Awards] #for a in d.awards [#icon("award", fill: accent, size: 8pt) #h(4pt) #a \ ]
  #section[Publications] #text(fill: luma(215), d.publications)
  #section[Languages] #text(fill: luma(215), d.languages)
]
#grid(columns: (66%, 34%),
  block(inset: (x: 24pt, y: 28pt), main),
  block(width: 100%, inset: (x: 18pt, y: 30pt), side))
