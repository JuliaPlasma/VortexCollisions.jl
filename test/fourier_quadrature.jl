using VortexCollisions
using Test

function u_test(x, y, σ)
    exp(- ((x-π)^2 + (y-π)^2) / (2σ^2))
end

function testFourierQuadrature()
    M = 64
    N = 64

    σ = 0.5

    grid = Grid2d(M, N)
    ft = FourierTransform(grid)
    u = get_field(grid)
    û = get_trans(ft)

    for i in 1:M
        for j in 1:N
            u[i, j] = u_test(grid.x[i], grid.y[j], σ)
        end
    end

    prfft!(ft, u, û)
    ûint = fourier_quadrature(û, û, ft.μ, grid)

    @test real(ûint) - π*σ^2 ≈ zero(eltype(u)) atol=1E-15
    @test imag(ûint) ≈ zero(eltype(u)) atol=eps()
end

testFourierQuadrature()

@testset "Fourier quadrature of a matrix of weights" begin
    grid = Grid2d(16, 16)
    ft = FourierTransform(grid)
    u = get_field(grid)
    û = get_trans(ft)

    u .= [u_test(x, y, 0.5) for x in grid.x, y in grid.y]

    prfft!(ft, u, û)

    μ = ft.μ
    w = reshape([μ, 3μ, 2μ, 4μ], 2, 2)
    q = fourier_quadrature(μ, û, û, grid)

    @test fourier_quadrature(w, û, û, grid) ≈ [q 2q; 3q 4q]
    @test fourier_quadrature(w, [û, 2û], û, grid) ≈ [5q, 11q]
end
