@testset "ISteamUser" begin
	players = get_player_summaries([76561199080934614,76561198288810576])
	@test length(players) ==2
	friends = get_friend_list(76561199080934614)
	@test length(friends)!=0
end