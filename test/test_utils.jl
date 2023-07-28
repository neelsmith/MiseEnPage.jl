@testset "Test extracting data from image URNs" begin
    goodurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA055RN_0056@0.065,0.0695,0.8188,0.8704")
    @test MiseEnPage.imagefloats(goodurn) == (left = 0.065, top = 0.07, width = 0.819, height = 0.87)
    @test MiseEnPage.imagefloats(goodurn; digits = 2) == (left = 0.06, top = 0.07, width = 0.82, height = 0.87)


    nosubref = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA055RN_0056")
    @test isnothing(MiseEnPage.imagefloats(nosubref))

    @test_throws ArgumentError MiseEnPage.imagefloats(Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA055RN_0056@BAD_SUBREF_SYNTAX"))
end