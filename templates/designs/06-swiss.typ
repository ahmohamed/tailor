// 06 · Swiss: black-on-white typographic grid, oversized name, single red accent, dates in a left gutter.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let accent = rgb("#e63946")
#set page(paper: "us-letter", margin: (x: 0.6in, y: 0.55in))
#set text(font: ("Helvetica Neue", "Helvetica", "Arial"), size: 8.8pt, fill: black)
#set par(leading: 0.48em)
#let section(t) = block(above: 1.4em, below: 0.7em, grid(columns: (22%, 1fr), text(size: 8pt, weight: 700, tracking: 0.15em, fill: accent, upper(t)), line(length: 100%, stroke: 0.5pt + black)))
#let role(r) = block(breakable: true, below: 0.7em, grid(columns: (22%, 1fr), column-gutter: 10pt,
  [#text(size: 8.2pt, weight: 600, r.dates) \ #text(size: 7.8pt, fill: luma(100), r.org)],
  [#text(size: 10pt, weight: 700, r.title) #v(0.05em) #bullets(r.bullets, marker: [—], color: accent)
   #if r.tags.len() > 0 [#text(size: 7.6pt, fill: luma(100), r.tags.join("  /  "))]]))

#text(size: 44pt, weight: 800, tracking: -0.03em)[#d.name.split(" ").join("\n")]
#v(-0.2em)
#grid(columns: (22%, 1fr, auto), column-gutter: 10pt, align: bottom,
  text(size: 9pt, fill: accent, weight: 700, d.headline.join("\n")),
  text(size: 8.8pt, d.summary),
  [#set text(size: 8pt); #for c in d.contact [#contact-line(c, black, icon-fill: accent) \ ]])
#section[Experience] #for r in d.experience { role(r) }
#section[Projects] #for r in d.projects { role(r) }
#section[Education] #for e in d.education { grid(columns: (22%, 1fr), column-gutter: 10pt, text(size: 8.2pt, weight: 600, e.at(2)), [#text(weight: 700, e.at(0)) — #e.at(1)]); v(0.3em) }
#section[Skills] #for s in d.skills { grid(columns: (22%, 1fr), column-gutter: 10pt, text(size: 8.2pt, weight: 600, s.at(0)), s.at(1).join(" · ")); v(0.3em) }
#section[Awards] #grid(columns: (22%, 1fr), column-gutter: 10pt, [], d.awards.join(" · "))
#v(0.3em) #grid(columns: (22%, 1fr), column-gutter: 10pt, text(size: 8.2pt, weight: 600)[Publications], d.publications)
