// Sample content for previewing designs (Ahmed Mohamed — the author; LinkedIn-public info only).
// Every design takes this dict shape.
#let d = (
  name: "Ahmed Mohamed",
  headline: ("AI Engineer", "Technical Lead"),
  summary: "I build LLM systems that go into production and stay there: extraction pipelines, multi-provider structured output, cell-level accuracy evaluation, and the AWS and data-governance setup to run them on sensitive data. Data scientist by training (PhD, 30+ papers, statistics and ML on a 30,000-sample study) and a backend engineer by practice (Go services and financial reporting for an institutional Ethereum operator).",
  stats: (("30+", "papers"), ("12,138", "study participants"), (">10 TB", "data analysed"), ("3", "Bioconductor pkgs")),
  contact: (
    (icon: "envelope", text: "ahmed@tailor.example", url: "mailto:ahmed@tailor.example"),
    (icon: "github", text: "github.com/ahmohamed", url: "https://github.com/ahmohamed"),
    (icon: "linkedin", text: "linkedin.com/in/amfy10", url: "https://www.linkedin.com/in/amfy10"),
    (icon: "location", text: "Melbourne, Australia", url: none),
  ),
  education: (
    ("PhD, Bioinformatics & Chemical Genomics", "Kyoto University, Japan", "2012–2016"),
    ("MSc, Advanced Pharmaco-science", "Osaka University, Japan", "2010–2012"),
    ("BPharm, Pharmaceutical Sciences", "Suez Canal University, Egypt", "2002–2007"),
  ),
  skills: (
    ("LLM engineering", ("Extraction pipelines, structured output", "Cell-level evals, DSPy prompt optimisation", "RAG, multi-provider tooling")),
    ("Data science", ("Statistics & ML at population scale", "Cancer genomics, Bioconductor", "lipidr, NetPathMiner, vissE (author)")),
    ("Software & infra", ("Python, Go, TypeScript/React", "AWS, Kubernetes, Docker, PostgreSQL", "Nextflow, SLURM HPC")),
    ("Web3", ("Ethereum staking services", "Financial reporting & invoicing")),
  ),
  awards: ("ICR Award for Graduate Students, 2015", "Winner, Novartis BioCamp, 2013", "JSPS International Training Program Fellowship, 2013", "Rotary Yoneyama Memorial Scholarship"),
  publications: "30+ papers. NetPathMiner (Bioinformatics), NMRPro (Bioinformatics), lipidr (160+ citations, in Bioconductor since 2019), vissE.cloud (NAR, first author).",
  languages: "English, Arabic, Japanese",
  experience: (
    (title: "Co-founder & Technical Lead", org: "AIWhisperers, Australia", dates: "2023 – now", tags: ("LLM systems", "Evals", "Data governance", "AWS"), bullets: (
      "Built production LLM systems for SMEs, including a human-reviewed platform converting supplier contracts into structured commercial data for a B2B travel company.",
      "Wrote the company's LLM tooling: multi-provider structured-output library, composable extraction chains, LLM-run caching, cell-level evaluation comparing prompt strategies and models; DSPy prompt optimisation.",
      "Established the PHI data-governance framework (Privacy Act 1988, ISO 27001-aligned) and secure AWS architecture: private-subnet SageMaker inference, KMS-encrypted RDS/S3, least-privilege IAM.",
      "Delivered LLM-for-business workshops for companies in retail, health, tourism and mining.")),
    (title: "Senior Software Engineer", org: "Bitwise Onchain Solutions (ex-Attestant)", dates: "2022 – now", tags: ("Go", "Ethereum", "Financial systems"), bullets: (
      "Backend engineer for institutional Ethereum and multi-chain staking services.",
      "Own the client reporting and invoicing system with multi-currency support; maintain client-facing APIs and the multi-chain staking dApp.")),
    (title: "Bioinformatician, Senior Research Officer", org: "WEHI, Melbourne", dates: "2020 – 2025", tags: ("Proteomics", "Statistics & ML", "Nextflow", "BigQuery"), bullets: (
      "Led experimental design, QC, statistics and ML for the ASPREE proteomics programme: 12,138 participants, ~30,000 LC-MS runs, >10 TB — at the time 10× the largest published MS population proteomics study.",
      "Built the Nextflow processing pipeline on SLURM HPC (DIA-NN, out-of-memory HDF5 matrices) and a BigQuery-backed QC dashboard watching hundreds of runs a day.",
      "Designed the analysis-first experimental layout that made batch correction and longitudinal modelling work at scale; ran LASSO biomarker models across 13 conditions.",
      "Built vissE.cloud end-to-end (React/TypeScript, Flask, Redis, Docker): a public gene-set analysis web server across bulk, single-cell and spatial data; first author of the NAR paper.",
      "Senior author on an ML urine-spectroscopy test for bladder-cancer recurrence (ROC > 0.8).")),
    (title: "Research Officer", org: "QIMR Berghofer & UQ Diamantina, Brisbane", dates: "2017 – 2020", tags: ("Lipidomics", "Bioconductor", "Biostatistics"), bullets: (
      "Created lipidr, an R/Bioconductor package for lipidomics analysis (160+ citations), and LipidSuite, its web server for non-programmers; sole developer of RaftProt V2 — tools accessed tens of thousands of times.",
      "Statistical lead for collaborator studies; taught R package development and Software Carpentry Python; associate supervisor of a PhD student to completion.")),
    (title: "PhD · JSPS Visiting Fellow", org: "Kyoto University · Boston University", dates: "2012 – 2016", tags: ("Network biology", "Cancer genomics"), bullets: (
      "NetPathMiner, an R/Bioconductor package for network path mining (Bioinformatics); NMRPro, interactive web processing of NMR spectra (Bioinformatics).",
      "Pan-cancer analysis of somatic mutations in protein complexes.")),
  ),
  projects: (
    (title: "Tailor", org: "This CV — career knowledge base + agentic tailoring, open source", dates: "2026", tags: ("Claude Code", "typst"), bullets: ("Harvest your career once; tailor CVs to any job in minutes. This document is its output.",)),
    (title: "Notebrainer", org: "Provenance-first agent memory · Claude Code plugin", dates: "2025", tags: ("Postgres", "pgvector"), bullets: ("Memory layer where every stored fact traces to its source text.",)),
    (title: "MapMyMath", org: "Procedural maths game · web, iOS, Android", dates: "2024", tags: ("Python", "React/WebGL"), bullets: ("1,320 catalogued exam questions; built solo in five weeks.",)),
  ),
)
