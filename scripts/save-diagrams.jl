using MiseEnPage
using CitableObject
using Luxor

outputdir = joinpath(pwd(), "scratch","imgs")


function pngthis(mspage::MSPage, img, outdir)
    @info("Draw png for $(pageurn(mspage))...")
    dimm = dimensions(img)
    pgurn = pageurn(mspage)
    fname = string(objectcomponent(pgurn), ".png")
    outputfile = joinpath(outdir, fname)

    Drawing(dimm[:w], dimm[:h], outputfile)
    origin() 
    background("white") # hide
    MiseEnPage.visualize_proximity_y_luxor(mspage, img)
    finish()
end

function pngpage(pgurn::Cite2Urn, outdir)
    mspage = msPage(pgurn)
    img = load_rgba(mspage, w = 600)
    pngthis(mspage, img, outdir)

end


filelist = "/Users/nsmith/Dropbox/__hmt/noerrors.cex"
pglist =  map(readlines(filelist)) do row
    if isempty(row)
        nothing
    else
        cols = split(row, "|")
        Cite2Urn(cols[1])
    end
end

filtered = filter(p -> ! isnothing(p), pglist)
for pgurn in filtered

    @info("Png page $(pgurn)")
    pngpage(pgurn, outputdir)
end
