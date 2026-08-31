# CLAUDE.md

This repo is a personal career knowledge base built on **Tailor**. Raw career sources are harvested under `sources/`; canonical records live in `content/`; audience-specific outputs are produced per brief in `briefs/` via the `/tailor` skill and rendered with `/cvrender`. `python3 check.py` validates `content/`.

## Hard rules

- Never read or write outside this folder unless explicitly asked. External material arrives via `sources/inbox/`.
- `sources/` is the raw-harvest layer: organise and annotate it, but never rewrite original documents (CVs, portfolio files). Harvest outputs (`INVENTORY.md`, `sources/github/*.md`, `repolist.md`, harvest notes) are regenerable and editable.
- Purpose of the KB: help the user present themselves as strongly as possible to each venue (think reference letter, not audit). The user's own framing of their work is authoritative — standing rulings live in `content/RULES.md`. Never invent numbers, dates, titles or employers; everything else (emphasis, wording, ordering) is optimised in the user's favour. Never volunteer gaps or weaknesses in output documents.
- `sources/github/repolist.md` checkboxes (if present) decide which repos get catalogued — respect exclusions.
- `content/` is the truth layer: every project has `role:` (id in `facts.yml`, or `personal`) and `level:` (led/built/analysed/contributed/team). Never promote a level when rendering. A record is a *topic*; `components:` are its concrete projects with their own `visibility` — private components are described functionally, never named or linked. Inferred facts go in a record's `## Open questions`, never the body.
- Old CVs are stale outputs, not sources of truth; the harvest supersedes them. Cross-source conflicts go in `content/DISCREPANCIES.md` for the user to resolve.
- Run `python3 check.py` after editing `content/`.

## Layout and pipeline

```
check.py           validator for content/
content/
  projects/        one record per project, 6-part template (PROJECT_TEMPLATE.md) + frontmatter:
                   role, level, domains, capabilities, tech, visibility, sources
  facts.yml        roles (ids), education, awards, memberships, teaching, talks, languages, links
  taxonomy.yml     controlled vocab: domains, capabilities, tech
  publications.yml optional (academics): pubs with ids, first_author flag, project links
  profiles.yml     presets — seeds for /tailor, not gates
  RULES.md         the user's standing rulings (framing, exclusions, conventions, visibility)
  DISCREPANCIES.md cross-source conflicts awaiting the user's resolution
briefs/<name>/     brief.md → audience.md/role.md/spec.md → candidates.yml → selection.yml (reviewed) → draft.md → cv.typ/cv.pdf
templates/         10 typst CV designs + _sample/_lib/_icons + preview.sh for /cvrender; reference.docx = DOCX fallback
sources/           raw harvest: inbox/ (drop zone), plus whatever /setup produces (INVENTORY.md, github/, harvest notes)
```

Workflow: `/setup` (bootstrap + harvest + interview) → resolve `content/DISCREPANCIES.md` → `/tailor "<job ad>"` → review `selection.yml` → `/cvrender`.
