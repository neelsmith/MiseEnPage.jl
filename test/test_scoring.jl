@testset "Test scoring of proximity and zone models" begin
    cex = hmt_cex()
    page_urn = Cite2Urn("urn:cite2:hmt:msA.v1:112r")
    pg = msPage(page_urn, data = cex)
    proximity_score = score_by_proximity_y(pg; threshhold = 0.1)
    @test successes(proximity_score) == 3
    @test failures(proximity_score) == 9
    @test success_rate(proximity_score) == 0.25

    score_15 = score_by_proximity_y(pg; threshhold = 0.15)
    @test successes(score_15) == 7
    @test failures(score_15) == 5
    @test  success_rate(score_15) == 0.583
end