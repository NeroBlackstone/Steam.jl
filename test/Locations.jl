@testset "Locations" begin
	countries = get_countries()
    @test length(countries)!=0
    
    states = get_states("CN")
    @test length(states)!=0

    cites = get_cities("CN","01")
    @test length(cites)!=0
end