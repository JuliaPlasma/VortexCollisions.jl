
using VortexCollisions
using Test

include("../helpers/functions.jl")

function u_test_sinx4(x, y)
    sin(x)^4
end

function mfunc_one!(u, m, grid)
    m .= 1
end

function hfunc_ϕ!(u, ϕ, h, grid)
    h .= ϕ
end

function testNullspace(utest, mfunc, hfunc)
    M = 64
    N = 64

    grid = Grid2d(M, N)
    u = get_field(grid)
    divJ = get_field(grid)
    ft = FourierTransform(grid)
    op = FokkerPlanckOperator(grid, ft; mfunc = mfunc, hfunc = hfunc)

    evaluate_function_on_grid(grid, utest, u)

    collision_operator!(op, u, divJ)

    @test maximum(abs.(divJ)) == 0.0
end

testNullspace(u_test_sinx4, mfunc_one!, hfunc_ϕ!)

@testset "Fourier convolution kernel matches the trapezoidal kernel" begin
    # the serial branch of `collision_operator!` computes the trapezoidal reference
    @test VortexCollisions.nworkers() == 1

    M = 64
    N = 64

    grid = Grid2d(M, N)
    u = get_field(grid)
    divJ = get_field(grid)
    ft = FourierTransform(grid)
    op = FokkerPlanckOperator(grid, ft)

    evaluate_function_on_grid(grid, (x, y) -> exp(-((x - π)^2 + (y - π)^2) / 2), u)

    collision_operator!(op, u, divJ)

    𝔽 = [copy(F) for F in op.𝔽]
    𝔻 = [copy(D) for D in op.𝔻]

    foreach(A -> fill!(A, NaN), op.𝔽)
    foreach(A -> fill!(A, NaN), op.𝔻)

    VortexCollisions.convolution_kernel_fourier!(
        op.grid, op.ft, 1, N, op.wfunc, op.Dh, op.Dû, op.m̂, op.𝔽, op.𝔻)

    @test all(isapprox.(op.𝔽, 𝔽; rtol = 1e-10))
    @test all(isapprox.(op.𝔻, 𝔻; rtol = 1e-10))
end
