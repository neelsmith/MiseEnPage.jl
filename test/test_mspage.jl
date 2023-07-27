@testset "Test collecting page data" begin
    pageurn = Cite2Urn("urn:cite2:hmt:msA.v1:55r")
    pg = msPage(pageurn)
    @test pg isa MSPage

    dse = hmt_dse()[1]
    pg_bbox = MiseEnPage.iliadbounds(pg.iliadlines, dse)
    @test pg_bbox == (left = 0.144, top = 0.213, right = 0.545, bottom = 0.697)

end


