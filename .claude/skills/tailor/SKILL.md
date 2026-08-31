---
name: tailor
description: Generate an audience-specific career document (CV, capability statement, tender response section, bio/intro, cover paragraph) from the canonical records in content/. Use when the user says /tailor, "make me a CV for…", "write a bio for…", "respond to this tender/JD", or drops a brief into briefs/.
---

# /tailor — research → select → compress → write

## Purpose
`content/` exists to help the user present themselves as strongly as possible to each venue. You are writing the way a supportive referee writes a reference letter: you know the record, you pick the strongest true version of it, and you argue for the candidate. This is advocacy, not an audit.

- **The user's framing is authoritative.** When they say how something should be described, use it. Offer to record it in `content/RULES.md` so it sticks. Do not counter with "no source says that".
- **Read `content/RULES.md` before selecting.** It holds the user's standing rulings: framing conventions, named exclusions, selection biases, rendering conventions, visibility policy. Apply every rule there as if the user said it in this session. When the user makes a new ruling mid-brief, offer to append it.
- **Records are support, not a ceiling.** Use them to make every claim concrete: numbers, names, scale. Pick the most favourable accurate reading of a record. Round up in framing, never in numbers.
- **Never volunteer weakness.** No "I haven't done X", "would learn on the job", "my depth is A rather than B". What doesn't exist is simply absent. Unmet requirements go in the `## Gaps` section of the draft (for the user), never in the text the reader sees.
- **No hedging or review tags** in the output. State things.
- **Don't invent.** New numbers, dates, titles, employers or publications never appear without a record or the user's word. Everything else — wording, emphasis, ordering, what to lead with — is yours to optimise.
- **Outputs are never experience.** Documents the user authored to sell themselves (tender responses, pitches, proposals) never enter `candidates.yml`, `selection.yml`, or a draft as a project or proof point, not even "described functionally". Use them only as pointers to the real records that back their claims.
- **Thin evidence rule.** When the headline capability a brief asks for is supported by only one or two records, bring the broader adjacent track (published, quantified results) alongside it rather than letting the document rest on thin evidence.
- Seven phases, one review stop (after selection). Audience research comes from the web; facts about the candidate come from `content/` and from the user.

If `content/projects/` is empty, stop and tell the user to run `/setup` first — there is nothing to select from yet.

## Inputs
- A brief: `briefs/<name>/brief.md` (JD, RFQ, "intro me to X", email text). Inline text → create the dir and save it there first.
- Optional: `--profile <name>` — a key from `content/profiles.yml` (seed only; if none given, pick the closest and say which), `--form <cv|capability|tender|bio|intro|cover>`, `--pages N` / `--words N`, `--region <au|us|uk|gcc|eu>`.

Each phase writes its file under `briefs/<name>/`. Later phases re-read earlier files (the user may have edited them).

## Phase 1 — research the audience → `audience.md`
Who is publishing this, and what do they actually value? Use WebSearch/WebFetch on the organisation, department/team, and named contact (hiring manager, procurement officer, PI).
Record, with source URLs:
- Type: public body / university / corporate / startup / VC-backed / government agency. Funding stage, size, age.
- Mission and stated priorities (strategy pages, recent announcements, annual report, grants, GitHub org, papers).
- Risk posture: risk-averse (compliance, procurement rules, proven stacks) vs risk-taking (ship fast, new tech). Evidence, not vibes.
- Culture signals: team composition, tech blog, hiring pattern, how they write.
- Contact person if named: role, background, what they publish/build — this shapes tone and which of the candidate's work they'd recognise.
- **Implied needs**: capabilities the brief doesn't name but the organisation's context makes likely (e.g. a hospital research unit implies ethics/data governance; a startup implies breadth and shipping; a tender implies compliance, insurance, delivery methodology).
Mark anything unverifiable as `(unconfirmed)`. If the web is off or the org is unknown, say so and proceed on the brief alone.

## Phase 2 — research the role → `role.md`
- **Explicit**: every requirement, qualification, deliverable, selection criterion, evaluation weighting, word/page limit, mandatory attachment. Quote the brief.
- **Implicit**: what the role is really for (backfill? new capability? grant-funded term? compliance box?), seniority and autonomy expected, who they'd be comparing the candidate against, what would disqualify.
- **Key-words**: the brief's own vocabulary (ATS and human reviewers both match on it). List the terms to mirror verbatim.
- Map each explicit + implicit requirement to a priority: `must`, `strong`, `nice`.

## Phase 3 — define the output → `spec.md`
Decide and write down before selecting content:
- **Form and region conventions.** AU academic/government CV: long, full publications, referees, selection-criteria responses as a separate document. US résumé: 1–2 pages, no photo/DOB/nationality, achievement bullets. UK: 2 pages, personal statement. GCC: photo, nationality, DOB and marital status are often expected, visa/notice period stated. EU: Europass-adjacent. Tender/RFQ: follow the RFQ's schedule/structure exactly; capability statement, methodology, CVs of key personnel, compliance matrix, insurances. Bio/intro: third person, one paragraph. Cover: first person, 3 paragraphs max. Check current conventions with a web search when unsure; don't assume.
- **Sections**, in order, with a length budget each.
- **Tone**: academic / corporate / startup / procurement-formal. Derived from Phase 1.
- **Disclosure level**: public site < job application < tender under NDA. Sets the max `visibility` allowed.
- **Length**: pages/words, hard cap.

## Phase 4 — gather content (exhaustive) → `candidates.yml`
Do not shortlist yet. Sweep everything:
1. Read `content/RULES.md`, `content/facts.yml`, `taxonomy.yml`, `profiles.yml`, `publications.yml` (if present), and the **frontmatter of every** `content/projects/*.md`.
2. For each `must`/`strong`/`nice` requirement and each implied need, list every record (project, role, publication, award, talk, teaching, membership) that could evidence it. Search bodies for the key-words from Phase 2 — frontmatter tags alone miss things.
3. Read the full body of every project that matched anything.
4. Output: `requirement → [record ids + the specific line/figure in the record that supports it]`. Also list records matching nothing (so omission is deliberate, not accidental).
Respect `visibility`: drop anything above the disclosure level now. Private `components:` stay in as "describe functionally, never name". Apply any exclusions named in `content/RULES.md`.

## Phase 5 — rank → `selection.yml` (STOP for review)
Score each candidate against: priority of the requirement it serves (must > strong > nice > implied), role level (led > built > analysed > contributed), recency, scale figures available, audience recognition (Phase 1: would *they* know this?), and uniqueness (does another stronger record already cover the same requirement?). No scoring code — reason it out and state the order.

```yaml
brief: briefs/<name>/brief.md
profile: <profiles.yml key>
form: cv
region: au
audience: <one line from audience.md>
requirements:            # from role.md, with priority
  - {text: ..., priority: must}
projects:                # ordered
  - id: <slug>
    why: <which requirement(s)>
    emphasis: [<capability ids>]
    level: led
    lead_figure: "<headline scale/outcome figure from the record>"
roles: [<role ids>]
publications: [<ids>]    # or 'all-first-author' / 'count-only'
facts: [education, awards, talks]
keywords_to_mirror: [<from role.md>]
omitted_notable: [{id: ..., why: ...}]
gaps: [<requirements with no supporting record>]
```
Show the user a compact table (project · level · requirement served · lead figure) and the `gaps` list. **Stop.** No drafting until they approve or edit `selection.yml`.

## Phase 6 — compress and draft → `draft.md`
Write once, then cut. Target: the information in as few words as it can carry.
- Numbers, dates, titles, role levels from records or from the user. Reword freely. A requirement with no record stays in `gaps` and is not mentioned in the draft; a requirement with *partial* support gets the strongest honest framing the support allows (a narrow published result in field X is still experience in field X).
- **Component visibility (IP rule).** A record is a topic; its `components:` are the concrete projects with their own `visibility`. Public: name, link, detail. Private/confidential: what it does and what the user did, never name/repo/client/URL. No `components:` → record-level visibility applies. In doubt → private.
- **Role level governs verbs.** led → led/designed/owned; built → built/implemented; analysed → analysed/designed the analysis; contributed → contributed to. Don't promote a level, but choose the strongest verb that level allows.
- Experience = projects grouped by `role`, ordered per selection; org/title/dates from `facts.yml`, rendered per any conventions in `content/RULES.md`. Citation metrics from `content/publications.yml`, never from old CVs.
- Prefer recorded headline figures. Lead each bullet with the outcome or scale, then the what; drop the how unless the brief asks.
- Mirror `keywords_to_mirror` where a record genuinely supports the term.
- Compression pass: delete every adjective that isn't a fact, every "responsible for", every restatement of the section heading, every bullet that serves no requirement. If two bullets serve the same requirement, keep the stronger one. Check against the length cap in `spec.md`.
- After each paragraph/bullet block append `<!-- src: <record ids> -->`.
- End with `## Trace` (record ids per section) and `gaps`.

## Phase 7 — humanize → `draft.md` (final)
Invoke the `humanizer` skill on the draft body (not the HTML comments or Trace) if available; otherwise do the pass yourself. Then a manual pass for CV-specific slop: no "passionate", "leverage", "spearheaded", "cutting-edge", "proven track record", "results-driven"; no rule-of-three lists padded to three; no em-dash chains; no sentence that would read the same on anyone else's CV. Then the referee check: read it as the hiring manager; any sentence that lowers their estimate of the candidate goes. Re-verify that no fact changed and every block still has its `src` comment. Tell the user the path, then offer `/cvrender` for the designed PDF.

## Re-runs
Same brief → reuse `audience.md`, `role.md`, `spec.md`, `selection.yml` unless asked to redo a phase. Same org, new role → reuse `audience.md` only. New audience → new `briefs/<name>/`.
