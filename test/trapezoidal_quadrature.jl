using VortexCollisions
using Test

function u_test(x, y, σ)
    exp(- ((x-π)^2 + (y-π)^2) / (2σ^2))
end

function testTrapezoidalQuadrature()
    M = 64
    N = 64

    σ = 0.5

    grid = Grid2d(M, N)
    u = get_field(grid)

    for i in 1:M
        for j in 1:N
            u[i, j] = u_test(grid.x[i], grid.y[j], σ)
        end
    end

    uint = trapezoidal_quadrature(u, u, grid)

    @test uint - π*σ^2 ≈ zero(eltype(u)) atol=1E-14
end

testTrapezoidalQuadrature()

@testset "Trapezoidal quadrature of a matrix of weights" begin
    grid = Grid2d(16, 16)
    u = get_field(grid)

    u .= [u_test(x, y, 0.5) for x in grid.x, y in grid.y]

    w = reshape([u, 3u, 2u, 4u], 2, 2)
    q = trapezoidal_quadrature(u, u, grid)

    @test trapezoidal_quadrature(w, u, grid) ≈ [q 2q; 3q 4q]
    @test trapezoidal_quadrature(w, [u, 2u], grid) ≈ [5q, 11q]
end
