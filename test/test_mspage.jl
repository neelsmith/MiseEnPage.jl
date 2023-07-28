@testset "Test collecting page data" begin
    src = hmt_cex()
    page_u = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
    pg = msPage(page_u; data = src)
    @test pg isa MSPage

    @test pageurn(pg) == page_u
    @test rv(pg) == :recto
    @test imageurn(pg) == Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA055RN_0056")
    @test iliadrange(pg) == CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msA:4.184-4.208")

    i_lines = iliadlines(pg)
    @test length(i_lines) == 25

    @test page_bbox_roi(pg) == 
    (left = 0.065, top = 0.07, right = 0.884, bottom = 0.94)


    dse = hmt_dse(src)[1]
    pg_bbox = MiseEnPage.iliadboundbox(pg.iliadlines, dse)
    @test pg_bbox == (left = 0.144, top = 0.213, right = 0.545, bottom = 0.697)

    # Test a page with no page bounding box
    @test msPage(Cite2Urn("urn:cite2:hmt:msA.v1:11v"); data = src) |> isnothing

    # Test a page with no scholia (Bessarion replacement page)
    noscholiapg = msPage(Cite2Urn("urn:cite2:hmt:msA.v1:69r"); data = src)
    @test noscholiapg isa MSPage
    
end


