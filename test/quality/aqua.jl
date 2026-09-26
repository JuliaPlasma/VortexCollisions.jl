using Aqua
using VortexCollisions
using Test

Aqua.test_all(VortexCollisions; deps_compat = (; broken = true))   # issue #2
