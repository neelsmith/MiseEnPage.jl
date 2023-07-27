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


include("images/imgservice.jl")
include("textpair.jl")
include("mspage.jl")
include("models/proximity_model.jl")
include("models/zones_model.jl")



export MSPage, msPage
export model_by_proximity
export model_by_zones

end # module MiseEnPage
