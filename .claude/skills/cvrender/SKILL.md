---
name: cvrender
description: Turn a tailored briefs/<name>/draft.md into a designed, send-ready PDF (typst) — sidebar layout, tag pills, short bullets. Use when the user says /cvrender, "render the CV", "make the PDF", or after /tailor finishes a draft.
---

# cvrender

Agent-driven, not a pipeline. You write `briefs/<name>/cv.typ` by hand from `draft.md`, compile, look at the pages, and iterate until it looks like a designed document. Facts come from `draft.md` only (which came from `content/`); you reword and cut, never invent. Never promote role levels.

If `templates/` is missing from the working directory (standalone skill install), run `/setup` first — it scaffolds the repo layout this skill needs.

## Steps
1. Read `briefs/<name>/draft.md` and `spec.md` (doc type, page budget, paper size — US employers: `us-letter`). Ignore `<!-- src -->`, `## Trace`, `## Gaps`; those never render. A `# Cover note` section is a separate deliverable, not part of the CV.
2. Pick a design from `templates/designs/` (table in `templates/README.md`; `sh templates/preview.sh` to see them all). If `spec.md` or the user names one, use it; otherwise choose for the audience (04 editorial for academia, 08 terminal/05 timeline for engineering, 01/10 for mixed, 03/07 for industry). Copy it to `briefs/<name>/cv.typ`; change `../_lib.typ` → `/templates/_lib.typ`; replace the `_sample` import with an inline `#let d = (...)` in the same shape. Layout, colours, section order are yours to change — the design is a starting point, not a contract.
3. Fill `d` from `draft.md`:
   - `headline` 1–2 lines aimed at this role; `contact` from the draft/`facts.yml` links (icons: envelope, phone, github, linkedin, scholar, location, globe); `education` (degree · org · years, no theses); 2–4 `skills` groups of 2–4 short items; `awards`, `languages`, `publications` one-liner; `stats` 3–4 headline numbers.
   - `experience`: **3–5 bullets of ≤ 2 lines each** per role, 3–5 `tags`. `projects` same shape, 1–2 bullets.
   - Compress hard. The draft is prose-dense; the page is not. Each bullet = one claim with one number. Move stack detail into pills. Drop anything that doesn't serve a requirement in `spec.md`.
4. Compile and look: `typst compile --root . briefs/<name>/cv.typ && pdftoppm -r 60 -png briefs/<name>/cv.pdf <scratch>/p` then Read the PNGs. Check: page count within budget, no orphan headings, sidebar and main end near the same height on the last page, no wall-of-text paragraphs, pills don't wrap awkwardly, dates right-aligned. Fix and recompile; 2–4 rounds is normal.
5. Re-verify every number/date/title against `draft.md`. Report the PDF path.

## Design rules
- One accent colour, one typeface, three text sizes (section 17pt / body 9pt / meta 8.3pt). White space is not wasted space.
- No paragraph longer than 2 lines anywhere except the optional summary (≤ 3 lines).
- Tags are for skills/tech the reader scans for; don't tag what the bullet already says.
- Never volunteer gaps. Nothing hedged.
- Stat tiles carry whatever this audience would find most impressive — read the brief's audience, not a category. Pure industry: years, data scale, "AI in production". Research or semi-academic roles (including research teams inside companies): citations/papers can earn a tile alongside scale figures. Tile count adapts to the content: 3–4 when the figures are strong, fewer when they aren't; never pad with a weak stat. A tile value can be a word ("AI"). Whatever isn't tiled compresses into the Publications sidebar line.

## Other formats
DOCX/HTML on request only: `pandoc briefs/<name>/draft.md --reference-doc templates/reference.docx -o briefs/<name>/cv.docx` after stripping comments/Gaps (ugly but ATS-safe). A sleek HTML is a separate hand-written page, same content as `cv.typ`.
