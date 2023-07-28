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
using Luxor

using Documenter
using DocStringExtensions


include("images/imgservice.jl")
include("textpair.jl")
include("mspage_constructor.jl")
include("mspage.jl")
include("models/proximity_model.jl")
include("models/zones_model.jl")
include("images/luxorpage.jl")
include("scoring/scores.jl")


export MSPage, msPage
export pageurn, rv, imageurn, 
iliadlines, iliadrange, 
page_bbox_roi, iliad_bbox_roi

export load_rgba, dimensions

export PageScore

export model_by_proximity
export model_by_zones


export pagebox_luxor, iliadbox_luxor

end # module MiseEnPage
