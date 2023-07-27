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

using Downloads
using Images
using FileIO

using Documenter
using DocStringExtensions


include("utils.jl")

include("textpair.jl")
include("mspage.jl")

include("images/imgservice.jl")

export MSPage, msPage

end # module MiseEnPage
