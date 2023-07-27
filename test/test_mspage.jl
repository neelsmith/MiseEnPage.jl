@testset "Test collecting page data" begin
    src = hmt_cex()
    pageurn = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
    pg = msPage(pageurn; data = src)
    @test pg isa MSPage

    dse = hmt_dse(src)[1]
    pg_bbox = MiseEnPage.iliadboundbox(pg.iliadlines, dse)
    @test pg_bbox == (left = 0.144, top = 0.213, right = 0.545, bottom = 0.697)

    # Test a page with no page bounding box
    @test msPage(Cite2Urn("urn:cite2:hmt:msA.v1:11v"); data = src) |> isnothing
    # Test a page with no scholia (Bessarion replacement page)
    noscholiapg = msPage(Cite2Urn("urn:cite2:hmt:msA.v1:69r"); data = src)
    @test noscholiapg isa MSPage
end


