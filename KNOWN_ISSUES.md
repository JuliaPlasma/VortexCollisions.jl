# Known issues

## KI-1 · `convolution_kernel_fourier!` allocates its buffers in the generator

- **Kind:** pre-existing defect.
- **Where:** `src/fokker_planck_operator.jl`, the `@generated function convolution_kernel_fourier!`.
- **Claim:** the generator body allocates `g`, `w` and `ŵ` and interpolates them into the returned
  expression. Every call with the same argument types shares one mutable buffer, and Julia may run
  a generator more than once. The Julia manual requires a generator body to be pure.
- **Evidence:** the generator lines assign `g`, `w` and `ŵ` before the `quote`, and the body uses
  `$g`, `$w` and `$ŵ`. Found by a critic of the change that fixed the `undef` constructor.
