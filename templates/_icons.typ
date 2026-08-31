// Font Awesome 7 (brew install --cask font-fontawesome). Codepoints are stable across FA5/6/7.
#let _solid = (
  envelope: "\u{f0e0}", phone: "\u{f095}", location: "\u{f3c5}", globe: "\u{f0ac}",
  graduation: "\u{f19d}", award: "\u{f559}", language: "\u{f1ab}", book: "\u{f02d}",
  briefcase: "\u{f0b1}", code: "\u{f121}", flask: "\u{f0c3}", chart: "\u{f080}",
  star: "\u{f005}", circle: "\u{f111}", dna: "\u{f471}", brain: "\u{f5dc}", link: "\u{f0c1}",
  users: "\u{f0c0}", rocket: "\u{f135}", database: "\u{f1c0}", server: "\u{f233}", check: "\u{f00c}",
)
#let _brands = (github: "\u{f09b}", linkedin: "\u{f08c}", scholar: "\u{f1a0}", stackoverflow: "\u{f16c}", orcid: "\u{f8d2}", python: "\u{f3e2}", r: "\u{f4f7}", docker: "\u{f395}", aws: "\u{f375}")
#let icon(name, size: 1em, fill: none) = {
  let (f, g) = if name in _brands { ("Font Awesome 7 Brands", _brands.at(name)) } else { ("Font Awesome 7 Free Solid", _solid.at(name)) }
  let t = text(font: f, size: size, g)
  if fill != none { text(fill: fill, t) } else { t }
}
