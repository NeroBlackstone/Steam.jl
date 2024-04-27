@testset "ISteamUser" begin
	init_key()
	players = get_player_summaries([76561199080934614,76561198288810576])
	@test length(players) ==2
end