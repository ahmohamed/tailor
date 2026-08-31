---
name: Human name
slug: kebab-slug            # = filename
role: acme                  # id from content/facts.yml roles, or personal
dates: {start: 2020-07, end: 2025-03}   # null end = ongoing
level: led                  # led | built | analysed | contributed | team
domains: []                 # ids from content/taxonomy.yml
capabilities: []
tech: []
visibility: public          # record default: public | private | confidential
components:                 # optional; a record is a topic, components are its concrete projects.
  - {name: public-widget, visibility: public, repo: https://github.com/org/public-widget}
  - {name: client-backend, visibility: private}   # private: /tailor describes function + contribution only, never name/link
sources:                    # paths under sources/ (+ #anchor), or URLs
  - sources/github/owner--repo.md
publications: []            # publications.yml ids (slug of title) — fill later if unknown
---

# Name

One-paragraph summary: what it is, what you did, scale, outcome.

## Overview & Business Context
Problem, who for, why it mattered.

## Technical Architecture
Components, stack rationale. Prose or short list.

## Implementation Highlights
What you specifically built/designed/analysed. Hard parts. Tag contributions by others as [team].

## Technologies & Tools
Languages, frameworks, infra, testing.

## Results & Metrics
Numbers only from sources (downloads, users, commits, ROC, scale). No invented metrics.

## Links
Repos, live sites, papers, docs.
