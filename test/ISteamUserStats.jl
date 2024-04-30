@testset "ISteamUserStats" begin
	achievements = get_global_achievement_percentages_for_app(440)
	@test length(achievements) != 0
	player_achievements = get_player_achievements(76561198309475951,553850;l="japanese")
	dump(player_achievements)
end