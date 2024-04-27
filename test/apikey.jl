@testset "apikey" begin
  @test length(parse_api_key())==32
  
  @test_throws DomainError SteamWebAPIs.is_above_zero(-1,0,1)
    
  key = parse_api_key()
end