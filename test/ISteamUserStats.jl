@testset "ISteamUserStats" begin
	achievements = get_global_achievement_percentages_for_app(440)
	@test length(achievements) != 0
end