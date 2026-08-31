// 08 · Terminal: monospace, dark header bar, prompt-style section markers, key numbers as a stats row. For engineering audiences.
#import "../_lib.typ": *
#import "../_sample.typ": d
#let bg = rgb("#0f172a"); #let accent = rgb("#22c55e"); #let mono = ("Menlo", "Courier New")
#set page(paper: "us-letter", margin: 0pt)
#set text(font: ("Helvetica Neue", "Arial"), size: 8.7pt, fill: rgb("#0f172a"))
#set par(leading: 0.48em)
#let section(t) = block(above: 1.2em, below: 0.5em, text(font: mono, size: 10pt, weight: 700)[#text(fill: accent.darken(20%))[\$] #h(4pt) #t])
#let role(r) = block(breakable: true, below: 0.3em)[
  #grid(columns: (auto, 1fr, auto), column-gutter: 8pt, text(weight: 700, size: 9.6pt, r.title), text(font: mono, size: 7.8pt, fill: luma(100), r.org), text(font: mono, size: 7.8pt, fill: accent.darken(30%), r.dates))
  #v(0.1em) #bullets(r.bullets, marker: text(font: mono)[>], color: accent.darken(20%))
  #if r.tags.len() > 0 [#text(font: mono, size: 7.6pt, fill: luma(110), r.tags.map(t => "#" + lower(t.replace(" ", "-"))).join("  "))]]

#block(fill: bg, width: 100%, inset: (x: 26pt, y: 20pt))[
  #set text(fill: white)
  #grid(columns: (1fr, auto), align: (left, right),
    [#text(font: mono, size: 8pt, fill: accent)[~/cv] #text(font: mono, size: 8pt, fill: luma(150))[ \$ whoami] \
     #text(size: 24pt, weight: 700)[#d.name] \ #text(font: mono, size: 9pt, fill: accent, d.headline.join(" && "))],
    [#set text(size: 8.2pt, font: mono); #for c in d.contact [#contact-line(c, accent, icon-fill: accent, size: 8pt) \ ]])
  #v(8pt)
  #grid(columns: (1fr,) * d.stats.len(), ..d.stats.map(s => [#text(font: mono, size: 15pt, weight: 700, fill: accent, s.at(0)) #h(4pt) #text(font: mono, size: 7.5pt, fill: luma(170), s.at(1))]))
]
#block(inset: (x: 26pt, y: 12pt))[
  #text(fill: luma(70), d.summary)
  #grid(columns: (1fr, 29%), column-gutter: 20pt,
    [#section[experience] #for r in d.experience { role(r) } #section[projects] #for r in d.projects { role(r) }],
    [#section[education] #for e in d.education { edu-entry(e, accent) }
     #section[skills] #for s in d.skills [#text(font: mono, size: 8pt, weight: 700, s.at(0)) \ #text(size: 8.2pt, s.at(1).join(" · ")) #v(0.35em)]
     #section[awards] #bullets(d.awards, marker: text(font: mono)[\*], color: accent.darken(20%))
     #section[papers] #d.publications
     #section[lang] #d.languages])]
