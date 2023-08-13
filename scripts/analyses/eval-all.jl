using MiseEnPage
using CitableObject

f = joinpath(pwd(), "scripts", "analyses", "pages-to-eval.txt")
urns = map(ln -> Cite2Urn(ln), readlines(f))

scorepairs = map(urns) do u
    println("Scoring $(objectcomponent(u))...")
    pg = msPage(u)
    (prox = score_by_proximity_y(pg), zone = score_by_zones(pg))
end

proxscores = map(pr -> delimited(pr[:prox]), scorepairs)
zonescores = map(pr -> delimited(pr[:zone]), scorepairs)

hdr = "urn,successes,failures\n"
proxfile = joinpath(pwd(), "scripts", "analyses", "proximityscores.csv")
open(proxfile,"w") do io
    write(io, hdr * join(proxscores, "\n"))
end
zonesfile = joinpath(pwd(),"scripts", "analyses", "zonescores.csv")
open(zonesfile,"w") do io
    write(io, hdr * join(zonescores, "\n"))
end

