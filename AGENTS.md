# AGENTS.md

Guidance for Codex when reviewing pull requests in this repo. `CLAUDE.md` covers
general engineering conventions for anyone writing code here; this file is
review-specific and tells Codex what's worth flagging in a PR.

## Code Review Rules

### Tests must ship with behavior changes

A PR that changes behavior — new logic, a bug fix, a new project — needs tests
covering it. A bug fix specifically should include a test that would have failed
before the fix. Flag a behavior change with no corresponding test.

Safe path: pure refactors, doc-only changes, and config/scaffolding with no
behavior of its own (e.g. a new template's placeholder files) don't need new
tests.

### Every project Makefile implements build/test/lint/clean

Each `projects/<name>/Makefile` must define `build`, `test`, `lint`, and `clean`
targets, since the root Makefile dispatches to all four unconditionally. A
missing target breaks `make <target>` for the whole monorepo, not just that
project.

Safe path: a target that's a genuine no-op (e.g. `@echo "nothing to lint yet"`)
is fine — the rule is that the target exists and doesn't error, not that it does
real work.

### No imports across projects/ boundaries

Projects under `projects/` are independent by design — no shared build graph, no
cross-project dependency resolution. Flag any import, require, or path reference
from one `projects/<name>/` into another `projects/<other>/`.

Safe path: shared code that two projects both need belongs in a real shared
library, not a sideways import — but that's a repo-structure discussion, not
something a single PR should quietly work around.

### Performance claims need a measured number

If a PR's description or comments claim something is faster, more efficient, or
better on some performance axis, that claim needs a before/after number from an
actual profiler or benchmark run in the PR itself. "Should be faster" without a
measurement is not evidence.

Safe path: this only applies to a PR that makes a performance claim. Don't ask
for benchmarks on ordinary feature or scaffolding PRs that make no such claim.

## Out of scope

Formatting, linting, and type errors are `make lint`'s job, not a review
finding — a lint-ignore comment in the code is an explicit signal to leave it
alone.
