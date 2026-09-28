# Known issues

### K1 · `convolution_kernel_fourier!` allocates its buffers in the generator

- **location:** `src/fokker_planck_operator.jl:270`
- **evidence:** the generator body assigns `g`, `w` and `ŵ` at lines 277–291, before the `quote`,
  and the returned expression uses `$g`, `$w` and `$ŵ`. Every call with the same argument types
  shares one mutable buffer, and Julia may run a generator more than once. The Julia manual
  requires a generator body to be pure.
- **kind:** defect
- **found:** 2026-09-28
