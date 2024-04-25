@testset "apikey" begin
  @test length(parse_api_key())==32
  @test_throws "Invalid Steam web API key." parse_api_key("3B06FA589E249A9457E8")
  
  @test_throws DomainError Steam.is_above_zero(-1,0,1)
    
  key = parse_api_key()
end