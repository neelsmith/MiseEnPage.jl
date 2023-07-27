@testset "Test image loading functions" begin
    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA047RN_0048@0.0163,0.0648,0.8325,0.8648")

    rgb_data = MiseEnPage.load_rgb(imgurn)
    @test rgb_data isa Matrix{RGB{N0f8}}
    rgba_data = MiseEnPage.load_rgba(imgurn)
    @test rgba_data isa Matrix{RGBA{N0f8}}
end