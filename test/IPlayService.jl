@testset "IPlayerService" begin
    games = get_owned_games(76561198202322923;include_appinfo=true,include_played_free_games=true)
    @test lenth(games.game)!=0
end