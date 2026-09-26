using SafeTestsets

const GROUPS = isempty(ARGS) ? ["core", "slow"] : ARGS

if "core" in GROUPS
    @safetestset "Aqua" include("quality/aqua.jl")
    @safetestset "Grid" include("grid.jl")
    @safetestset "Fourier transform" include("fourier_transform.jl")
    @safetestset "Fourier operators" include("fourier_operators.jl")
    @safetestset "Fourier quadrature" include("fourier_quadrature.jl")
    @safetestset "Trapezoidal quadrature" include("trapezoidal_quadrature.jl")
    @safetestset "Fokker-Planck operator" include("fokker_planck_operator.jl")
    @safetestset "Fokker-Planck operator kernel" include("fokker_planck_operator_kernel.jl")
end
