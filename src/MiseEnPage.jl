module MiseEnPage

using JuMP
using HiGHS

using HmtArchive
using HmtArchive.Analysis
using CitablePhysicalText
using CitableObject
using CitableText
using CitableImage
using CitableBase

using Documenter
using DocStringExtensions

include("mspage.jl")
include("textpair.jl")

export MSPage, msPage

end # module MiseEnPage
