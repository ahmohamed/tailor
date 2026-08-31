// 10 · Dossier: two-tone split header (photo-free), skill meters as segmented bars, boxed key-facts strip, dates gutter. Slate + coral.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let slate = rgb("#334155"); #let accent = rgb("#f97360")
#set page(paper: "us-letter", margin: 0pt)
#set text(font: ("Helvetica Neue", "Arial"), size: 8.7pt, fill: rgb("#1e293b"))
#set par(leading: 0.47em)
#let section(t) = block(above: 1.2em, below: 0.5em)[#box(width: 4pt, height: 11pt, fill: accent) #h(6pt) #text(size: 11.5pt, weight: 700, fill: slate, t)]
#let meter(n, of: 5) = range(of).map(i => box(width: 9pt, height: 4pt, radius: 2pt, fill: if i < n { accent } else { luma(220) })).join(h(2pt))
#let role(r) = block(breakable: true, below: 0.55em, grid(columns: (16%, 1fr), column-gutter: 10pt,
  [#text(size: 8pt, weight: 700, fill: slate, r.dates)],
  [#text(size: 10pt, weight: 700, r.title) #h(6pt) #text(size: 8.3pt, fill: luma(100), r.org) #v(0.05em)
   #bullets(r.bullets, marker: [–]) #pills(r.tags, slate, filled: true)]))

#grid(columns: (38%, 62%),
  grid.cell(fill: slate, inset: (x: 22pt, y: 24pt))[#text(size: 24pt, weight: 800, fill: white)[#d.name] \ #text(size: 10pt, fill: accent, weight: 600, d.headline.join(" / "))],
  grid.cell(fill: accent, inset: (x: 22pt, y: 24pt))[#set text(fill: white, size: 8.6pt); #v(6pt) #grid(columns: (1fr, 1fr), row-gutter: 5pt, ..d.contact.map(c => contact-line(c, white, icon-fill: white)))])
#block(inset: (x: 22pt, y: 0pt), width: 100%)[
  #block(fill: luma(245), width: 100%, inset: 9pt, radius: 0pt, grid(columns: (1fr,) * d.stats.len(), ..d.stats.map(s => align(center)[#text(size: 14pt, weight: 800, fill: slate, s.at(0)) #h(3pt) #text(size: 7.5pt, fill: luma(90), upper(s.at(1)))])))]
#block(inset: (x: 22pt, y: 10pt))[
  #grid(columns: (1fr, 30%), column-gutter: 20pt,
    [#text(fill: luma(70), d.summary)
     #section[Experience] #for r in d.experience { role(r) }
     #section[Projects] #for r in d.projects { role(r) }],
    [#section[Skills]
     #for (i, s) in d.skills.enumerate() [#grid(columns: (1fr, auto), text(weight: 700, s.at(0)), meter((5, 5, 4, 4).at(i))) #text(size: 8pt, fill: luma(90), s.at(1).join(" · ")) #v(0.4em)]
     #section[Education] #for e in d.education { edu-entry(e, slate) }
     #section[Awards] #bullets(d.awards)
     #section[Publications] #d.publications
     #section[Languages] #d.languages])]
