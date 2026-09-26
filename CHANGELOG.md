# Release Notes

All notable changes to VortexCollisions.jl.

This package is pre-1.0, so *every* minor release is potentially breaking in the sense of
[SemVer](https://semver.org) for `0.x` versions. The sections below name what actually
changed, so that a compat-only bump can be told apart from a rename or a change in results.

This file was started on 2026-08-31 and deliberately holds no entries. Nothing has been
released yet — there are no tags, and `Project.toml` stands at `0.1.0` — so the development
history that predates this file is in `git log` alone, reaching back to 2017. It is named as a
gap rather than reconstructed, because a changelog assembled after the fact loses exactly the
reasoning that makes it worth keeping.

## [Unreleased] — targeting 0.1.0

### New Features

- **Continuous integration.** The repository had no `.github` directory at all; it now carries the
  same `CI.yml`, `CompatHelper.yml`, `Documenter.yml` and `TagBot.yml` as every other repository in
  the tree — the test suite over two Julia versions and three operating systems, a doctest job, and
  coverage reporting.
- **A documentation build.** `docs/` previously held one untracked PDF; it now has `make.jl`,
  `Project.toml` and a two-page manual, so `Documenter` has something to build and to deploy.
  That PDF — `effective_collision_operatos.pdf`, a personal note from April 2017 on a
  pseudospectral algorithm for the collision operators of Morrison, *Physica D* 1986 — **has now
  moved to `Projects/Metriplectic Relaxation/`**, whose subject it is. Nothing referenced it:
  neither `make.jl` nor any page under `docs/src` mentions it, so the documentation build is
  unaffected. It was tracked only by the commit that added this documentation build, and it is
  in `git log` from there.
- **The test suite follows the tree's test convention.** The test dependencies are in
  `test/Project.toml`, and `Project.toml` has no `[extras]` or `[targets]`. `runtests.jl` lists
  each test file as a `@safetestset` in the `core` group, so each file runs in its own module. The
  test files have the names of the `src/` files they test, and the shared functions are in
  `test/helpers/functions.jl`. `test/quality/aqua.jl` runs Aqua, and `[compat]` gains
  `Distributed = "1"`, `LinearAlgebra = "1"` and `SharedArrays = "1"` so that its compat-bounds
  check passes (issue #2). The kernel test defines its own `mfunc_one!` and `hfunc_ϕ!`
  with the `grid` argument that the operator passes, because it no longer sees the methods of the
  other test file. `runprofiler.jl` and `runtimings.jl` are timing scripts, not tests, and move from
  `test/` to `scripts/`. Nothing under `src/` changes.

### Bug Fixes

- **The documentation build named a branch that does not exist.** `docs/make.jl` set both
  `edit_link` and `devbranch` to `"master"`, while the default branch is `main` and the remote
  carries no `master` at all. So `deploydocs` never deployed the development documentation, and
  every "Edit on GitHub" link in the built manual pointed at a dead path. Both now say `"main"`.

### Breaking Changes

- **The repository moved from `DDMGNI` to the `JuliaPlasma` organisation.** It is now
  `github.com/JuliaPlasma/VortexCollisions.jl`, and the documentation deploys to
  `JuliaPlasma.github.io/VortexCollisions.jl`. GitHub redirects the old path, so an existing
  clone and an `]add` of the old URL both keep working — but they resolve through a redirect
  rather than to the real location, so pinned URLs are worth updating. `README.md`, `docs/make.jl`
  and `docs/src/index.md` name the new path.
- **A `[compat]` section, where there was none.** `julia = "1.10"` — the LTS and the floor across
  the tree, and the field the CI matrix resolves its lower entry from — plus bounds for the four
  non-stdlib dependencies: `AbstractFFTs = "1"`, `FFTW = "1"`, `HDF5 = "0.17"`,
  `ProgressMeter = "1"`, matching what the manifest resolves today. An unbounded dependency is free
  to break the package on its next breaking release.
