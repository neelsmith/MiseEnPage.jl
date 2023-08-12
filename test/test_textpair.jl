@testset "Test text pair structure" begin
    cex = hmt_cex()
    page_urn = Cite2Urn("urn:cite2:hmt:msA.v1:112r")
    pg = msPage(page_urn, data = cex)
    pr = pg.scholia[1]
   
    @test MiseEnPage.scholion_height(pr) == 0.04
    @test MiseEnPage.scholion_top(pr) == 0.113
    @test MiseEnPage.iliad_top(pr) == 0.307
end