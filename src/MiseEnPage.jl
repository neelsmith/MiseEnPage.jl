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
textpairs,
page_bbox_roi, page_top, page_bottom, page_right, page_left,
iliad_bbox_roi

export load_rgba, dimensions

export PageScore
export model_by_proximity, score_by_proximity
export model_by_zones, score_by_zones
export delimited, resultsfromdelimited


export pagebox_luxor, iliadbox_luxor

end # module MiseEnPage
