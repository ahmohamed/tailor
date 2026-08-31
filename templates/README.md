# CV templates (typst)
`sh templates/preview.sh` renders all designs with `_sample.typ` into `templates/preview/` — open the PDFs/PNGs and pick one.

| # | file | look |
|---|------|------|
| 01 | sidebar-left | grey identity column, blue rules, pills (classic) |
| 02 | sidebar-dark-right | navy sidebar on the right, teal accent, warm paper |
| 03 | banner | full-width green header with stat tiles, two columns |
| 04 | editorial-serif | single column, Georgia display, hairlines, oxblood |
| 05 | timeline | vertical rail with dots per role, indigo, stat grid |
| 06 | swiss | oversized name, red accent, dates in a left gutter |
| 07 | cards | each role on a white card, initials badge, amber |
| 08 | terminal | monospace, dark header bar, `$` sections, hashtags |
| 09 | spine | name rotated on a purple spine, wide single column |
| 10 | dossier | slate/coral split header, skill meters, stats strip |

Files: `_sample.typ` (data dict every design consumes — same shape for real CVs), `_lib.typ` (pill, bullets, role-row, contact-line, edu-entry, skill-group), `_icons.typ` (Font Awesome 7 via codepoints; `brew install --cask font-fontawesome`). `reference.docx` is the pandoc DOCX fallback.

To use for a brief: copy `designs/NN-x.typ` to `briefs/<name>/cv.typ`, replace `#import "../_sample.typ": d` with an inline `#let d = (...)` filled from `draft.md`, fix the `../_lib.typ` import path to `/templates/_lib.typ`, and `typst compile --root . briefs/<name>/cv.typ`.
