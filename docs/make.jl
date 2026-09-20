using VortexCollisions
using Documenter

DocMeta.setdocmeta!(VortexCollisions, :DocTestSetup, :(using VortexCollisions); recursive = true)

makedocs(;
    modules = [VortexCollisions],
    authors = "Michael Kraus",
    repo = "https://github.com/JuliaPlasma/VortexCollisions.jl/blob/{commit}{path}#{line}",
    sitename = "VortexCollisions.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://JuliaPlasma.github.io/VortexCollisions.jl",
        edit_link = "main",
        assets = String[]
    ),
    pages = [
        "Home" => "index.md",
        "Library" => "library.md"
    ]
)

deploydocs(;
    repo = "github.com/JuliaPlasma/VortexCollisions.jl",
    devbranch = "main"
)
