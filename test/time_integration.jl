using VortexCollisions
using Test

@testset "update_field!" begin
    f = reshape(collect(1.0:15.0), 3, 5)
    u₀ = reshape(collect(15.0:-1.0:1.0), 3, 5)
    u₁ = fill(NaN, 3, 5)

    VortexCollisions.update_field!(f, u₀, u₁, 0.5)

    @test u₁ == u₀ .+ 0.5 .* f
end
