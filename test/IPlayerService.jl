@testset "IPlayerService" begin
    owned_games = get_owned_games(76561198202322923;include_appinfo=true,include_played_free_games=true)
    @test length(owned_games.games)!=0
    recent_games = get_recently_played_games(76561198309475951,count=2)
    @test recent_games.total_count>=0
end