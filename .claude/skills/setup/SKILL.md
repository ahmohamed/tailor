---
name: setup
description: Bootstrap the career knowledge base — environment check, facts interview, guided harvest from CVs/GitHub/LinkedIn/Scholar, or a pure interview when no documents exist. Use when the user says /setup, "set up my knowledge base", "harvest my career", or when /tailor finds content/projects/ empty.
---

# /setup — bootstrap + harvest + interview

Goal: a `content/` that `/tailor` can select from — project records, facts, taxonomy, one profile, and the user's `RULES.md` — built from whatever the user has: old CVs, GitHub, a LinkedIn export, publications, or nothing but their memory. Every intake step is optional; the interview covers whatever documents don't.

Throughout: you are harvesting to surface work the user forgot to claim, not auditing claims. Record the user's own framing as authoritative. Tag everything by role level — `[led]` `[built]` `[analysed]` `[contributed]` `[team]` — and never promote a level. When sources conflict (an old CV says ">400 citations", Scholar says 842), log it in `content/DISCREPANCIES.md` with both readings and move on; the user resolves it at the end.

## 0 — Environment check
Check, report missing with the install one-liner, but don't block (only /cvrender needs the render stack):
- `typst`, `pdftoppm` (poppler), `pandoc`: `brew install typst poppler pandoc` (or distro equivalent)
- Font Awesome 7: `brew install --cask font-fontawesome`
- `gh auth status` if a GitHub harvest is wanted.

## 1 — Facts interview → `content/facts.yml` + seed `content/RULES.md`
Short interview: name; roles (org, title, location, start/end — stable kebab ids); education; awards/memberships/teaching/talks if any; links (GitHub handle, LinkedIn, Scholar/ORCID, site).
Then the visibility questions, recorded as rules in `content/RULES.md`:
- Any employers, clients, or projects that must stay unnamed (NDA, IP)? → visibility policy rule.
- Anything that must never appear on a CV (conflict of interest, relinquished IP)? → named exclusion rule.
- Any standing framing preferences for employers or titles? → framing rules.

## 2 — Source intake (each optional; ask which apply)

### (a) Existing CVs and documents
Have the user drop everything into `sources/inbox/` — every CV variant, cover letters, portfolio pages, tender/grant documents, reference letters. Read all of it and write `sources/INVENTORY.md`: one entry per document — what it holds, what it *uniquely* holds, and a duplication map (most career corpora are a few base documents re-serialized many ways; say which). Unique content is what feeds records; note that old CVs are stale outputs, not truth — conflicts go to `DISCREPANCIES.md`.

### (b) GitHub (via `gh` CLI)
The GraphQL contributions API silently misses commits made with a work email — never rely on it. Recipe:
1. `gh api user --jq .login` and `gh api user/orgs --jq '.[].login'` — all orgs, plus any the user names.
2. Enumerate repos per org/user (`gh repo list <owner> --limit 200 --json name,visibility,isFork,pushedAt,primaryLanguage,repositoryTopics,stargazerCount,description`).
3. For each candidate repo, sweep `gh api "repos/OWNER/REPO/commits?author=<handle>&per_page=1" -i` — a non-empty result proves contribution even when the contributions graph shows nothing. Also try known work emails as `author=` if the user provides them.
4. Write `sources/github/repolist.md`: a checkbox table `| [ ] | [owner--repo](owner--repo.md) | role | language | pushed | stars |`. The user ticks which repos get catalogued — respect exclusions from then on.
5. For each ticked repo, write `sources/github/owner--repo.md`: frontmatter (repo, url, visibility, fork, role, created, pushed, language, topics, stars, my_contributions) + a digest of the README. Don't read the code.

### (c) LinkedIn export
User requests their data export (Settings → Data privacy → Get a copy of your data), drops the zip in `sources/inbox/`. Unzip and read `Positions.csv`, `Projects.csv`, `Education.csv`, `Skills.csv`, `Recommendations.csv` directly. Cross-check dates/titles against facts.yml; conflicts → `DISCREPANCIES.md`.

### (d) Publications (academics; optional)
Query OpenAlex REST (`https://api.openalex.org/works?filter=author.orcid:<orcid>` or search by name, verify with the user) → `content/publications.yml`: each pub gets `id` (yyyy-three-words slug), title, venue, year, `first_author` flag, empty `projects: []` to be linked in step 4. Record citation totals/h-index with the harvest date. Google Scholar has no API — if the user has a Scholar profile, WebFetch it for the headline metrics only.

### (e) Interview mode — for work with no documents
For each role or era not covered by documents, interview the user and write `sources/<role>/HARVEST.md` notes: what the project was, what *they* did (tag `[led]`/`[built]`/`[analysed]`/`[contributed]`/`[team]`), scale figures, outcomes, technologies. Two-tier capabilities: things they can claim and defend in an interview vs exposure-only — record the tier; only tier 1 becomes a taxonomy capability. Push for numbers ("how many samples/users/requests?") but record only what the user actually says.

## 3 — Synthesis
1. Group the harvest into project records — a record is a *topic* (concrete sub-projects become `components:` with their own visibility), not one file per repo. Write each to `content/projects/<slug>.md` following `content/PROJECT_TEMPLATE.md`: frontmatter (role, dates, level, domains, capabilities, tech, visibility, sources, publications) + the six sections. Every claim needs a source path or "per the user".
2. Seed `content/taxonomy.yml` from what actually appeared — ids only for values a project uses.
3. Link publications to projects (`projects:` lists in publications.yml).
4. Create one starter profile in `content/profiles.yml` matching the user's primary target audience (ask what they'll apply for first).
5. Write `content/DISCREPANCIES.md` — every conflict found, with both readings and a recommendation.
6. `python3 check.py` until green.
7. Hand over: summarize what was built, list the discrepancies to resolve, and point at `/tailor "<job ad>"` as the next step.
