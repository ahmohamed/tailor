#!/usr/bin/env python3
# ponytail: the whole validator. Checks project frontmatter ids resolve; optional harvests validated only if present.
import yaml,glob,re,sys,os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
tax=yaml.safe_load(open('content/taxonomy.yml')) or {}
facts=yaml.safe_load(open('content/facts.yml')) or {}
pubs=set()
if os.path.exists('content/publications.yml'):
    _P=yaml.safe_load(open('content/publications.yml')) or {}
    pubs={p['id'] for p in (_P.get('publications') or [])+(_P.get('unindexed') or [])}
roles={r['id'] for r in facts.get('roles') or []}|{'personal'}
techs={t for g in (tax.get('tech') or {}).values() for t in g}
slugs=set(); cited=set(); bad=0
def err(m): global bad; bad+=1; print('ERR',m)
for f in sorted(glob.glob('content/projects/*.md')):
    txt=open(f).read(); m=re.match(r'---\n(.*?)\n---',txt,re.S)
    if not m: err(f'{f}: no frontmatter'); continue
    fm=yaml.safe_load(m.group(1)); slug=os.path.basename(f)[:-3]; slugs.add(slug)
    if fm.get('slug')!=slug: err(f'{f}: slug {fm.get("slug")} != filename')
    if fm.get('role') not in roles: err(f'{f}: role {fm.get("role")}')
    if fm.get('level') not in {'led','built','analysed','contributed','team'}: err(f'{f}: level {fm.get("level")}')
    if fm.get('visibility') not in {'public','private','confidential'}: err(f'{f}: visibility {fm.get("visibility")}')
    for k,ok in (('domains',tax.get('domains') or {}),('capabilities',tax.get('capabilities') or {}),('tech',techs),('publications',pubs)):
        for x in fm.get(k) or []:
            if x not in ok: err(f'{f}: {k} id {x}')
    for c in fm.get('components') or []:
        if c.get('visibility') not in {'public','private','confidential'}: err(f"{f}: component {c.get('name')} visibility")
    for s in fm.get('sources') or []:
        if s.startswith('sources/'):
            p=s.split('#')[0]
            if not os.path.exists(p): err(f'{f}: missing source {p}')
            if p.startswith('sources/github/'): cited.add(os.path.basename(p)[:-3])
    for sec in ['## Overview','## Technical Architecture','## Implementation','## Technologies','## Results','## Links']:
        if sec not in txt: err(f'{f}: missing section {sec}')
if os.path.exists('sources/github/repolist.md'):
    ticked={re.search(r'\[([^\]]+)\]\(([^)]+)\.md\)',l).group(2) for l in open('sources/github/repolist.md') if l.startswith('| [x]')}
    for r in sorted(ticked-cited): print('WARN ticked repo not cited:',r)
    for r in sorted(cited-ticked): print('WARN cited repo not ticked:',r)
if pubs and os.path.exists('content/publications.yml'):
    for p in yaml.safe_load(open('content/publications.yml')).get('publications') or []:
        for s in p.get('projects') or []:
            if s not in slugs: print('WARN pub',p['id'],'-> unknown project',s)
for name,pr in (yaml.safe_load(open('content/profiles.yml')) or {}).items():
    for s in pr.get('exclude_projects') or []:
        if s not in slugs: print('WARN profile',name,'excludes unknown',s)
print(f'{len(slugs)} projects, {bad} errors'); sys.exit(bool(bad))
