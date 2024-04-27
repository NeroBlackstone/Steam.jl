@testset "ISteamUser" begin
    key=parse_api_key()
	players = get_player_summaries(key,[76561198202322923,76561198075263524])
    @show dump(get_player_summaries(key,[76561198202322923]))
	@test length(players) ==2
end