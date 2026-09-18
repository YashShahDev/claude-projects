# projects-monorepo

A monorepo for holding independent projects, in any language, side by side.
Each project lives in its own folder under `projects/` with its own
`Makefile` exposing a common set of targets, and the root `Makefile`
dispatches to all (or one) of them.

## Structure

```
.
├── Makefile              # root dispatcher: build/test/lint/clean across all projects
├── CLAUDE.md             # engineering conventions: tests, performance, comments, quality
├── projects/             # one folder per project, each independent
│   └── <name>/
│       ├── Makefile      # build, test, lint, clean targets for this project
│       └── ...           # the project's own code, in whatever language
├── templates/            # starter Makefile+README per language, used by `make new`
│   ├── generic/
│   ├── python/
│   ├── node/
│   ├── go/
│   └── rust/
└── scripts/
    └── new_project.sh    # scaffolds projects/<name> from a template
```

Projects are independent: no shared build graph, no cross-project dependency
resolution. Each one just needs to implement `build`, `test`, `lint`, and
`clean` in its own `Makefile` (a no-op is fine to start).

Shared engineering conventions — testing expectations, the measure-then-optimize
rule for performance, comment style, and the quality bar — live in
[`CLAUDE.md`](CLAUDE.md) and apply to every project. A project can override them
for itself with its own `projects/<name>/CLAUDE.md`.

## Usage

```sh
make list                        # list all projects
make new PROJECT=foo LANG=python # scaffold projects/foo from templates/python
make build                       # run `build` in every project
make build PROJECT=foo           # run `build` in projects/foo only
make test  [PROJECT=foo]
make lint  [PROJECT=foo]
make clean [PROJECT=foo]
```

Supported `LANG` values for `make new` are the folder names under
`templates/` (`generic`, `python`, `node`, `go`, `rust`). Add a new folder
there to support another language.

## When to reach for something heavier

This setup is intentionally simple: plain folders and Makefiles, no
submodules, no shared build graph. If projects start needing shared
libraries with fine-grained incremental builds, cross-language dependency
tracking, or remote build caching, that's the point to introduce a real
build system (e.g. Bazel) instead of growing the Makefiles into one. Nothing
here blocks that migration — each project's own build stays encapsulated
behind its `Makefile` targets regardless of what orchestrates them.
