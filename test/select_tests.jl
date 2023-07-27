using Pkg
Pkg.activate("..")

using MiseEnPage

using CitableObject, CitableText
using HmtArchive.Analysis


using Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
