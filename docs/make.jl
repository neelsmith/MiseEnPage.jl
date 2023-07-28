# Build docs from root directory of repository:
#
#     julia --project=docs/ docs/make.jl
#
# Serve docs from repository root:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, MiseEnPage

makedocs(
    sitename = "MiseEnPage.jl",
    pages = [
        "Overview" => "index.md",
        "Visualizing page layout" => "viz.md",
        "API documentation" => "apis.md"
        ]
    )


deploydocs(
    repo = "github.com/neelsmith/MiseEnPage.jl.git",
) 